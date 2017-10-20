/*
  Copyright (C) 2014 Marcus Soll
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "testclass.h"
#include <QTime>

Testclass::Testclass(QObject *parent) :
    QObject(parent)
{

}

void Testclass::initialise()
{
    elementlist.clear();
    _question = 0;
    _lastCorrect = "";
    _lastHiragana = "";
}

void Testclass::add(QString romaji, QString hiragana)
{
    ListElement e;
    e.Romaji = romaji;
    e.Hiragana = hiragana;
    e.Question = 0;

    elementlist.append(e);
}

void Testclass::newQuestion()
{
    bool test;
    int amount = elementlist.size();
    qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));
    _correct = (qrand()%6)+1;
    _question++;

    for(int i=1; i <=6; i++)
    {
        test = true;
        do{
            int random = qrand()%amount;
            ListElement e = elementlist.at(random);
            if(e.Question != _question)
            {
                e.Question = _question;
                test = false;
                switch(i)
                {
                case 1:
                    _one = e.Romaji;
                    _one_hiragana = e.Hiragana;
                    break;
                case 2:
                    _two = e.Romaji;
                    _two_hiragana = e.Hiragana;
                    break;
                case 3:
                    _three = e.Romaji;
                    _three_hiragana = e.Hiragana;
                    break;
                case 4:
                    _four = e.Romaji;
                    _four_hiragana = e.Hiragana;
                    _valuecorrect = _four;
                    break;
                case 5:
                    _five = e.Romaji;
                    _five_hiragana = e.Hiragana;
                    break;
                case 6:
                    _six = e.Romaji;
                    _six_hiragana = e.Hiragana;
                    break;
                default:
                    throw "Something went terribly wrong!";
                }
                elementlist.replace(random, e);
            }
        }while(test);
    }

    test = true;

    do{
        _correct = (_correct%6)+1;

        switch(_correct)
        {
        case 1:
            if(_one != _lastCorrect && _one_hiragana != _lastHiragana)
            {
                _hiragana = _one_hiragana;
                _valuecorrect = _one;
                _lastHiragana = _one_hiragana;
                _lastCorrect = _one;
                test = false;
            }
            break;
        case 2:
            if(_two != _lastCorrect && _two_hiragana != _lastHiragana)
            {
                _hiragana = _two_hiragana;
                _valuecorrect = _two;
                _lastHiragana = _two_hiragana;
                _lastCorrect = _two;
                test = false;
            }
            break;
        case 3:
            if(_three != _lastCorrect && _three_hiragana != _lastHiragana)
            {
                _hiragana = _three_hiragana;
                _valuecorrect = _three;
                _lastHiragana = _three_hiragana;
                _lastCorrect = _three;
                test = false;
            }
            break;
        case 4:
            if(_four != _lastCorrect && _four_hiragana != _lastHiragana)
            {
                _hiragana = _four_hiragana;
                _valuecorrect = _four;
                _lastHiragana = _four_hiragana;
                _lastCorrect = _four;
                test = false;
            }
            break;
        case 5:
            if(_five != _lastCorrect && _five_hiragana != _lastHiragana)
            {
                _hiragana = _five_hiragana;
                _valuecorrect = _five;
                _lastHiragana = _five_hiragana;
                _lastCorrect = _five;
                test = false;
            }
            break;
        case 6:
            if(_six != _lastCorrect && _six_hiragana != _lastHiragana)
            {
                _hiragana = _six_hiragana;
                _valuecorrect = _six;
                _lastHiragana = _six_hiragana;
                _lastCorrect = _six;
                test = false;
            }
            break;
        default:
            throw "Something went terribly wrong!";
        }
    }while(test);
}

QString Testclass::hiragana()
{
    return _hiragana;
}

QString Testclass::one()
{
    return _one;
}

QString Testclass::two()
{
    return _two;
}

QString Testclass::three()
{
    return _three;
}

QString Testclass::four()
{
    return _four;
}

QString Testclass::five()
{
    return _five;
}

QString Testclass::six()
{
    return _six;
}

int Testclass::correct()
{
    return _correct;
}

bool Testclass::testPossible()
{
    return 6 <= elementlist.size();
}

QString Testclass::valuecorrect()
{
    return _valuecorrect;
}

QString Testclass::one_hiragana()
{
    return _one_hiragana;
}

QString Testclass::two_hiragana()
{
    return _two_hiragana;
}

QString Testclass::three_hiragana()
{
    return _three_hiragana;
}

QString Testclass::four_hiragana()
{
    return _four_hiragana;
}

QString Testclass::five_hiragana()
{
    return _five_hiragana;
}

QString Testclass::six_hiragana()
{
    return _six_hiragana;
}

QString Testclass::toLower(QString s)
{
    return s.toLower();
}

bool Testclass::sameString(QString s, QString t)
{
    return s.compare(t, Qt::CaseInsensitive) == 0;
}
