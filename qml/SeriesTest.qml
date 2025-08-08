import QtQuick
import Felgo

Item {

    id: seriesTest
    anchors.fill: parent

    SeriesTestQuestion {
        id: question1
        timer: 60
        pNextQuestion: question2
        myFunction: function(num, _) {
            return num + 7
        }
    }
    SeriesTestQuestion {
        id: question2
        timer: 90
        pNextQuestion: question3
        myFunction: function(num, _) {
            return num*2+3
        }
    }
    SeriesTestQuestion {
        id: question3
        timer: 90
        pNextQuestion: question4
        myFunction: function(num, _) {
            return num*2-3
        }
    }
    SeriesTestQuestion {
        id: question4
        timer: 70
        pNextQuestion: question5
        firstXNumber: 5
        myFunction: function(num, i) {
            if (i%2 === 0) {
                return num+5
            }
            return num-3
        }
    }
    SeriesTestQuestion {
        id: question5
        timer: 80
        pNextQuestion: mEndText
        firstXNumber: 5
        myFunction: function(num, i) {
            if (i%2 === 0) {
                return num+3
            }
            return num*2
        }
    }

    onVisibleChanged: {
        if (visible) {
            question1.visible = true
        }
    }
}
