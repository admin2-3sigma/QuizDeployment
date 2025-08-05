import Felgo
import QtQuick

App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: qsTr("<generate one from https://felgo.com/licenseKey>"

    NavigationStack {

        AppPage {
            id: mPage
            title: qsTr("Main Page")
            property int score: 0
            property string url: "Test.csv"

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
                    text: "Start"
                    onClicked: {
                        var oldText = FileUtils.readFile(mPage.url)
                        var newText = oldText + "\n" + input.text
                        if (!FileUtils.writeFile(mPage.url, newText)) {
                            console.log("Failed to write output.csv")
                        }
                        mMultipleChoice.visible = true
                        start.visible = false
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
    }
}
