#include <QFile>
#include <QtConcurrent>
#include <QFuture>
#include <QTextStream>

#include "Util.h"

// QDataStream& operator<<(QDataStream &out, const std::vector<std::shared_ptr<Record>> &vec) {
//     out.setVersion(QDataStream::Qt_6_5);
//     quint32 numData = vec.size();
//     out << numData;
//     for (int i(0); i<numData; ++i) {
//         out<<vec[i].get()->name()<<vec[i].get()->score()<<vec[i].get()->duration();
//     }
//     return out;
// }

// QDataStream& operator>>(QDataStream &in , std::vector<std::shared_ptr<Record>> &vec) {
//     in.setVersion(QDataStream::Qt_6_5);
//     quint32 numData;
//     in>>numData;
//     for (int i{0}; i<numData; ++i) {
//         QString name;
//         in>>name;
//         quint32 score, duration;
//         in>>score>>duration;
//         auto record = std::make_shared<Record>(name, score, duration);
//         vec.push_back(std::move(record));
//     }
//     return in;
// }

Util::Util() {
}

Util::~Util() {
}

// bool Util::writeVectorToFile(const QString& fileName, const std::vector<std::shared_ptr<Record> > &vec) const {
//     bool result = true;
//     QFile file(fileName);
//     if (!file.open(QIODevice::WriteOnly)) {
//         qWarning("Util::writeVectorToFile(): could not open file");
//         result = false;
//     } else {
//         QDataStream out(&file);
//         out<<vec;
//         file.close();
//     }
//     return result;
// }

// std::vector<std::shared_ptr<Record>> Util::readVectorFromFile(const QString& fileName) const {
//     std::vector<std::shared_ptr<Record>> vec;
//     vec.clear();

//     QFile file(fileName);
//     if (!file.open(QIODevice::ReadOnly)) {
//         qWarning("Util::readVectorFromFile(): could not open file");
//     } else if (file.size() == 0) {
//         qWarning("Util::readVectorFromFile(): could not load data from file due to file is empty");
//     } else {
//         QDataStream in(&file);
//         in>> vec;
//         file.close();
//     }
//     return vec;
// }

// bool Util::asyncWriteVectorToFile(const QString& fileName, const std::vector<std::shared_ptr<Record> >& vec) const {
//     QString string = fileName;
//     std::vector<std::shared_ptr<Record>> copy;

//     for (int i{0}; i<vec.size(); ++i) {
//         std::shared_ptr<Record> copyRec = std::make_shared<Record>(*vec[i]);
//         copy.push_back(copyRec);
//     }

//     QFuture<bool> future = QtConcurrent::run(&Util::writeVectorToFile, this, string, copy);
//     return future.result();
// }

// std::vector<std::shared_ptr<Record>> Util::asyncReadVectorFromFile(const QString &fileName) const {
//     QString string = fileName;
//     QFuture<std::vector<std::shared_ptr<Record>>> future = QtConcurrent::run(&Util::readVectorFromFile, this, string);
//     return future.result();
// }

QString Util::readTextFromFile(const QString &fileName) const {
    QFile file(fileName);
    QString result;
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning("Util::readTextFromFile(): could not open file");
    } else if (file.size() == 0) {
        qWarning("Util::readTextFromFile(): could not read data from file due to file is empty");
    } else {
        QTextStream in(&file);
        while (!in.atEnd()) {
            result = in.readAll(); ///Not super best way!!!
        }
        file.close();
    }
    return result;
}

QString Util::asyncReadTextFromFile(const QString &fileName) const {
    QString str = fileName;
    QFuture<QString> future = QtConcurrent::run(&Util::readTextFromFile, this, str);
    return future.result();
}
