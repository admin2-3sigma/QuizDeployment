import QtQuick
import Felgo

Item {

    id: multipleChoice
    anchors.fill: parent

    property int numOfQuestions:3


    MultipeChoiceQuestion {
        id: question1
        timer: 40
        questionText: qsTr("All birds have feathers. A penguin is a bird.")
        answerText1: qsTr("If an animal has feathers, then it is a bird.")
        answerText2: qsTr("If something is a bird, then it has feathers.")
        answerText3: qsTr("Only birds have feathers.")
        answerText4: qsTr("Pinguin have feathers")
        pSolutions: [false, true, false, true]
        pNextQuestion: question4
    }
    MultipeChoiceQuestion {
        id: question2
        timer: 40
        questionText: qsTr("Everyone who graduates from medical school is a doctor.")
        answerText1: qsTr("Everyone who is a doctor graduated from medical school.")
        answerText2: qsTr("Some doctors didn’t go to medical school.")
        answerText3: qsTr("Only doctors go to medical school")
        answerText4: qsTr("If somebody is not a doctor, then he did not graduate from medical school")
        pSolutions: [false, true, false, true]
        pNextQuestion: question4
    }
    MultipeChoiceQuestion {
        id: question3
        timer: 40
        questionText: qsTr("If it is raining, then the ground is wet.")
        answerText1: qsTr("If the ground is wet, then it is raining")
        answerText2: qsTr("If the ground is not wet, then it is not raining.")
        answerText3: qsTr("If it is not raining, then the ground is not wet.")
        answerText4: qsTr("It is possible that the ground is wet even if it is not raining")
        pSolutions: [false, true, false, true]
        pNextQuestion: question4
    }
    MultipeChoiceQuestion {
        id: question4
        timer: 80
        questionText: qsTr("If a card has a vowel on it, then it has an even number on the other side. You see these four cards: A | K | 4 | 7. Which card must you turn to test if the rule is true?")
        answerText1: qsTr("A")
        answerText2: qsTr("K")
        answerText3: qsTr("4")
        answerText4: qsTr("7")
        pSolutions: [false, true, false, true]
        pNextQuestion: mTestCreativity
    }

    onVisibleChanged: {
        if (visible) {
            if (numOfQuestions === 1) {
                question4.visible = true
            } else {
                var items = [question1, question2, question3]
                var index = Math.floor(Math.random() * items.length)
                var first = items[index]
                var pre = first
                var next

                for (var i = 1; i < numOfQuestions-1; i++) {
                    items.splice(index, 1)
                    index = Math.floor(Math.random() * items.length)
                    next = items[index]
                    pre.pNextQuestion = next
                    pre = next
                }
                first.visible = true
            }

        }
    }
}
