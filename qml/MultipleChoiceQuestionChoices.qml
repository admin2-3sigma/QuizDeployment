import QtQuick
import Felgo

Item {
    id: choice
    property string answerText: ""
    property bool clicked: false

    width: parent.width
    height: answer.implicitHeight + 10

    Row {
        spacing: 10

        Rectangle {
            border.color: "black"
            border.width: 2
            width: 50
            height: 50

            color: "light gray"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!choice.clicked) {
                        choice.clicked = true
                        parent.color = "blue"
                    }
                    else if (choice.clicked) {
                        choice.clicked = false
                        parent.color = "light gray"
                    }
                }
            }
        }
        Text {
            id: answer
            text: answerText
            width: 1000
            font.pixelSize: 40
            wrapMode: Text.WordWrap
        }
    }
}
