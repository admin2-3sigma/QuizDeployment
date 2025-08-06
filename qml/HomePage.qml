import QtQuick
import Felgo


AppPage {
    id: mPage
    title: qsTr("Main Page")
    property int score: 0
    property string url: "finalTest.csv"

    Column {
        id: start
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        Row {
            spacing: 10
            Text {
                id: numMultipleChoiceInput
                text: "Number of multiple choice questions (1 to 4; default is 4)"
                font.pixelSize: 40
            }

            Rectangle {
                width: 100; height: 66
                color: "lightgray"
                border.color: "black"

                TextInput {
                    id: numberInput
                    anchors.fill: parent
                    anchors.margins: 10
                    font.pixelSize: 36
                    focus: true
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator { bottom: 1; top: 4 }  // Adjust range as needed
                    onTextChanged: {
                        if (text !== "" && (parseInt(text) < 1 || parseInt(text) > 4)) {
                            text = ""
                        }
                    }
                }

            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Please write your name.")
            font.pixelSize: 40
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 500; height: 66
            color: "lightgray"
            border.color: "black"

            TextInput {
                id: input

                anchors.fill: parent
                anchors.margins: 10
                font.pixelSize: 36
                focus: true
            }
        }
        AppButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Start")
            onClicked: {
                mPage.url = toFileName(input.text)
                var oldText = FileUtils.readFile(mPage.url)
                var newText = oldText + "\n" + input.text
                if (!FileUtils.writeFile(mPage.url, newText)) {
                    console.log("Failed to write: ", mPage.url)
                }else {
                    console.log("Wrote to", mPage.url)
                }
                if (numberInput.text) {
                    mMultipleChoice.numOfQuestions = numberInput.text
                }

                mMultipleChoice.visible = true
                start.visible = false
            }
        }
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            AppButton {
                visible: settings.language !== "en_EN.qm"
                text: "EN"
                onClicked: {
                    settings.language = "en_EN.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }

            AppButton {
                visible: settings.language !== "fr_FR.qm"
                text: "FR"
                onClicked: {
                    settings.language = "fr_FR.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }

            AppButton {
                visible: settings.language !== "ru_RU.qm"
                text: "RU"
                onClicked: {
                    settings.language = "ru_RU.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }

            AppButton {
                visible: settings.language !== "hu_HU.qm"
                text: "HU"
                onClicked: {
                    settings.language = "hu_HU.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }
        }
    }

    MultipleChoice {
        id: mMultipleChoice

        visible: false
        numOfQuestions: 4
    }
    TestCreativity {
        id: mTestCreativity
        visible: false
    }
    SeriesTest {
        id: mSeriesTest
        visible: false
    }
    Rectangle {
        id: mEndText

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        visible: false

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Thank you, the  test is finished.")
            font.pixelSize: 40
        }

        onVisibleChanged: {
            var oldText = FileUtils.readFile(mPage.url)
            var newText = oldText + "\n" + "Score" + "," + mPage.score
            if (!FileUtils.writeFile(mPage.url, newText)) {
                console.log("Failed to write output.csv")
            }

        }
    }
    function addScore() {
        mPage.score++
    }

    function toFileName(text) {
        text = text.toString()
        if (text.includes(' ')) {
            text = text.replace(" ", "_")
        }
        return text + ".csv"
    }
}
