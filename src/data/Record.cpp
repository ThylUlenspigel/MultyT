#include "Record.h"

Record::Record(const QString& name, const quint32 score, const quint32 duration)
    : m_name{ name }
    , m_score{ score }
    , m_duration{ duration }
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

quint32 Record::score() const {
    return m_score;
}

void Record::setScore(const quint32 score) {
    if (m_score != score) {
        m_score = score;
    }
}

quint32 Record::duration() const {
    return m_duration;
}

void Record::setDuration(const quint32 duration) {
    if (m_duration != duration) {
        m_duration = duration;
    }
}
