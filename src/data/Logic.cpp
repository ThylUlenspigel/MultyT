#include <QRandomGenerator>

#include "Logic.h"

struct Logic::Impl {
    quint32 m_multiplier;
    quint32 m_multiplicand;
    quint32 m_score;

    bool isCorrectResult(const quint32 result) {
        bool res{false};
        if (m_multiplicand * m_multiplier == result) {
            res = true;
            m_score = m_score + result;
        }
        return res;
    }

    quint32 multiplicator(const bool isMultiplicand, const quint32 lowest, const quint32 highest) {
        quint32 random{0};
        if( lowest <=0 || highest <=0) {
            qWarning("Logic::multiplicator(): lowest and highest values should be more than 0.");
            random = 0;
        } else {
            random =(lowest <= highest)? QRandomGenerator::global()->bounded(lowest, highest)
                                       : QRandomGenerator::global()->bounded(highest, lowest);
            (isMultiplicand)? m_multiplicand = random
                            : m_multiplier = random;
        }
        return random;
    }

    void reset() {
        m_score = 0;
        m_multiplicand = 0;
        m_multiplier = 0;
    }
};

Logic::Logic()
    :  m_impl( new Impl ( ) )
{
    m_impl->m_multiplier = 1;
    m_impl->m_multiplicand = 1;
    m_impl->m_score  = 0;
}

Logic::~Logic()
{
}

quint32 Logic::score() {
    return m_impl->m_score;
}

quint32 Logic::multiplicator(const bool isMultiplicand, const quint32 lowest, const quint32 highest) const {
    return m_impl->multiplicator(isMultiplicand, lowest, highest);
}

bool Logic::isCorrectResult(const quint32 result) const {
    return m_impl->isCorrectResult(result);
}

void Logic::reset() {
    m_impl->reset();
}
