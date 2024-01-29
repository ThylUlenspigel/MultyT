#ifndef LOGIC_H
#define LOGIC_H

#include <memory>
#include <QtGlobal>

/*!
 * \brief The Logic class
 * This class contains the game logic.
 */
class Logic
{
public:
    /*!
     * \brief Logic of the game. General score calculation, checking result.
    */
    explicit Logic();
    ~Logic();

    /*!
     * \brief Getter for total score of the game.
     * \return quint32.
    */
    quint32 score();

    /*!
     * \brief Getter for multiplicator. Multiplicator is random value from "lovest-highest" range
     * \param isMultiplicand (bool), true for getting multiplicand, false foe getting multiplier;
     * \param lowest (quint32), the begin of the range for random generation;
     * \param highest (quint32), the end of the range for random generation;
     * \return quint32.
    */
    quint32 multiplicator(const bool isMultiplicand, const quint32 lowest, const quint32 highest) const;

    /*!
     * \brief Function checks the result of multiplication for multiplier.
     * \param result (const int), proposed by gamer' result;
     * \param highest (quint64), the end of interval for random generation;
     * \return true, if result is correct, otherwice false.
    */
    bool isCorrectResult(const quint32 result) const;

    /*!
     * \brief Function resets score and multiplicators.
     * \param result (const int), proposed by gamer' result;
     * \param highest (quint64), the end of interval for random generation;
     * \return true, if result is correct, otherwice false.
    */
    void reset();

private:
    struct Impl;
    std::unique_ptr<Impl> m_impl;
};

#endif // LOGIC_H
