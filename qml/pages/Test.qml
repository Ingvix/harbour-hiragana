/*
  Copyright (C) 2014,2016 Marcus Soll
  Copyright (C) 2013 Jolla Ltd.
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

import QtQuick 2.5
import Sailfish.Silica 1.0

Page {
    id: test

    Item {
        id: variable
        property int questions: 0
        property int correct: 0
        property int rightanswer: testclass.correct()
        property bool answered: false
        property string hiragana: testclass.hiragana()
        property var valueArray: [testclass.one(), testclass.two(), testclass.three(), testclass.four(), testclass.five(), testclass.six()]
        property int sumCorrect: save.getInt("TestCorrect")
        property int sumQuestions: save.getInt("TestQuestions")
    }

    Item {
        id: handleQuestions

        function next(){
            holder.enabled = false
            variable.answered = false
            testclass.newQuestion()
            variable.hiragana = testclass.hiragana()
            variable.rightanswer = testclass.correct()
            variable.valueArray = [testclass.one(), testclass.two(), testclass.three(), testclass.four(), testclass.five(), testclass.six()]
        }

        function end(i){
            variable.questions++
            variable.sumQuestions++
            if(i === variable.rightanswer)
            {
                variable.correct++
                variable.sumCorrect++
            }
            save.saveInt("TestQuestions",variable.sumQuestions)
            save.saveInt("TestCorrect",variable.sumCorrect)
            variable.answered = true
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        contentHeight: mainColumn.height

        PageHeader {
            id: header
            title: "Test"
        }

        Column {
            id: mainColumn
            spacing: Theme.paddingLarge

            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                leftMargin: Theme.paddingLarge
                rightMargin: Theme.paddingLarge
            }

            Stats {}

            Label {
                id: target
                text: variable.hiragana
                font.pixelSize: Theme.fontSizeHuge
                anchors.horizontalCenter: parent.horizontalCenter

                onTextChanged: {
                    targetBehavior.enabled = false
                    scale = 1.2
                    targetBehavior.enabled = true
                    scale = 1
                }
                Behavior on scale {
                    id: targetBehavior
                    enabled: false
                    NumberAnimation {duration: 300; easing.type: Easing.OutQuart}
                }
            }

            Grid {
                columns: 2
                spacing: Theme.paddingLarge

                Repeater {
                    model: 6
                    Button {
                        property bool answered: variable.answered
                        property bool isCorrectButton: (index + 1 === variable.rightanswer)
                        property color afterAnswerColor: Theme.primaryColor

                        id: answerButton
                        onAnsweredChanged: {
                            if (answered) {
                                if (index + 1 === variable.rightanswer) {
                                    colorBehavior.enabled = true
                                    color = Qt.binding(function() {return colorChangeTimer.color})
                                    colorChangeTimer.start()
                                }
                            }
                            else {
                                colorBehavior.enabled = false
                                color = Theme.primaryColor
                                colorChangeTimer.stop()
                                afterAnswerColor = Theme.primaryColor
                                enabled = Qt.binding(function() {return color !== Theme.primaryColor ? true : !answered})
                                sizeBehavior.enabled = false
                                scale = 1.085
                                sizeBehavior.enabled = true
                                scale = 1
                            }
                        }
                        enabled: color !== Theme.primaryColor ? true : !answered
                        text: variable.valueArray[index]

                        Behavior on scale {
                            id: sizeBehavior
                            enabled: false
                            NumberAnimation {duration: 300; easing.type: Easing.OutQuart}
                        }

                        color: Theme.primaryColor
                        onColorChanged: {
                            if (!colorBehavior.enabled) {
                                sizeBehavior.enabled = false
                                scale = 1.085
                                sizeBehavior.enabled = true
                                scale = 1
                            }
                        }

                        Behavior on color {
                            id: colorBehavior
                            ColorAnimation {duration: 200; easing.type: Easing.InOutQuad}
                        }

                        onClicked: {
                            if (!colorChangeTimer.running && color === Theme.primaryColor) {
                                if (index + 1 !== variable.rightanswer) {
                                    afterAnswerColor = "red"
                                    holder.text = "Wrong!"
                                    nextArea.failAnimationRunning = true
                                }
                                else {
                                    afterAnswerColor = "lawngreen"
                                    holder.text = "Correct!"
                                }
                                colorBehavior.enabled = true
                                handleQuestions.end(index + 1)
                                color = Qt.binding(function() {return colorChangeTimer.color})
                                colorChangeTimer.start()
                                enabled = colorChangeTimer.running || color !== Theme.primaryColor
                            }
                        }

                        Timer {
                            property color color: Theme.primaryColor
                            property int loops: 0
                            id: colorChangeTimer
                            interval: 300
                            repeat: true
                            onRunningChanged: {
                                color = parent.afterAnswerColor
                                if (!running) {
                                    nextArea.failAnimationRunning = false
                                    loops = 0
                                }
                                else if (save.getBool("LabelsEnabled"))holder.enabled = true
                            }

                            onTriggered: {
                                color = color === Theme.primaryColor ? parent.afterAnswerColor : Theme.primaryColor
                                loops++
                                if (parent.isCorrectButton && Qt.colorEqual(parent.afterAnswerColor, "lawngreen")) {
                                    if (loops === 5) {
                                        holder.enabled = false
                                    }
                                    if (loops === 6) {
                                        if (save.getBool("NextAfterCorrect")) {
                                            colorBehavior.enabled = false
                                            handleQuestions.next()
                                        }
                                        else {
                                            holder.text = "Tap anywhere for next question"
                                            holder.enabled = true
                                        }
                                        stop()
                                    }
                                }
                                else {
                                    if (loops === 6) {
                                        holder.enabled = false
                                    }
                                    if (loops === 7) {
                                        if (parent.isCorrectButton && !Qt.colorEqual(parent.afterAnswerColor, "lawngreen")) {
                                            colorBehavior.enabled = false
                                            parent.color = "lawngreen"
                                            holder.text = "Tap anywhere for next question"
                                            holder.enabled = true
                                        }
                                        stop()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        ViewPlaceholder {
            id: holder
            enabled: false
            anchors {
                top: mainColumn.bottom
                topMargin: Theme.paddingLarge
            }
        }
    }
    MouseArea {
        property bool failAnimationRunning
        id: nextArea
        enabled: variable.answered
        anchors.fill: parent
        onClicked: if (!failAnimationRunning) handleQuestions.next()
    }
}
