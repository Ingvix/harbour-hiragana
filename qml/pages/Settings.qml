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

import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {

    id: settings

    RemorsePopup {
        id: remorsePopup
    }

    onAccepted: {
        save.saveBool("NextAfterCorrect", autonext.checked)
        save.saveBool("LabelsEnabled", enabled1.checked)
        save.saveBool("UseKunrei", kunrei.checked)
        while(pageStack.busy)
        {
        }
        pageStack.replaceAbove(null, Qt.resolvedUrl("Grid.qml"))
    }

    SilicaFlickable {

        VerticalScrollDecorator {}

        anchors.fill: parent

        contentHeight: mainColumn.height

        Column {
            id: mainColumn
            spacing: Theme.paddingMedium

            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }

            DialogHeader {
                title: "Settings"
                acceptText: "Save"
                cancelText: "Discard"
                width: settings.width
            }

            TextSwitch {
                id: kunrei
                width: parent.width
                checked: save.getBool("UseKunrei")
                text: "Use Kunrei for transcription"
                description: "Use 'Kunrei-shiki romanization' for transcripting Hiragana instead of 'Hepburn romanization'"
            }

            TextSwitch {
                id: autonext
                width: parent.width
                checked: save.getBool("NextAfterCorrect")
                text: "Automatically get a new question after correct answer"
                //I think label says it all so no need for description
            }

            TextSwitch {
                id: enabled1
                width: parent.width
                checked: save.getBool("LabelsEnabled")
                text: "Show result labels"
                description: "Show 'Correct' and 'Wrong' labels after answer"
                height: implicitHeight + Theme.paddingLarge
            }

            Button {
                width: parent.width
                text: "Reset statistics"
                onClicked: remorsePopup.execute("Resetting statistics", function() {save.clearStats(); save.saveNow(); pageStack.replaceAbove(null, Qt.resolvedUrl("Grid.qml")) } )
                height: Theme.itemSizeExtraSmall + Theme.paddingLarge
            }
        }
    }
}
