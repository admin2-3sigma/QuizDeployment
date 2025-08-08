import QtQuick
import Felgo


Item {
    id: test


    property string questionText: ""
    property int timer: 0
    property var pNextQuestion
    property var inputFields: []

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
            Repeater {
                id:myRepeater
                model: 10
                Rectangle {
                    width: 1000; height: 66
                    color: "lightgray"
                    border.color: "black"

                    TextInput {
                        id: input

                        anchors.fill: parent
                        anchors.margins: 10
                        font.pixelSize: 36
                        focus: index === 0

                        Component.onCompleted: {
                            inputFields[index] = input
                        }
                    }
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
            customTimer.reserTimer(timer)
        }else {
            customTimer.stopTimer()
        }
    }

    function checkSolution() {
        test.visible = false

        var oldText = FileUtils.readFile(mPage.url)
        var newText = oldText + "\n" + toCSVField(questionText)

        for (let i = 0; i < inputFields.length; ++i) {
            newText += "," + toCSVField(inputFields[i].text)
        }
        var timeNeeded = test.timer-customTimer.time
        newText +=  "," + timeNeeded + "/" + timer + " sec"

        if (!FileUtils.writeFile(mPage.url, newText)) {
            console.log("Could not write to: " + mPage.url)
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

