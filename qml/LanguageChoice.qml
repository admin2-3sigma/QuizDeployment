import QtQuick
import Felgo

AppPage {
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        Text {
            text: "Current language pack: " + settings.language
            font.pixelSize: 32
        }
        Row {
            spacing: 10

            AppButton {
                text: "EN"
                onClicked: {
                    settings.language = "en_EN.qm"
                    nav.clearAndPush(Qt.resolvedUrl("LanguageChoice.qml"))
                }
            }

            AppButton {
                text: "FR"
                onClicked: {
                    settings.language = "fr_FR.qm"
                    nav.clearAndPush(Qt.resolvedUrl("LanguageChoice.qml"))
                }
            }

            AppButton {
                text: "RU"
                onClicked: {
                    settings.language = "ru_RU.qm"
                    nav.clearAndPush(Qt.resolvedUrl("LanguageChoice.qml"))
                }
            }

            AppButton {
                text: "HU"
                onClicked: {
                    settings.language = "hu_HU.qm"
                    nav.clearAndPush(Qt.resolvedUrl("LanguageChoice.qml"))
                }
            }
        }
        AppButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "NEXT"
            onClicked: {
                nav.clearAndPush(Qt.resolvedUrl("HomePage.qml"))
            }
        }
    }
}
