#include "GameController.h"
#include <QDebug>
#include <QTimer>

namespace {
    constexpr quint32 m_maxTasks{10};
    constexpr quint32 m_maxLifes{3};
    constexpr quint32 m_timerUpdateInterval{1000};

    constexpr int lowestLevel_1{1};
    constexpr int highestLevel_1{10};

    constexpr int lowestLevel_2{10};
    constexpr int highestLevel_2{15};

    constexpr int lowestLevel_3{10};
    constexpr int highestLevel_3{15};

    constexpr int lowestLevel_4{10};
    constexpr int highestLevel_4{20};

    constexpr int lowestLevel_5{1};
    constexpr int highestLevel_5{25};

    QScopedPointer<QTimer> m_gameTimer  (new QTimer());
    QScopedPointer<QTimer> m_answerTimer(new QTimer());
    QSharedPointer<RecordModel> m_recordModel{new RecordModel()};

    quint32 m_multiplier{1};
    quint32 m_multiplicand{1};
    quint32 m_taskCount{0};
    quint32 m_lifeCount{0};
    GameController::Levels m_level{GameController::Levels::Level_1};
    quint32 m_gameDuration {0};
    quint32 m_answerDuration {0};
    GameController::ResultStatus m_status{GameController::ResultStatus::Undefinied};
    QString m_playerName{""};
    bool m_isOnPause{false};

    const QMap<GameController::Levels, QPair<int,int> > multiplierRangeMap {
        { GameController::Levels::Level_1, { { lowestLevel_1 }, { highestLevel_1 } } },
        { GameController::Levels::Level_2, { { lowestLevel_1 }, { highestLevel_1 } } },
        { GameController::Levels::Level_3, { { lowestLevel_3 }, { highestLevel_3 } } },
        { GameController::Levels::Level_4, { { lowestLevel_4 }, { highestLevel_4 } } },
        { GameController::Levels::Level_5, { { lowestLevel_5 }, { highestLevel_5 } } }
    };

    const QMap<GameController::Levels, QPair<int,int>> multiplicandRangeMap {
        { GameController::Levels::Level_1, { { lowestLevel_1 },{ highestLevel_1 } } },
        { GameController::Levels::Level_2, { { lowestLevel_2 },{ highestLevel_2 } } },
        { GameController::Levels::Level_3, { { lowestLevel_3 },{ highestLevel_3 } } },
        { GameController::Levels::Level_4, { { lowestLevel_4 },{ highestLevel_4 } } },
        { GameController::Levels::Level_5, { { lowestLevel_5 },{ highestLevel_5 } } }
    };

    const QMap<GameController::Levels, int> answerDurationMap {
        { GameController::Levels::Level_1, 30000},
        { GameController::Levels::Level_2, 45000},
        { GameController::Levels::Level_3, 60000},
        { GameController::Levels::Level_4, 75000},
        { GameController::Levels::Level_5, 90000},
    };
}

typedef GameController::Levels Levels;
typedef GameController::ResultStatus Status;

GameController::GameController(std::shared_ptr<Logic> logic, QObject *parent)
    : QObject{parent}
    , m_logic{logic}
{
    m_gameTimer->setInterval(m_timerUpdateInterval);
    m_answerTimer->setInterval(m_timerUpdateInterval);
    connect(m_gameTimer.get(), &QTimer::timeout,this, [this] ( ) {
      updateGameDuration();
    });
    connect(m_answerTimer.get(), &QTimer::timeout,this, [this] ( ) {
        updateAnswerDuration();
    });
}

GameController::~GameController()
{
}

quint32 GameController::multiplier() const {
    return m_multiplier;
}

quint32 GameController::multiplicand() const {
    return m_multiplicand;
}

quint32 GameController::taskCount() const {
    return m_taskCount;
}

quint32 GameController::lifeCount() const {
    return m_lifeCount;
}

quint32 GameController::level() const {
    return static_cast<quint32>(m_level);
}

quint32 GameController::score() const {
    return m_logic->score();
}

quint32 GameController::answerDuration() const {
    return m_answerDuration;
}

quint32 GameController::gameDuration() const {
    return m_gameDuration;
}

QString GameController::playerName() const {
    return m_playerName;
}

quint32 GameController::status() const {
    return static_cast<quint32>(m_status);
}

quint32 GameController::maxTasks() const {
    return m_maxTasks;
}

quint32 GameController::maxLifes() const {
    return m_maxLifes;
}

bool GameController::onPause() const {
    return m_isOnPause;
}

void GameController::startNewGame(const bool isNewGame) {
    m_lifeCount = maxLifes();
    m_taskCount = 0;
    m_gameDuration = 0;
    m_isOnPause = false;
    m_logic->reset();

    isNewGame? startLevel(Levels::Level_1)
             : startLevel(m_level);

    emit lifeCountChanged(maxLifes());
    emit taskCountChanged(m_taskCount);
    emit scoreChanged(m_logic->score());
    emit gameDurationChanged(m_gameDuration);
    emit gameStarted();
}

void GameController::endGame() {
    m_gameTimer.get()->stop();
    m_answerTimer.get()->stop();
    emit gameEnded();
    //TODO add game duration, score  and player name to game records
}

void GameController::setOnPause(const bool isOnPause) {
    if(m_isOnPause != isOnPause) {
        m_isOnPause = isOnPause;
        if (m_isOnPause) {
            m_answerTimer.get()->stop();
            m_gameTimer.get()->stop();
        } else {
            m_answerTimer.get()->start();
            m_gameTimer.get()->start();
        }
        emit onPauseChanged();
    }
}

void GameController::nextTask() {
    m_answerTimer.get()->start();
    m_gameTimer.get()->start();
    m_answerDuration = answerDurationMap.value(m_level);
    m_multiplicand = m_logic->multiplicator(true, multiplicandRangeMap.value(m_level).first,
                                                  multiplicandRangeMap.value(m_level).second);
    m_multiplier = m_logic->multiplicator(false, multiplierRangeMap.value(m_level).first,
                                                 multiplierRangeMap.value(m_level).second);
    m_status = Status::Undefinied;

    emit multiplicandChanged(m_multiplicand);
    emit multiplierChanged(m_multiplier);
    emit statusChanged(static_cast<quint32>(m_status));
    emit answerDurationChanged(m_answerDuration);
}

void GameController::checkResult(quint32 value) {
    m_answerTimer.get()->stop();
    m_gameTimer.get()->stop();

    if (m_logic->isCorrectResult(value)) {
        m_status = Status::Right;
        emit scoreChanged(score());
        emit statusChanged(static_cast<quint32>(m_status));

        m_taskCount++;
        if (m_taskCount > m_maxTasks) {
            m_taskCount = 0;
            int castedLevel = static_cast<int>(m_level);
            castedLevel++;
            (castedLevel > Levels::Level_5)? endGame()
                                           : startLevel(static_cast<Levels>(castedLevel));
        }
        emit taskCountChanged(m_taskCount);
    } else {
        decreaseLife();
    }
}

void GameController::setPlayerName(const QString& name) {
    if(m_playerName != name) {
        m_playerName = name;
        emit playerNameChanged(m_playerName);
    }
}

void GameController::loadRecords() {
    if (!m_recordModel.get()->loadFromFile()) {
        return;
    }
}

void GameController::addRecord() {
    m_recordModel.get()->addRecord(m_playerName, m_logic.get()->score(), m_gameDuration/1000); // duration transferred from msec to sec
}

void GameController::saveRecords() {
    m_recordModel.get()->saveToFile();
}

RecordModel *GameController::recordModel() {
    return m_recordModel.get();
}

void GameController::startLevel(Levels level) {
    if(level>Levels::Level_5) {
        qWarning("GameController::startLevel(): incorrect level.");
    } else {
        m_answerDuration = answerDurationMap.value(level);
        m_level = level;
        emit answerDurationChanged(m_answerDuration);
        emit levelChanged(static_cast<quint32>(m_level));
        nextTask();
    }
}

void GameController::updateAnswerDuration() {
    if (m_answerDuration > 0) {
        m_answerDuration = m_answerDuration - m_timerUpdateInterval;
        emit answerDurationChanged(m_answerDuration);
    } else {
        m_answerTimer.get()->stop();
        m_gameTimer.get()->stop();
        decreaseLife();
    }
}

void GameController::updateGameDuration() {
    m_gameDuration = m_gameDuration + m_timerUpdateInterval;
    emit gameDurationChanged(m_gameDuration);
}

void GameController::decreaseLife() {
    m_lifeCount --;
    if (m_lifeCount > 0) {
        m_answerDuration = answerDurationMap.value(m_level);
        m_status = Status::Wrong;
        emit statusChanged(static_cast<quint32>(m_status));
        emit answerDurationChanged(m_answerDuration);
        emit lifeCountChanged(m_lifeCount);
    } else {
        endGame();
    }
}
