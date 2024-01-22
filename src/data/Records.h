#ifndef RECORDS_H
#define RECORDS_H

#include <QObject>

class Records : public QObject
{
    Q_OBJECT
public:
    explicit Records(QObject *parent = nullptr);

signals:
};

#endif // RECORDS_H
