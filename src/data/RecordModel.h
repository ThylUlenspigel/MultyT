#ifndef RECORDMODEL_H
#define RECORDMODEL_H

#include <vector>
#include <memory>

#include <QAbstractListModel>
#include <QSharedPointer>

#include "Record.h"

/*!
 * \class RecordModel
 * \brief Keeps the list of game records.
 */
class RecordModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        Name_Role = Qt::UserRole + 1,
        Score_Role,
        Duration_Role,
    };

    /*!
     * \brief Record list model
     * \param parent, QObject
     */
    explicit RecordModel(QObject *parent = nullptr);

    // QAbstractItemModel interface
    int rowCount(const QModelIndex &parent = QModelIndex{}) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;


    /*!
     * \brief Function adds new record entity to the model
     * \param name, QString&
     * \param score, const quint32
     * \param duration, const quint32
     */
    void addRecord(const QString& name, const quint32 score, const quint32 duration);

    /*!
     * \brief Function loads the records model from the file-storage
     */
    bool loadFromFile();

    /*!
     * \brief Function saves the records model to the file-storage
     */
    bool saveToFile();

    /*!
     * \brief Function checks if records model is empty or not
     * \return true, if records model is empty, false otherwise
     */
    bool isEmpty() const;

    /*!
     * \brief Function checks if file-storage is empty or not
     * \return true, if file is empty, false otherwise
     */
    bool isSaveFileEmpty() const;

    /*!
     * \brief friend QDataStream operator << .
     * \param out (QDataStream &),
     * \param vec (const std::vector<std::shared_ptr<Record>> &).
     * \return QDataStream& .
    */
    friend QDataStream& operator<<(QDataStream &out, const std::vector<std::shared_ptr<Record>> &vec);

    /*!
     * \brief friend QDataStream operator >> .
     * \param in (QDataStream &),
     * \param vec (std::vector<std::shared_ptr<Record>> &).
     * \return QDataStream& .
    */
    friend QDataStream& operator>>(QDataStream &in , std::vector<std::shared_ptr<Record>> &vec );

private:
    QHash<int, QByteArray> m_roles;
    std::vector<std::shared_ptr<Record>> m_records;
};

#endif // RECORDMODEL_H
