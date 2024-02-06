#ifndef UTIL_H
#define UTIL_H

//#include <vector>
//#include <memory>

//#include <QDataStream>

//#include "../data/Record.h"
#include <QString>

class Util
{
public:
    explicit Util();
    ~Util();

    // /*!
    //  * \brief Function writes the vector with Records* to the file with proper name.
    //  * \param fileName (const QString& )
    //  * \param vec (const std::vector<std::shared_ptr<Record>>& )
    //  * \return true, if froye wrote sucessfully, false otherwice
    //  */
    // bool writeVectorToFile(const QString& fileName, const std::vector<std::shared_ptr<Record>> &vec) const;

    // /*!
    //  * \brief Function reads Records data from file to the vector with Records*.
    //  * \param fileName (const QString& )
    //  * \return std::vector<std::shared_ptr<Record>>
    //  */
    // std::vector<std::shared_ptr<Record>> readVectorFromFile(const QString& fileName) const;

    // /*!
    //  * \brief Function asynchronously writes the vector with Records* to the file with proper name.
    //  * \param fileName (const QString& )
    //  * \param vec (const std::vector<std::shared_ptr<Record>>& )
    //  * \return true, if froye wrote sucessfully, false otherwice
    //  */
    // bool asyncWriteVectorToFile(const QString& fileName, const std::vector<std::shared_ptr<Record>> &vec) const;

    // /*!
    //  * \brief Function asynchronously reads Records data from file to the vector with Records*.
    //  * \param fileName (const QString& )
    //  * \return std::vector<std::shared_ptr<Record>>
    //  */
    // std::vector<std::shared_ptr<Record>> asyncReadVectorFromFile(const QString& fileName) const;

    /*!
     * \brief Function reads text from file to the string.
     * \param fileName (const QString& )
     * \return QString
     */
    QString readTextFromFile(const QString& fileName) const;

    /*!
     * \brief Function asynchronously reads text from file to the string.
     * \param fileName (const QString& )
     * \return QString
     */
    QString asyncReadTextFromFile(const QString& fileName) const;

    // /*!
    //  * \brief friend QDataStream operator << .
    //  * \param out (QDataStream &),
    //  * \param vec (const std::vector<std::shared_ptr<Record>> &).
    //  * \return QDataStream& .
    // */
    // friend QDataStream& operator<<(QDataStream &out, const std::vector<std::shared_ptr<Record>> &vec);

    // /*!
    //  * \brief friend QDataStream operator >> .
    //  * \param in (QDataStream &),
    //  * \param vec (std::vector<std::shared_ptr<Record>> &).
    //  * \return QDataStream& .
    // */
    // friend QDataStream& operator>>(QDataStream &in , std::vector<std::shared_ptr<Record>> &vec);

};

#endif // UTIL_H
