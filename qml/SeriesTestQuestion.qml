import QtQuick
import Felgo

Item {
    id: test

    property int timer: 0
    property string questionText: qsTr("What comes next: ")
    property var pNextQuestion
    property var myFunction
    property var nums: []
    property int answer
    property int firstXNumber: 4

    visible: false

    width: 1100
    height: columnContent.implicitHeight + 50

    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: box

        color: "light yellow"
        anchors.fill: parent

        Column {
            id: columnContent
            spacing: 10
            leftPadding: 20

            Rectangle {

                width: 1000
                height: question.implicitHeight+10
                color: box.color
                Text {
                    id:question
                    anchors.fill: parent
                    anchors.margins: 10
                    width: parent.width-10
                    font.pixelSize: 40
                    text: questionText
                    wrapMode: Text.WordWrap
                }
            }

            Rectangle {
                width: 1000; height: 90
                color: "lightgray"
                border.color: "black"

                TextInput {
                    id: input

                    anchors.fill: parent
                    anchors.margins: 10
                    font.pixelSize: 64
                    focus: true
                }
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
            getNumber()
            customTimer.reserTimer(timer)
        }else {
            customTimer.stopTimer()
        }
    }

    function getNumber() {
        var firstNum = Math.floor(Math.random() * 3+2)
        nums.push(firstNum)
        var i
        for (i = 0; i < firstXNumber; i++) {
            nums.push(myFunction(nums[i], i))
            questionText += nums[i] + "; "
        }
        questionText += "?"
        answer = nums[i]
    }

    function checkSolution() {
        test.visible = false
        var oldText = FileUtils.readFile("output.csv")
        var newText = oldText + "\n" + questionText + "," + input.text + "," + (input.text === answer.toString())
        if (!FileUtils.writeFile("output.csv", newText)) {
            console.log("Failed to write output.csv")
        }
        if (input.text === answer.toString()){
            mPage.addScore()
        }


        if (pNextQuestion) {
            pNextQuestion.visible = true
        }
    }
}
