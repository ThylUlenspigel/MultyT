#include "Record.h"

bool Record::operator ==(const Record &rec) {
    return (m_score == rec.score() );
}

bool Record::operator !=(const Record &rec) {
    return ( *this == rec )? false : true;
}

bool Record::operator >(const Record &rec) {
    return (m_score > rec.score() );
}

bool Record::operator <(const Record &rec) {
    return ( *this > rec )? false : true;
}

Record& Record::operator =( const Record &rhs) {
    if( this == &rhs) return *this;
    m_name  = rhs.m_name;
    m_score  = rhs.m_score;
    m_duration  = rhs.m_duration;
    return *this;
}


QDataStream &operator<<(QDataStream &out, const Record &rec) {
    out.setVersion(QDataStream::Qt_6_5);
    return out<<rec.name()<<rec.score()<<rec.duration();
}

QDataStream& operator>>(QDataStream &in, Record &rec) {
    in.setVersion(QDataStream::Qt_6_5);
    QString name;
    quint32 score, duration;
    in>>name;
    in>>score>>duration;
    rec.setName(name);
    rec.setScore(score);
    rec.setDuration(duration);
    return in;
}


Record::Record(const QString& name, const quint32 score, const quint32 duration/*, QObject *parent*/)
    : m_name{ name }
    , m_score{ score }
    , m_duration{ duration }
{
}

Record::Record()
{
}

Record::Record(const Record &copy)
    : m_name{ copy.m_name }
    , m_score{ copy.m_score }
    , m_duration{ copy.m_duration }
{
}

Record::~Record()
{

}

QString Record::name() const {
    return m_name;
}

void Record::setName(const QString& name) {
    if (m_name != name) {
        m_name = name;
    }
}

quint32 Record::score() const
{
    return m_score;
}

void Record::setScore(const quint32 score)
{
    if (m_score != score) {
        m_score = score;
    }
}

quint32 Record::duration() const
{
    return m_duration;
}

void Record::setDuration(const quint32 duration)
{
    if (m_duration != duration) {
        m_duration = duration;
    }
}
