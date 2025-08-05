import QtQuick
import Felgo

Item {
    id: test
    property int timer: 0
    property string questionText: ""
    property string answerText1: ""
    property string answerText2: ""
    property string answerText3: ""
    property string answerText4: ""
    property var pSolutions: []
    property var pNextQuestion
    property bool solved: false


    visible: false

    width: 1000
    height: columnContent.implicitHeight + 20

    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: box
        color: "light yellow"
        anchors.fill: parent
        Column {
            id: columnContent
            anchors.fill: parent
            spacing: 10
            leftPadding: 10
            Text {
                width: parent.width-50
                text: questionText + "\n"
                font.pixelSize: 40
                wrapMode: Text.WordWrap
            }

            MultipleChoiceQuestionChoices {
                id: choice1
                answerText: answerText1
            }
            MultipleChoiceQuestionChoices {
                id: choice2
                answerText: answerText2
            }
            MultipleChoiceQuestionChoices {
                id: choice3
                answerText: answerText3
            }
            MultipleChoiceQuestionChoices {
                id: choice4
                answerText: answerText4
            }
            Row {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                AppButton {
                    id: button
                    text: qsTr("Next")
                    anchors.verticalCenter: parent.verticalCenter

                    onClicked: {
                        checkSolution();
                    }
                }
                CustomTimer {
                    id: customTimer
                    currentQuestion: test
                }
            }
        }
    }

    onVisibleChanged: {
        if (visible) {
            customTimer.reserTimer(timer)
        } else {
            customTimer.stopTimer()
        }
    }

    function checkSolution() {
        test.visible = false
        if (choice1.clicked !== pSolutions[0]) {
        } else if (choice2.clicked !== pSolutions[1]) {
        } else if (choice3.clicked !== pSolutions[2]) {
        } else if (choice4.clicked !== pSolutions[3]) {
        } else {
            solved = true
            mPage.addScore()
        }
        var oldText = FileUtils.readFile("output.csv")
        var newText = oldText + "\n" + toCSVField(questionText) + "," + solved
        if (!FileUtils.writeFile("output.csv", newText)) {
            console.log("Failed to write output.csv")
        }
        if (pNextQuestion) {
            pNextQuestion.visible = true
        }
    }

    function toCSVField(text) {
        text = text.toString()
        if (text.includes('"')) {
            text = text.replace(/"/g, '""')
        }
        if (text.includes(',') || text.includes('"') || text.includes('\n')) {
            return '"' + text + '"'
        }
        return text
    }
}
