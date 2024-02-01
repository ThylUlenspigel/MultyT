#include <QDebug>
#include <QFile>
#include <QDataStream>

#include <algorithm>
#include "RecordModel.h"

namespace{
    constexpr int m_maxRecordsAmount = 10;
//    QFile m_fileRecords("qrc:/assets/records.dat");
}

QDataStream& operator<<(QDataStream &out, const std::vector<std::shared_ptr<Record>> &vec) {
    quint32 numData = vec.size();
    out << numData;
    for (int i(0); i<numData; ++i) {
        out<<vec[i].get();
    }
    return out;
}

QDataStream& operator>>(QDataStream &in , std::vector<std::shared_ptr<Record>> &vec ) {
    quint32 numData;
    in>>numData;
    for (int i{0}; i<numData; ++i) {
        Record rec;
        in>>rec;
        auto record = std::make_shared<Record>(rec); //Looks not good!!!
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
        auto record = std::make_shared<Record>(name, score, duration);
        m_records.push_back(std::move(record));

        beginResetModel();
        std::sort(m_records.begin(), m_records.end(),[](const std::shared_ptr<Record> r1, const std::shared_ptr<Record> r2) {
            return r1.get()>r2.get();
            });
        if (m_records.size() > m_maxRecordsAmount) {
            m_records.pop_back();
        }
        endResetModel();
    }
}

bool RecordModel::loadFromFile() {
    bool result = true;
    QFile file("qrc:/assets/records.dat");
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("RecordModel::loadFromFile(): could not open assets/records.dat file");
        result = false;
    } else if (isSaveFileEmpty()) {
        qWarning("RecordModel::loadFromFile(): could not load data from assets/records.dat, file is empty");
        result = false;
    } else {
       QDataStream in(&file);
       std::vector<std::shared_ptr<Record>> records;
       in>> records;
       m_records.swap(records);
       file.close();
    }
    return result;
}

bool RecordModel::saveToFile() {
    bool result = true;
    QFile file("qrc:/assets/records.dat");
    if (!file.open(QIODevice::WriteOnly)) {
        qWarning("RecordModel::writeToFile(): could not open assets/records.dat file");
        result = false;
    } else {
        file.resize(0);
        QDataStream out(&file);
        out<<m_records;
        file.close();
    }
    return result;
}

bool RecordModel::isEmpty() const {
    return m_records.empty();
}

bool RecordModel::isSaveFileEmpty() const {
    QFile file("qrc:/assets/records.dat");
    return (file.size() == 0);
}
