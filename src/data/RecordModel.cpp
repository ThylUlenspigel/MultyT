#include <QDebug>
#include <QFile>
#include <QtConcurrent>
#include <QFuture>

#include <algorithm>
#include "RecordModel.h"

namespace{
    constexpr int m_maxRecordsAmount = 10;
}

QDataStream& operator<<(QDataStream &out, const std::vector<std::shared_ptr<Record>> &vec) {
    out.setVersion(QDataStream::Qt_6_5);
    quint32 numData = vec.size();
    out << numData;
    for (int i(0); i<numData; ++i) {
        out<<vec[i].get()->name()<<vec[i].get()->score()<<vec[i].get()->duration();
    }
    return out;
}

QDataStream& operator>>(QDataStream &in, std::vector<std::shared_ptr<Record>> &vec ) {
    in.setVersion(QDataStream::Qt_6_5);
    quint32 numData;
    in>>numData;
    for (int i{0}; i<numData; ++i) {
        QString name;
        in>>name;
        quint32 score, duration;
        in>>score>>duration;
        auto record = std::make_shared<Record>(name, score, duration);
        vec.push_back(std::move(record));
    }
    return in;
}


RecordModel::RecordModel(QObject *parent)
    : QAbstractListModel{ parent }
{
    m_roles.insert(Roles::Name_Role, QByteArrayLiteral("name"));
    m_roles.insert(Roles::Score_Role, QByteArrayLiteral("gameScore"));
    m_roles.insert(Roles::Duration_Role, QByteArrayLiteral("gameDuration"));
}

int RecordModel::rowCount(const QModelIndex &parent) const {
    return static_cast<int>(m_records.size());
}

QVariant RecordModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        qWarning() << "PortModel::data: index is not valid: " << index;
        return QVariant{};
    }

    QVariant output;
    const Record& record = *m_records.at(index.row());

    switch (role) {
    case Roles::Name_Role:
        output = record.name();
        break;
    case Roles::Score_Role:
        output = record.score();
        break;
    case Roles::Duration_Role:
        output = record.duration();
        break;
    default:
        break;
    }
    return output;
}

QHash<int, QByteArray> RecordModel::roleNames() const
{
    return m_roles;
}

void RecordModel::addRecord(const QString& name, const quint32 score, const quint32 duration) {
    if (m_records.size() == m_maxRecordsAmount && m_records.back().get()->score()>score) {
        return;
    } else if (m_records.size() < m_maxRecordsAmount
             ||(m_records.size() == m_maxRecordsAmount
                && m_records.back().get()->score()<score) ) {
        beginResetModel();
        auto record = std::make_shared<Record>(name, score, duration);
        m_records.push_back(std::move(record));

        std::sort(m_records.begin(), m_records.end(),[](const std::shared_ptr<Record> r1, const std::shared_ptr<Record> r2) {
                return r1.get()->score() > r2.get()->score();
            });
        if (m_records.size() > m_maxRecordsAmount) {
            m_records.pop_back();
        }
        endResetModel();
    }
}

void RecordModel::swapContent(std::vector<std::shared_ptr<Record>> &vec) {
    m_records.swap(vec);
}

std::shared_ptr<Record> RecordModel::recordByIndex(const int recordIndex) const {
    try {
        return m_records.at(recordIndex);
    } catch (const std::exception& ex) {
        qWarning() << "RecordsModel::recordByIndex: record index error" << ex.what();
    }
    return nullptr;
}

bool RecordModel::readModelFromFile() {
    bool result = true;
    QFile file("records.dat");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("RecordModel::loadFromFile(): could not open records.dat file");
        result = false;
    } else if (isModelFileEmpty()) {
        qWarning("RecordModel::loadFromFile(): could not load data from records.dat, file is empty");
        result = false;
    } else {
       QDataStream in(&file);
       std::vector<std::shared_ptr<Record>> records;
       in>> records;
       beginResetModel();
       m_records.swap(records);
       endResetModel();
       file.close();
    }
    return result;
}

void RecordModel::asyncReadModelFromFile() {
    QFuture<bool> future = QtConcurrent::run(&RecordModel::readModelFromFile, this);
    qInfo() << "Result:" << future.result();
}

bool RecordModel::writeModelToFile() {
    bool result = true;
    QFile file("records.dat");
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning("RecordModel::saveToFile(): could not open records.dat file");
        result = false;
    } else {
        QDataStream out(&file);
        out<<m_records;
        file.close();
    }
    return result;
}

void RecordModel::asyncWriteModelToFile() {
    QFuture<bool> future = QtConcurrent::run(&RecordModel::writeModelToFile, this);
    qInfo() << "Result:" << future.result();
}

bool RecordModel::isEmpty() const {
    return m_records.empty();
}

bool RecordModel::isModelFileEmpty() const {
    QFile file("records.dat");
    return (file.size() == 0);
}
