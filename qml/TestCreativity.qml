import QtQuick
import Felgo

Item {

    id: testCreativity
    anchors.fill: parent

    TestCreativityQuestions {
        id: question1
        timer: 260
        questionText: qsTr("Name as many uses as you can for a brick.")
        pNextQuestion: mSeriesTest
    }
    TestCreativityQuestions {
        id: question2
        timer: 260
        questionText: qsTr("Think of as many unusual uses as possible for a shoe.")
        pNextQuestion: mSeriesTest
    }
    TestCreativityQuestions {
        id: question3
        timer: 260
        questionText: qsTr("Think of as many unusual uses as possible for a plastic bottle.")
        pNextQuestion: mSeriesTest
    }

    onVisibleChanged: {
        if (visible) {
            var items = [question1, question2, question3]
            for (var i = 0; i < items.length; i++) {
                items[i].visible = false
            }
            var index = Math.floor(Math.random() * items.length)
            items[index].visible = true
        }
    }
}
