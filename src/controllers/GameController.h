#ifndef GAMECONTROLLER_H
#define GAMECONTROLLER_H

#include <QObject>
#include <memory>

#include "../data/logic.h"
#include "../data/RecordModel.h"

/*!
     * \class GameController
     * \brief The GameController class is a controller for game logic.
     * It is responsible for providing game's statisc, setting and changing
     * game variables (lifes, level, tasks, player name) and start/end game process.
    */
class GameController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(quint32 multiplier     READ multiplier     NOTIFY multiplierChanged)
    Q_PROPERTY(quint32 multiplicand   READ multiplicand   NOTIFY multiplicandChanged)
    Q_PROPERTY(quint32 taskCount      READ taskCount      NOTIFY taskCountChanged)
    Q_PROPERTY(quint32 lifeCount      READ lifeCount      NOTIFY lifeCountChanged)
    Q_PROPERTY(quint32 level          READ level          NOTIFY levelChanged)
    Q_PROPERTY(quint32 score          READ score          NOTIFY scoreChanged)
    Q_PROPERTY(quint32 answerDuration READ answerDuration NOTIFY answerDurationChanged)
    Q_PROPERTY(quint32 gameDuration   READ gameDuration   NOTIFY gameDurationChanged)
    Q_PROPERTY(quint32 status         READ status         NOTIFY statusChanged)

    Q_PROPERTY(QString playerName READ playerName WRITE setPlayerName NOTIFY playerNameChanged)
    Q_PROPERTY(bool    onPause    READ onPause    WRITE setOnPause    NOTIFY onPauseChanged)

    Q_PROPERTY(quint32 maxTasks READ maxTasks CONSTANT)
    Q_PROPERTY(quint32 maxLifes READ maxLifes CONSTANT)

public:
    /*!
     * \brief Enum for check result status
    */
    enum ResultStatus: int {
        Undefinied = -1,
        Wrong,
        Right,
    };
    Q_ENUM(ResultStatus);

    /*!
     * \brief Enum for levels (for avoiding magic numbers)
    */
    enum Levels: int {
        Level_1 = 1,
        Level_2,
        Level_3,
        Level_4,
        Level_5,
    };

    /*!
     * \brief Class Ctor
     * \param logic (std::shared_ptr<Logic>), pointer to game logic class
     * \param parent (QObject *), pointer to QObject parent class
    */
    explicit GameController(std::shared_ptr<Logic> logic, QObject *parent = nullptr);
    virtual ~GameController();

    /*!
     * \brief Getter for multiplier property.
     * \return quint32.
    */
    quint32 multiplier() const;

    /*!
     * \brief Getter for multiplicand property.
     * \return quint32.
    */
    quint32 multiplicand() const;

    /*!
     * \brief Getter for task count property.
     * \return quint32.
    */
    quint32 taskCount() const;

    /*!
     * \brief Getter for life count property.
     * \return quint32.
    */
    quint32 lifeCount() const;

    /*!
     * \brief Getter for level property.
     * \return quint32.
    */
    quint32 level() const;

    /*!
     * \brief Getter for score property.
     * \return quint32.
    */
    quint32 score() const;

    /*!
     * \brief Getter for answer duration property.
     * \return quint32.
    */
    quint32 answerDuration() const;

    /*!
     * \brief Getter for game duration property.
     * \return quint32.
    */
    quint32 gameDuration() const;

    /*!
     * \brief Getter for playe name duration property.
     * \return QString.
    */
    QString playerName() const;

    /*!
     * \brief Getter for status property.
     * \return quint32.
    */
    quint32 status() const;

    /*!
     * \brief Getter for max task property.
     * \return quint32.
    */
    quint32 maxTasks() const;

    /*!
     * \brief Getter for max life property.
     * \return quint32.
    */
    quint32 maxLifes() const;

    /*!
     * \brief Getter for onPause property.
     * \return bool.
    */
    bool onPause() const;

    /*!
     * \brief Function sets default setting depended on the game level.
     * \param level (enum GameController::Levels);
    */
    void startLevel(GameController::Levels level);

    /*!
     * \brief Function updates answerDuration property.
    */
    void updateAnswerDuration();

    /*!
     * \brief Function updates gameDuration property.
    */
    void updateGameDuration();

    /*!
     * \brief Function manges setting related to decreasing life.
    */
    void decreaseLife();

    /*!
     * \brief Using in QML. Function manages setting for starting new game or continue existing games.
     * \param isNewGame (bool), true if starting new game, false - for continue existing game;
    */
    Q_INVOKABLE void startNewGame(const bool isNewGame);

    /*!
     * \brief Using in QML. Function manages setting for end game case.
    */
    Q_INVOKABLE void endGame();

    /*!
     * \brief Using in QML. Setter for onPause property and manages setting for pouse game case.
    */
    Q_INVOKABLE void setOnPause(const bool isOnPause);

    /*!
     * \brief Using in QML. Function manages setting for launching next task case.
    */
    Q_INVOKABLE void nextTask();

    /*!
     * \brief Using in QML. Function checks the result of multiplication.
     * \param value (quint32)
    */
    Q_INVOKABLE void checkResult(quint32 value);

    /*!
     * \brief Using in QML. Setter for playerName property.
     * \param name (QString&)
    */
    Q_INVOKABLE void setPlayerName(const QString& name);

    /*!
     * \brief Using in QML. Function initializes records model
     * from "records.dat" file.
    */
    Q_INVOKABLE void loadRecords();

    /*!
     * \brief Using in QML. Function adds record to records model based.
     * Records are based on values of controller's properties "name",
     * "score" and "duration"
    */
    Q_INVOKABLE void addRecord();

    /*!
     * \brief Using in QML. Function saves records model to
     * "records.dat" file.
    */
    Q_INVOKABLE void saveRecords();

    /*!
     * \brief Getter for recordModel store.
     * \return pointer to record model object
    */
    RecordModel *recordModel();

signals:
    void multiplierChanged(quint32 value);
    void multiplicandChanged(quint32 value);
    void taskCountChanged(quint32 value);
    void lifeCountChanged(quint32 value);
    void levelChanged(quint32 value);
    void scoreChanged(quint32 value);
    void answerDurationChanged(quint32 value);
    void gameDurationChanged(quint32 value);
    void playerNameChanged(QString& name);
    void statusChanged(quint32 status);
    void onPauseChanged();

    void gameStarted();
    void gameEnded();

private:
    std::shared_ptr<Logic> m_logic;
};

#endif // GAMECONTROLLER_H
