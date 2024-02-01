#ifndef RECORD_H
#define RECORD_H

#include <QObject>
#include <QDataStream>

/*!
 * \class Record
 * \brief The Record entity class to keep the record data (name, score and duration)
*/
class Record
{
public:
    explicit Record(const QString& name, const quint32 score, const quint32 duration);

    explicit Record();

    Record(const Record &copy);

    ~Record();
    /*!
     * \brief Getter for player's name.
     * \return QString (players's name).
    */
    QString name() const;

    /*!
      * \brief Setter for player's name.
      * \param name (QString&).
     */
    void setName(const QString& name);

    /*!
      * \brief Getter for player's score.
      * \return quint32 (player's score).
     */
    quint32 score() const;

    /*!
      * \brief Setter for game's score.
      * \param score (quint32).
     */
    void setScore(const quint32 score);

    /*!
      * \brief Getter for game total.
      * \return quint32 (game's duration).
     */
    quint32 duration() const;

    /*!
      * \brief Setter for game's duration.
      * \param duartion (quint32).
     */
    void setDuration(const quint32 duration);

    /*!
     * \brief friend QDataStream operator << .
     * \param out (QDataStream &),
     * \param rec (const Record &).
     * \return QDataStream& .
    */
    friend QDataStream& operator<<(QDataStream &out, const Record &rec );

    /*!
     * \brief friend QDataStream operator >> .
     * \param in (QDataStream &),
     * \param rec (Record &).
     * \return QDataStream& .
    */
    friend QDataStream& operator>>(QDataStream &in, Record &rec );

    /*!
     * \brief Operator == .
     * \param rec (const Record &).
     * \return bool, true if equal, false otherwise.
    */
    bool operator == ( const Record &rec );

    /*!
     * \brief Operator != .
     * \param rec (const Record &).
     * \return bool, true if not equal, false otherwise.
    */
    bool operator != ( const Record &rec );

    /*!
     * \brief Operator > .
     * \param rec (const Record &).
     * \return bool, true if more, false otherwise.
    */
    bool operator >  ( const Record &rec );

    /*!
     * \brief Operator < .
     * \param rec (const Record &).
     * \return bool, true if less, false otherwise.
    */
    bool operator < ( const Record &rec );

    /*!
     * \brief Operator = .
     * \param rhs (const Record &).
     * \return Record&.
    */
    Record& operator =( const Record &rhs);

private:
    quint32 m_score{};
    quint32 m_duration{};
    QString m_name{};
};

#endif // RECORD_H
