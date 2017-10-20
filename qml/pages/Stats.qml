import QtQuick 2.0
import Sailfish.Silica 1.0

Grid {
    property list<QtObject> statsModel: [
        QtObject {
            property string label: "Questions: "
            property int value: variable.questions
            property string oLabel: "Overall Questions: "
            property int oValue: variable.sumQuestions
        },
        QtObject {
            property string label: "Correct: "
            property int value: variable.correct
            property string oLabel: "Overall Correct: "
            property int oValue: variable.sumCorrect
        },
        QtObject {
            property string label: "Ratio: "
            property int value: variable.questions === 0 ? 0 : Math.round(100.0 / variable.questions * variable.correct)
            property string oLabel: "Ratio: "
            property int oValue: variable.sumQuestions === 0 ? 0 : Math.round(100.0 / variable.sumQuestions * variable.sumCorrect)
        }
    ]

    flow: test.isPortrait ? Grid.LeftToRight : Grid.TopToBottom
    columns: 3
    rows: 3
    scale: implicitWidth > (parent.width - Theme.paddingMedium) ? (parent.width - Theme.paddingMedium) / implicitWidth : 1
    transformOrigin: Item.Left
    Repeater {
        model: statsModel
        Item {
            id: stat
            width: Math.max(statLabel.width + statValue.width, oStatLabel.width + oStatValue.width) + Theme.paddingMedium
            height: statValue.height + oStatValue.height
            Row {
                id: statRow
                Label {
                    id: statLabel
                    text: label
                }
                Label {
                    id: statValue
                    text: value === 100 ? 100 : value

                    onTextChanged: {
                        valueBehavior.enabled = false
                        scale = 1.3
                        valueBehavior.enabled = true
                        scale = 1
                    }

                    Behavior on scale {
                        id: valueBehavior
                        enabled: false
                        NumberAnimation {duration: 300; easing.type: Easing.OutQuart}
                    }
                }
                Label {
                    id: percent
                    text: label == "Ratio: " ? "%" : ""
                }
            }
            Row {
                anchors {
                    top: statRow.bottom
                }

                Label {
                    id: oStatLabel
                    text: oLabel
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeTiny
                }
                Label {
                    id: oStatValue
                    text: oValue
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeTiny

                    onTextChanged: {
                        oValueBehavior.enabled = false
                        scale = 1.3
                        oValueBehavior.enabled = true
                        scale = 1
                    }

                    Behavior on scale {
                        id: oValueBehavior
                        enabled: false
                        NumberAnimation {duration: 300; easing.type: Easing.OutQuart}
                    }
                }
                Label {
                    id: oPercent
                    text: oLabel == "Ratio: " ? "%" : ""
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeTiny
                }
            }
        }
    }
}
