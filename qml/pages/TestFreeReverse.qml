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

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0

Page {
    id: test

    Item {
        id: variable
        property int questions: 0
        property int correct: 0
        property string hiragana: testclass.hiragana()
        property string valuecorrect: testclass.valuecorrect()
        property int sumCorrect: save.getInt("FreeReversrTestCorrect")
        property int sumQuestions: save.getInt("FreeReverseTestQuestions")

        property bool drawingComplete: false
        property bool correctAnswer: false
    }

    Item {
        id: handleQuestions

        function next(){
            testclass.newQuestion()
            variable.valuecorrect = testclass.valuecorrect()
            drawnImage.opacity = 0
        }

        function end(){
            variable.questions++
            variable.sumQuestions++
            if(variable.correctAnswer)
            {
                variable.correct++
                variable.sumCorrect++

            }
            save.saveInt("FreeReverseTestQuestions",variable.sumQuestions)
            save.saveInt("FreeReversrTestCorrect",variable.sumCorrect)
            next()
        }
    }

    SilicaFlickable {
        id: flickable

        PullDownMenu {
            visible: false
        }

        anchors.fill: parent

        PageHeader {
            id: header
            title: "Free Reverse Test"
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
                id: target2
                text: variable.valuecorrect
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeHuge

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

            Rectangle {
                id: canvasRec
                width: Screen.width*2/3
                height: width
                color: Theme.rgba(Theme.highlightDimmerColor, 0.5)
                anchors.horizontalCenter: parent.horizontalCenter
                radius: Theme.paddingMedium
                border.width: Theme.paddingSmall
                border.color: yesButton.containsPress
                       ? Theme.rgba("lawngreen", 0.15)
                       : noButton.containsPress
                         ? Theme.rgba("red", 0.15)
                         : variable.drawingComplete
                           ? Theme.rgba(Theme.secondaryColor, 0.15)
                           : Theme.rgba(Theme.highlightBackgroundColor, 0.15)
                clip: true

                Behavior on border.color {
                    ColorAnimation {duration: 200; easing.type: Easing.InOutQuad}
                }

                Canvas {

                    function clear() {
                        var context = drawnImage.getContext('2d')
                        context.clearRect(0, 0, drawnImage.width, drawnImage.height)
                        clearDrawing = true
                        requestPaint()
                        clearDrawing = false
                    }

                    property int positionX: 0
                    property int positionY: 0
                    property bool clearDrawing: false

                    id: drawnImage
                    anchors {fill: parent; margins: Theme.paddingMedium}

                    renderTarget: Canvas.FramebufferObject
                    antialiasing: true

                    onPaint: {
                        if(!clearDrawing && mouseArea.containsMouse)
                        {
                            var context = getContext('2d')
                            context.lineJoin = "round"
                            context.linecap = "round"
                            context.lineWidth = Theme.paddingMedium
                            context.strokeStyle = Theme.highlightColor
                            context.beginPath()
                            context.moveTo(positionX, positionY)
                            context.lineTo(mouseArea.mouseX, mouseArea.mouseY)
                            context.stroke()

                            var radius = Theme.paddingSmall
                            context.beginPath()
                            context. arc(positionX, positionY,radius,0*Math.PI,2*Math.PI)
                            context.fillStyle = Theme.highlightColor
                            context.fill()
                            positionX = mouseArea.mouseX
                            positionY = mouseArea.mouseY
                        }
                    }

                    Behavior on opacity {
                        SequentialAnimation {
                            NumberAnimation {duration: 200; easing.type: Easing.InOutQuad}
                            ScriptAction {script: drawnImage.clear()}
                            ScriptAction {  // These two scripts are separated because sometimes it seemed to leave some sort of partial or perfect afterimage
                                script: {   // of the previously drawn image that would disappear when starting to draw the next hiragana
                                    parent.enabled = false // This gives the image time to clear in peace before the opacity is changed back to 1.
                                    drawnImage.opacity = 1
                                    parent.enabled = true
                                }
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        height: parent.height
                        width: parent.width
                        anchors.centerIn: parent
                        preventStealing: true
                        hoverEnabled: true
                        enabled: !variable.drawingComplete

                        onPressed: {
                            drawnImage.positionX = mouseX
                            drawnImage.positionY = mouseY
                            drawnImage.requestPaint()
                        }
                        onReleased: {
                            drawnImage.positionX = mouseX
                            drawnImage.positionY = mouseY
                            drawnImage.requestPaint()
                        }

                        onPositionChanged: drawnImage.requestPaint()
                    }
                }
                ColorOverlay {
                    id: colorOverlay
                    opacity: drawnImage.opacity
                    anchors.fill: drawnImage
                    source: drawnImage
                    color: yesButton.containsPress
                           ? "lawngreen"
                           : noButton.containsPress
                             ? "red"
                             : variable.drawingComplete
                               ? Theme.secondaryColor
                               : Theme.highlightColor

                    Behavior on color {
                        ColorAnimation {duration: 200; easing.type: Easing.InOutQuad}
                    }
                }

            }

            Item {
                height: buttonRow.height
                width: parent.width

                Item {
                    id: buttonAnswerItem
                    y: -Theme.paddingLarge
                    height: buttonRow.height + 2 * Theme.paddingLarge
                    width: mainColumn.width
                    opacity: 0

                    Column {
                        id: buttonAnswerColumn
                        spacing: Theme.paddingLarge
                        y: variable.drawingComplete ? -buttonRow.height : Theme.paddingLarge

                        Row {
                            id: buttonRow
                            width: mainColumn.width
                            spacing: Theme.paddingMedium

                            Button {
                                id: button1
                                enabled: !variable.drawingComplete
                                text: "Clear"
                                onClicked: {
                                    drawnImage.clear()
                                }
                            }

                            Button {
                                enabled: !variable.drawingComplete
                                text: "Done"
                                onClicked: {
                                    variable.drawingComplete = true
                                }
                            }
                        }
                        Label {
                            id: remid
                            text: variable.hiragana
                            font.pixelSize: Theme.fontSizeExtraLarge
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Behavior on y {
                            NumberAnimation {
                                onRunningChanged: {
                                    if (running === false && buttonAnswerColumn.y === Theme.paddingLarge) {
                                        variable.hiragana = testclass.hiragana() //So next answer won't be shown during animation
                                    }
                                }

                                duration: 300; easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }

                OpacityMask {
                    source: buttonAnswerItem
                    anchors.fill: buttonAnswerItem
                    maskSource: Rectangle {
                        id: mask
                        height: buttonAnswerItem.height
                        width: buttonAnswerItem.width
                        gradient: Gradient {
                            GradientStop {position: 0.0; color: "transparent"}
                            GradientStop {position: Theme.paddingLarge / mask.height}
                            GradientStop {position: (Theme.paddingLarge + buttonRow.height) / mask.height}
                            GradientStop {position: 1.0; color: "transparent"}
                        }
                    }
                }
            }
        }

        ViewPlaceholder {
            id: holder
            text: "Close enough?"
            anchors{top: mainColumn.bottom}
            enabled: variable.drawingComplete

            onTextChanged: {
                holderBehavior.enabled = false
                scale = 1.2
                holderBehavior.enabled = true
                scale = 1
            }
            Behavior on scale {
                id: holderBehavior
                enabled: false
                NumberAnimation {duration: 300; easing.type: Easing.OutQuart}
            }
        }

        Row {
            width: parent.width
            opacity: holder.opacity
            spacing: Theme.paddingMedium
            anchors{top: holder.bottom; left: parent.left; right: parent.right; margins: Theme.paddingLarge}

            Button {
                id:yesButton
                width: parent.width/2
                enabled: variable.drawingComplete
                text: "Yes"
                color: "lawngreen"
                onClicked: {
                    variable.correctAnswer = true
                    handleQuestions.end()
                    variable.drawingComplete = false
                }
            }

            Button {
                id: noButton
                width: parent.width/2
                enabled: variable.drawingComplete
                text: "No"
                color: "red"
                onClicked: {
                    variable.correctAnswer = false
                    handleQuestions.end()
                    variable.drawingComplete = false
                }
            }
        }
    }
}

