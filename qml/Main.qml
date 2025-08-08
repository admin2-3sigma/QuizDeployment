import Felgo
import QtQuick

GameWindow {
    id: mainWindow
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: qsTr("<generate one from https://felgo.com/licenseKey>"

    NavigationStack {
        id: nav

        initialPage: Qt.resolvedUrl("LanguageChoice.qml")
    }
    Component.onCompleted: {
        settings.language = "en_EN.qm"
        nav.clearAndPush(Qt.resolvedUrl("LanguageChoice.qml"))
    }
}
