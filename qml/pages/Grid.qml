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

Page {
    id: grid

    property int allSet: 0
    property int selected: {monographSelector.selectedHiragana
                            + diacriticSelector.selectedHiragana
                            + digraphSelector.selectedHiragana
                            + digraphDiacriticSelector.selectedHiragana}
    property int total: {monographSelector.totalHiragana
                        + diacriticSelector.totalHiragana
                        + digraphSelector.totalHiragana
                        + digraphDiacriticSelector.totalHiragana}
    property var selectorArray: [monographSelector, diacriticSelector, digraphSelector, digraphDiacriticSelector]

    onAllSetChanged: selectorArray.forEach(function(item) {item.selectAll = allSet})

    ListModel {
        id: monographModel
        ListElement {hiragana: "あ"; romaji: "a"}
        ListElement {hiragana: "い"; romaji: "i"}
        ListElement {hiragana: "う"; romaji: "u"}
        ListElement {hiragana: "え"; romaji: "e"}
        ListElement {hiragana: "お"; romaji: "o"}
        ListElement {hiragana: "か"; romaji: "ka"}
        ListElement {hiragana: "き"; romaji: "ki"}
        ListElement {hiragana: "く"; romaji: "ku"}
        ListElement {hiragana: "け"; romaji: "ke"}
        ListElement {hiragana: "こ"; romaji: "ko"}
        ListElement {hiragana: "さ"; romaji: "sa"}
        ListElement {hiragana: "し"; romaji: "shi"; kunrei: "si"}
        ListElement {hiragana: "す"; romaji: "su"}
        ListElement {hiragana: "せ"; romaji: "se"}
        ListElement {hiragana: "そ"; romaji: "so"}
        ListElement {hiragana: "た"; romaji: "ta"}
        ListElement {hiragana: "ち"; romaji: "chi"; kunrei: "ti"}
        ListElement {hiragana: "つ"; romaji: "tsu"; kunrei: "tu"}
        ListElement {hiragana: "て"; romaji: "te"}
        ListElement {hiragana: "と"; romaji: "to"}
        ListElement {hiragana: "な"; romaji: "na"}
        ListElement {hiragana: "に"; romaji: "ni"}
        ListElement {hiragana: "ぬ"; romaji: "nu"}
        ListElement {hiragana: "ね"; romaji: "ne"}
        ListElement {hiragana: "の"; romaji: "no"}
        ListElement {hiragana: "は"; romaji: "ha"}
        ListElement {hiragana: "ひ"; romaji: "hi"}
        ListElement {hiragana: "ふ"; romaji: "fu"; kunrei: "hu"}
        ListElement {hiragana: "へ"; romaji: "he"}
        ListElement {hiragana: "ほ"; romaji: "ho"}
        ListElement {hiragana: "ま"; romaji: "ma"}
        ListElement {hiragana: "み"; romaji: "mi"}
        ListElement {hiragana: "む"; romaji: "mu"}
        ListElement {hiragana: "め"; romaji: "me"}
        ListElement {hiragana: "も"; romaji: "mo"}
        ListElement {hiragana: "や"; romaji: "ya"}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: "ゆ"; romaji: "yu"}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: "よ"; romaji: "yo"}
        ListElement {hiragana: "ら"; romaji: "ra"}
        ListElement {hiragana: "り"; romaji: "ri"}
        ListElement {hiragana: "る"; romaji: "ru"}
        ListElement {hiragana: "れ"; romaji: "re"}
        ListElement {hiragana: "ろ"; romaji: "ro"}
        ListElement {hiragana: "わ"; romaji: "wa"}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: "を"; romaji: "wo"; kunrei: "o"; row: "W-row"; rowRequired: 2}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: ""; romaji: ""}
        ListElement {hiragana: "ん"; romaji: "n"}
    }

    ListModel {
        id: diacriticModel
        ListElement {hiragana: "が"; romaji: "ga"}
        ListElement {hiragana: "ぎ"; romaji: "gi"}
        ListElement {hiragana: "ぐ"; romaji: "gu"}
        ListElement {hiragana: "げ"; romaji: "ge"}
        ListElement {hiragana: "ご"; romaji: "go"}
        ListElement {hiragana: "ざ"; romaji: "za"}
        ListElement {hiragana: "じ"; romaji: "ji"; kunrei: "zi"; row: "Z-row"; rowRequired: 1}
        ListElement {hiragana: "ず"; romaji: "zu"}
        ListElement {hiragana: "ぜ"; romaji: "ze"}
        ListElement {hiragana: "ぞ"; romaji: "zo"}
        ListElement {hiragana: "だ"; romaji: "da"}
        ListElement {hiragana: "ぢ"; romaji: "ji"; kunrei: "zi"; row: "D-row"}
        ListElement {hiragana: "づ"; romaji: "zu"; row: "D-row"}
        ListElement {hiragana: "で"; romaji: "de"}
        ListElement {hiragana: "ど"; romaji: "do"}
        ListElement {hiragana: "ば"; romaji: "ba"}
        ListElement {hiragana: "び"; romaji: "bi"}
        ListElement {hiragana: "ぶ"; romaji: "bu"}
        ListElement {hiragana: "べ"; romaji: "be"}
        ListElement {hiragana: "ぼ"; romaji: "bo"}
        ListElement {hiragana: "ぱ"; romaji: "pa"}
        ListElement {hiragana: "ぴ"; romaji: "pi"}
        ListElement {hiragana: "ぷ"; romaji: "pu"}
        ListElement {hiragana: "ぺ"; romaji: "pe"}
        ListElement {hiragana: "ぽ"; romaji: "po"}
    }

    ListModel {
        id: digraphModel
        ListElement {hiragana: "きゃ"; romaji: "kya"}
        ListElement {hiragana: "きゅ"; romaji: "kyu"}
        ListElement {hiragana: "きょ"; romaji: "kyo"}
        ListElement {hiragana: "しゃ"; romaji: "sha"; kunrei: "sya"}
        ListElement {hiragana: "しゅ"; romaji: "shu"; kunrei: "syu"}
        ListElement {hiragana: "しょ"; romaji: "sho"; kunrei: "syo"}
        ListElement {hiragana: "ちゃ"; romaji: "cha"; kunrei: "tya"}
        ListElement {hiragana: "ちゅ"; romaji: "chu"; kunrei: "tyu"}
        ListElement {hiragana: "ちょ"; romaji: "cho"; kunrei: "tyo"}
        ListElement {hiragana: "にゃ"; romaji: "nya"}
        ListElement {hiragana: "にゅ"; romaji: "nyu"}
        ListElement {hiragana: "にょ"; romaji: "nyo"}
        ListElement {hiragana: "ひゃ"; romaji: "hya"}
        ListElement {hiragana: "ひゅ"; romaji: "hyu"}
        ListElement {hiragana: "ひょ"; romaji: "hyo"}
        ListElement {hiragana: "みゃ"; romaji: "mya"}
        ListElement {hiragana: "みゅ"; romaji: "myu"}
        ListElement {hiragana: "みょ"; romaji: "myo"}
        ListElement {hiragana: "りゃ"; romaji: "rya"}
        ListElement {hiragana: "りゅ"; romaji: "ryu"}
        ListElement {hiragana: "りょ"; romaji: "ryo"}
    }

    ListModel {
        id: digraphsDiacriticsModel
        ListElement {hiragana: "ぎゃ"; romaji: "gya"}
        ListElement {hiragana: "ぎゅ"; romaji: "gyu"}
        ListElement {hiragana: "ぎょ"; romaji: "gyo"}
        ListElement {hiragana: "じゃ"; romaji: "ja"; kunrei: "zya"; row: "Z-row"}
        ListElement {hiragana: "じゅ"; romaji: "ju"; kunrei: "zyu"; row: "Z-row"}
        ListElement {hiragana: "じょ"; romaji: "jo"; kunrei: "zyo"; row: "Z-row"}
        ListElement {hiragana: "ぢゃ"; romaji: "ja"; kunrei: "zya"; row: "D-row"}
        ListElement {hiragana: "ぢゅ"; romaji: "ju"; kunrei: "zyu"; row: "D-row"}
        ListElement {hiragana: "ぢょ"; romaji: "jo"; kunrei: "zyo"; row: "D-row"}
        ListElement {hiragana: "びゃ"; romaji: "bya"}
        ListElement {hiragana: "びゅ"; romaji: "byu"}
        ListElement {hiragana: "びょ"; romaji: "byo"}
        ListElement {hiragana: "ぴゃ"; romaji: "pya"}
        ListElement {hiragana: "ぴゅ"; romaji: "pyu"}
        ListElement {hiragana: "ぴょ"; romaji: "pyo"}
    }

    Item {
        id: startTest

        property bool showerror: false
        /**
          * 0 = normal test
          * 1 = reverse test
          * 2 = free test
          * 3 = free reverse test
          */
        property int modus: 0

        function startTest() {
            modus = selectModus.currentIndex
            initialiseTest()
        }

        function initialiseTest() {
            testclass.initialise()

            var modelArray = [monographModel, diacriticModel, digraphModel, digraphsDiacriticsModel]

            modelArray.forEach(function(item) {
                for(var i = 0; i < item.count; i++) {
                    var hiragana = item.get(i).hiragana
                    var romaji = item.get(i).romaji
                    var kunrei = item.get(i).kunrei
                    var rowRequired = item.get(i).rowRequired
                    var row = item.get(i).row
                    if (romaji !== "") {
                        if (save.getBool(romaji)) {
                            if (save.getBool("UseKunrei") && kunrei) {
                                testclass.add(kunrei + (modus !== 2 && row && (!rowRequired || rowRequired === 2) ? " (" + row + ")" : "")
                                              , hiragana)
                            }
                            else {
                                testclass.add((romaji)
                                              + (modus !== 2 && row && (!rowRequired || rowRequired === 1) ? " (" + row + ")" : "")
                                              , hiragana)
                            }
                        }
                    }
                }
            })

            // Start the test
            if(testclass.testPossible())
            {
                testclass.newQuestion()
                if(modus  == 0)
                {
                    pageStack.push(Qt.resolvedUrl("Test.qml"))
                }
                else if (modus == 1)
                {
                    pageStack.push(Qt.resolvedUrl("TestReverse.qml"))
                }
                else if (modus == 2)
                {
                    pageStack.push(Qt.resolvedUrl("TestFree.qml"))
                }
                else
                {
                    pageStack.push(Qt.resolvedUrl("TestFreeReverse.qml"))
                }
            }
            else
            {
                errorPanel.show()
            }
        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        id: silica
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {

            MenuItem {
                text: "About"
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }

            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
            }


            MenuItem {
                text: "Start Test"
                onClicked: startTest.startTest()
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: mainColumn.height
        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: mainColumn
            width: parent.width

            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }

            RemorsePopup {
                id: remorsePopup
            }

            PageHeader {
                title: "Hiragana"
            }

            VerticalScrollDecorator {}

            Column {
                x: - parent.x
                height: implicitHeight + Theme.paddingLarge
                width: grid.width
                spacing: Theme.paddingLarge
                ComboBox {
                    id: selectModus
                    width: grid.width
                    label: "Test mode:"
                    currentIndex: save.getInt("Modus")

                    onCurrentIndexChanged: save.saveInt("Modus",currentIndex)

                    menu: ContextMenu {
                        MenuItem { text: "Normal Test" }
                        MenuItem { text: "Reverse Test" }
                        MenuItem { text: "Free Test"}
                        MenuItem { text: "Free Reverse Test"}
                    }
                }

                Row {
                    anchors {
                        left: parent.left
                        leftMargin: Theme.paddingLarge
                    }
                    Label {
                        text: "Selected:  "
                    }
                    Label {
                        text: selected + " "
                        color: selected > 5 ? Theme.highlightColor : "#ff4d4d"
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
                    Label {
                        text: " / <font color='" + Theme.secondaryColor + "'>" + total
                    }
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: Theme.paddingMedium

                    Button {
                        text: "Select all"
                        onClicked: remorsePopup.execute("Selecting all", function() {grid.allSet = 1}, 3000 )
                    }

                    Button {
                        text: "Deselect all"
                        onClicked: remorsePopup.execute("Deselecting all", function() {grid.allSet = 2}, 3000 )
                    }
                }
            }

            HiraganaSelector {
                id: monographSelector
                model: monographModel
                labelText: "Monographs"
                columns: 5
                x: - parent.x
                onDrawerAnimationFinished: {
                    if (state === "ShowDrawer") {
                        mainColumn.hideOtherSelector(this)
                    }
                }
            }

            HiraganaSelector {
                id: diacriticSelector
                model: diacriticModel
                labelText: "Diacritics"
                columns: 5
                onDrawerAnimationFinished: {
                    if (state === "ShowDrawer") {
                        mainColumn.hideOtherSelector(this)
                    }
                }
            }

            HiraganaSelector {
                id: digraphSelector
                model: digraphModel
                labelText: "Digraphs"
                columns: 3
                onDrawerAnimationFinished: {
                    if (state === "ShowDrawer") {
                        mainColumn.hideOtherSelector(this)
                    }
                }
            }

            HiraganaSelector {
                id: digraphDiacriticSelector
                model: digraphsDiacriticsModel
                labelText: "Digraphs with Diacritics"
                columns: 3
                onDrawerAnimationFinished: {
                    if (state === "ShowDrawer") {
                        mainColumn.hideOtherSelector(this)
                    }
                }
            }

            function hideOtherSelector(clickedSelector) {
                var nothingToHide = true
                selectorArray.forEach(function(item) {
                    if (clickedSelector !== item && item.state === "ShowDrawer") {
                        item.state = "HideDrawer"
                        nothingToHide = false
                    }
                })
                if (nothingToHide) {
                    silica.contentY = silica.contentY //If nothing is hidden this won't be assigned by onDrawerAnimationFinished in HiraganaSelector.qml
                }
            }
        }
    }
    UpperPanel {
        id: errorPanel
        text: "Select at least six Hiragana"
    }
}
