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
                var oldText = FileUtils.readFile(mPage.url)
                var newText = oldText + "\n" + input.text
                if (!FileUtils.writeFile(mPage.url, newText)) {
                    console.log("Failed to write: ", mPage.url)
                }else {
                    console.log("Wrote to", mPage.url)
                }
                mMultipleChoice.visible = true
                start.visible = false
            }
        }
        Row {
            spacing: 10

            AppButton {
                visible: settings.language !== "en_EN.qm"
                text: qsTr("Switch to en_EN")
                onClicked: {
                    settings.language = "en_EN.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }

            AppButton {
                visible: settings.language !== "de_DE.qm"
                text: qsTr("Switch to de_DE")
                onClicked: {
                    settings.language = "de_DE.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }

            AppButton {
                visible: settings.language !== "de_AT.qm"
                text: qsTr("Switch to de_AT")
                onClicked: {
                    settings.language = "de_AT.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }

            AppButton {
                visible: settings.language !== "fr_FR.qm"
                text: qsTr("Switch to fr_FR")
                onClicked: {
                    settings.language = "fr_FR.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }

            AppButton {
                visible: settings.language !== "cn_CN.qm"
                text: qsTr("Switch to cn_CN")
                onClicked: {
                    settings.language = "cn_CN.qm"
                    nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
                }
            }

            AppButton {
                visible: settings.language !== "hu_HU.qm"
                text: qsTr("Switch to hu_HU")
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
        numOfQuestions: 3
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
}
