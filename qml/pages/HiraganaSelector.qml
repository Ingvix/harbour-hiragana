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

Item {
    property alias model: hiraganaRepeater.model
    property int selectAll: 0
    property int selectedHiragana: 0
    property int totalHiragana: 0
    property alias labelText: label.text
    property alias columns: hiraganaGrid.columns
    signal setAllHiragana(bool modus)
    signal drawerAnimationFinished
    property bool parentInactive: grid.status === PageStatus.Inactive
    onParentInactiveChanged: if (parentInactive) state = "HideDrawer"
    Component.onCompleted: {
        selectedHiragana = getHiraganaAmount("selected")
        totalHiragana = getHiraganaAmount("total")
    }

    function getHiraganaAmount(condition) {
        var amount = 0
        if (condition === "selected") {
            for(var i = 0; i < model.count; i++) {
                if (model.get(i).hiragana !== "" && hiraganaRepeater.itemAt(i).checked) {
                    amount++
                }
            }
        }
        else if (condition === "total") {
            for(var i = 0; i < model.count; i++) {
                if (model.get(i).hiragana !== "") {
                    amount++
                }
            }
        }

        return amount
    }

    function setAll(modus) {

        if (modus) {
            selectAll = 1
        }
        else {
            selectAll = 2
        }
    }

    id: hiraganaSelector
    width: grid.width
    height: hiraganaHeader.height + hiraganaDrawer.height
    x: - parent.x
    clip: true
    onStateChanged: {
        if (state === "ShowDrawer") {
            silica.contentY = Qt.binding(function() {
                return silica.contentHeight > grid.height ? silica.contentHeight < y + grid.height ? silica.contentHeight - grid.height : y : 0
            })
        }
    }

    onSelectAllChanged: {if (selectAll === 0) {grid.allSet = selectAll}}

    onDrawerAnimationFinished: {
        if (state === "HideDrawer") {
            silica.contentY = silica.contentY // Without this, on hiding, selector contentY goes back to selector's y which is not desirable
        }                                     // Must be set after animations
    }

    RemorseItem {id: remorse}

    Item {
        id: hiraganaDrawer
        y: hiraganaHeader.height
        height: 0
        width: grid.width
        opacity: 0

        Rectangle {
            id: hiraganaColumnBackground
            width: grid.width
            anchors {
                top:hiraganaColumn.top
                topMargin: - Theme.paddingLarge
                bottom: hiraganaColumn.bottom
            }

            gradient: Gradient {
                GradientStop { position: 0.8; color: Theme.rgba(Theme.highlightBackgroundColor, 0.3) }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }

        Column {
            id: hiraganaColumn
            y: Theme.paddingLarge
            width: grid.width
            spacing: Theme.paddingLarge
            height: implicitHeight + Theme.paddingLarge

            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: Theme.paddingMedium

                Button {
                    text: "Select all"
                    onClicked: remorse.execute(hiraganaHeader, "Selecting all " + label.text, function () {hiraganaSelector.selectAll = 1}, 3000)
                }

                Button {
                    text: "Deselect all"
                    onClicked: remorse.execute(hiraganaHeader, "Deselecting all " + label.text, function () {hiraganaSelector.selectAll = 2}, 3000)
                }
            }

            Grid {
                id: hiraganaGrid
                width: parent.width

                Repeater{
                    id: hiraganaRepeater
                    HiraganaSwitch {
                        id: hiraganaSwitch
                        width: hiraganaGrid.width / hiraganaSelector.columns

                        property int selectAll: hiraganaSelector.selectAll
                        onSelectAllChanged: {
                            if (selectAll !== 0) {
                                if (selectAll === 1) {
                                    checked = true
                                }
                                else {
                                    checked = false
                                }

                                save.saveBool(romaji,checked)
                            }
                        }

                        hiraganaLabel.text: hiragana
                        romajiLabel.text: save.getBool("UseKunrei") && hiraganaSelector.model.get(index).kunrei ? kunrei : romaji
                        rowLabel.text: {
                            var current = hiraganaSelector.model.get(index)
                            if (current.row) {
                                if (current.rowRequired) {
                                    if ((save.getBool("UseKunrei") && rowRequired === 2) || (!save.getBool("UseKunrei") && rowRequired === 1)) {
                                        row
                                    }
                                    else ""
                                }
                                else row
                            }
                            else ""
                        }
                        checked: save.getBool(romaji)
                        onCheckedChanged: {
                            if (hiraganaLabel.text !== "") {
                                checked ? selectedHiragana = selectedHiragana + 1 : selectedHiragana = selectedHiragana - 1
                            }
                        }
                        onClicked: {
                            save.saveBool(romaji,checked)
                            hiraganaSelector.selectAll = 0
                        }
                        visible: romaji === "" ? false : true
                    }
                }
            }
        }
    }

    OpacityMask {
        maskSource: Item {
            height: hiraganaDrawer.height
            width: hiraganaDrawer.width
            Rectangle {
                y: silica.contentY < hiraganaSelector.y
                   ? 0
                   : silica.contentY - hiraganaSelector.y
                height: silica.contentY < hiraganaSelector.y
                        ? hiraganaDrawer.height
                        : hiraganaDrawer.height - (silica.contentY - hiraganaSelector.y)
                width: hiraganaDrawer.width
                gradient: Gradient {
                    GradientStop {position: 0.0; color: Theme.rgba(Theme.highlightBackgroundColor, 0.85)}
                    GradientStop {position: Theme.paddingLarge / height}
                }
            }
        }

        source: hiraganaDrawer
        anchors.fill: hiraganaDrawer
    }

    BackgroundItem {
        id: hiraganaHeader
        y: Math.max(0, Math.min(silica.contentY - hiraganaSelector.y, hiraganaSelector.height - hiraganaHeader.height))
        clip: true
        highlighted: pressed
        onClicked: if (hiraganaSelector.state !== "ShowDrawer") {
                       hiraganaSelector.state = "ShowDrawer"
                   }
                   else {
                       hiraganaSelector.state = "HideDrawer"
                   }

        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {position: 0.0; color: Theme.rgba(Theme.highlightBackgroundColor, (hiraganaSelector.state === "ShowDrawer" ? 0.3 : 0.15))}
                GradientStop {position: 1.0; color: Theme.rgba(Theme.highlightBackgroundColor, (hiraganaSelector.state === "ShowDrawer" ? 0.15 : 0))}
            }
        }

        Column {
            anchors {
                right: icon.left
                rightMargin: Theme.paddingMedium
                verticalCenter: parent.verticalCenter
            }

            Label {
                id: label
                font.pixelSize: Theme.fontSizeMedium
                color: hiraganaSelector.state === "ShowDrawer" ? Theme.highlightColor : Theme.primaryColor
            }
            Row {
                id: selectedCountRow
                anchors.right: label.right

                Text {
                    id: selectedCountLabel
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: text === "0 " ? Theme.secondaryHighlightColor : Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter
                    text: selectedHiragana + " "
                    onTextChanged: {
                        valueBehavior.enabled = false
                        scale = 1.3
                        valueBehavior.enabled = true
                        scale = 1
                    }

                    Behavior on scale {
                        id: valueBehavior
                        NumberAnimation {duration: 300; easing.type: Easing.OutQuart}
                    }
                }
                Text {
                    id: totalLabel
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                    text: "<font color='" + Theme.primaryColor + "'>/</font> " + totalHiragana
                }
            }
        }

        Image {
            id: icon
            source: "image://theme/icon-m-down?" + (hiraganaSelector.state === "ShowDrawer" ? Theme.highlightColor : Theme.primaryColor)
            rotation: 90
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: Theme.paddingLarge
            }
        }
    }
    states: [
        State {
            name: "ShowDrawer"
            PropertyChanges {
                target: hiraganaDrawer
                height: hiraganaColumn.height + Theme.paddingLarge
            }

            PropertyChanges {
                target: icon
                rotation: 0
            }
        },
        State {
            name: "HideDrawer"
        }
    ]
    transitions: [
        Transition {
            onRunningChanged: if(!running) {drawerAnimationFinished()}
            to: "ShowDrawer"
            ParallelAnimation {
                NumberAnimation {
                    target: hiraganaDrawer
                    property: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: icon
                    property: "rotation"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        },
        Transition {
            onRunningChanged: if(!running) {drawerAnimationFinished()}
            to: "HideDrawer"
            ParallelAnimation {
                NumberAnimation {
                    target: icon
                    property: "rotation"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    target: hiraganaDrawer
                    property: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    ]
}
