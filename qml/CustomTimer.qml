import QtQuick
import Felgo


Item {

    id: item
    width: 60
    height: 40
    anchors.verticalCenter: parent.verticalCenter

    property int time: -1
    property var currentQuestion

    Timer {
        id: countdown
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            time--
            if (time === 0) {
                countdown.stop()
                currentQuestion.checkSolution()
            }
        }
    }


    Text {
        anchors.centerIn: parent
        font.pointSize: 32
        text: time.toString()
    }


    function reserTimer(neededTime) {
        time = neededTime
        countdown.running = true
    }

    function stopTimer() {
        countdown.stop()
    }
}
