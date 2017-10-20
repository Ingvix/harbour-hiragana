/*
  Copyright (C) 2014 Marcus Soll
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
    allowedOrientations: defaultAllowedOrientations

    Item {
        id: variable
        property int questions: 0
        property int correct: 0
        property bool answered: false
        property string hiragana: testclass.hiragana()
        property string valuecorrect: testclass.valuecorrect()
        property int sumCorrect: save.getInt("FreeTestCorrect")
        property int sumQuestions: save.getInt("FreeTestQuestions")
    }

    Item {
        id: handleQuestions

        function next(){
            variable.answered = false
            colorChangeTimer.stop()
            holder.enabled = false
            testclass.newQuestion()
            variable.valuecorrect = testclass.valuecorrect()
            input.color = Qt.binding(function() {return input.errorHighlight
                                                 ? "#ff4d4d"
                                                 : (input.highlighted ? Theme.highlightColor : Theme.primaryColor)})
        }


        function end(){
            variable.questions++
            variable.sumQuestions++
            var correct = false
            if(testclass.sameString(variable.valuecorrect, input.text))
            {
                variable.correct++
                variable.sumCorrect++
                correct = true
            }
            save.saveInt("FreeTestQuestions",variable.sumQuestions)
            save.saveInt("FreeTestCorrect",variable.sumCorrect)
            variable.answered = true
            if(correct)
            {
                holder.text = "Correct!"
                colorChangeTimer.color = "lawngreen"
                colorChangeTimer.dimmerColor = "green"
                colorChangeTimer.start()
            }
            else
            {
                holder.text = "Wrong!"
                colorChangeTimer.color = "red"
                colorChangeTimer.dimmerColor = "darkred"
                nextArea.failAnimationRunning = true
                colorChangeTimer.start()
            }
        }
    }

    SilicaFlickable {

        PullDownMenu {
            visible: false
        }

        anchors.fill: parent

        PageHeader {
            id: header
            title: "Free Test"
        }

        Stats {
            id: stats
            anchors {
                left: parent.left
                leftMargin: Theme.paddingLarge
                top: header.bottom
            }
            scale: test.isLandscape
                   ? implicitWidth > (input.x - 2 * Theme.paddingLarge)
                     ? (input.x - 2 * Theme.paddingLarge) / implicitWidth
                     : 1
            : implicitWidth > (parent.width - (Theme.paddingMedium + 2 * Theme.paddingLarge))
            ? (parent.width - (Theme.paddingMedium + 2 * Theme.paddingLarge)) / implicitWidth
            : 1
        }

        Label {
            id: target
            text: variable.hiragana
            font.pixelSize: Theme.fontSizeHuge
            anchors {
                top: test.isLandscape ? header.bottom : stats.bottom
                topMargin: test.isLandscape ? 0 : Theme.paddingLarge
                horizontalCenter: parent.horizontalCenter
            }

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

        TextField {
            id: input
            focus: !variable.answered && !sizeAnimation.running
            onFocusChanged: {
                if (focus) {
                    focus = Qt.binding(function() {return !variable.answered && !sizeAnimation.running})
                }
            }

            placeholderText: "Romaji"
            EnterKey.enabled: acceptableInput
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: handleQuestions.end()
            scale: variable.answered ? 1.5 : 1
            width: Screen.width / 3
            anchors {
                top: target.bottom
                topMargin: Theme.paddingLarge
                horizontalCenter: parent.horizontalCenter
            }
            horizontalAlignment: TextInput.AlignHCenter
            readOnly: variable.answered || sizeAnimation.running
            inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
            validator: RegExpValidator {regExp: /.{1,}/}

            Behavior on color {
                id: colorBehavior
                ColorAnimation {duration: 200; easing.type: Easing.InOutQuad}
            }
            Behavior on scale {
                id: sizeBehavior
                NumberAnimation {
                    id: sizeAnimation
                    duration: 300
                    easing.type: Easing.InOutQuad
                    onRunningChanged: {
                        if (!variable.answered && !running) {
                            input.text = ""
                            variable.hiragana = testclass.hiragana()
                        }
                    }
                }
            }
            Behavior on opacity {
                NumberAnimation {duration: 200; easing.type: Easing.InOutQuad}
            }
        }


        ViewPlaceholder {
            id: holder
            enabled: false
            text: "Tap anywhere for next question"
            anchors {
                top: input.bottom
                topMargin: Theme.paddingLarge
            }
        }
    }

    Timer {
        property color color
        property color dimmerColor
        property int loops: 0
        id: colorChangeTimer
        interval: 300
        repeat: true
        onRunningChanged: {
            input.color = color
            if (!running) {
                nextArea.failAnimationRunning = false
                loops = 0
            }
            else if (save.getBool("LabelsEnabled"))holder.enabled = true
        }

        onTriggered: {
            loops++
            if (loops === 5) {
                if (Qt.colorEqual(color, "red")) {
                    input.opacity = 0
                }
                holder.enabled = false
            }

            if (loops === 6) {
                color = "lawngreen"
                input.text = variable.valuecorrect
                input.opacity = 1
                holder.text = "Tap anywhere for next question"
                holder.enabled = true
                stop()
            }
            else {
            input.color = input.color === dimmerColor ? color : dimmerColor
            }
        }
    }

    MouseArea {
        property bool failAnimationRunning: false
        id: nextArea
        enabled: variable.answered
        anchors.fill: parent
        onClicked: if (!failAnimationRunning) handleQuestions.next()
    }

    Timer {
        id: nextTimer
        interval: 1000
        onTriggered: handleQuestions.next()
    }
}

