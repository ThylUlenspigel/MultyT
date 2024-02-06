import QtQuick
import QtQuick.Layouts

import controls 1.0
import panels 1.0

import com.tu.theme 1.0
import com.tu.common 1.0
import com.tu.utilities 1.0

BasicView {
  id: root

  objectName: "GameScreen"

  Item {
    id: contentWrapper

    anchors {
      fill: parent
      margins: Common.sideMargin
    }

    enabled: !gameController.onPause

    ColumnLayout {
      id: panelsColumn

      anchors.fill: parent

      spacing: Utilities.dp(10)

      GameStatPanel {
        id: gameStatPanel

        Layout.preferredHeight: Utilities.dp(150)
        Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

        lifeAmount: gameController.maxLifes
        lifeCount: gameController.lifeCount
        curentLevel: gameController.level
        curentScore: gameController.score
        gameDuration: gameController.gameDuration
        answerDuration: gameController.answerDuration
      }

      InputPanel {
        id: inputPanel

        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: Utilities.dp(250)
        Layout.maximumHeight: Utilities.dp(250)
        Layout.alignment: Qt.AlignHCenter

        valueMultiplier: gameController.multiplier
        valueMultiplicand: gameController.multiplicand
        resultField.text: keypadPanel.typedValue

        state: internal.answerStatus(gameController.status)  //can be done via "switch-case"
      }

      ImagesPanel {
        id: starsPanel

        Layout.fillWidth: true
        Layout.fillHeight: true
        imageAmount: gameController.maxTasks
        globalParameter: gameController.taskCount
      }

      KeyPadPanel {
        id: keypadPanel

        Layout.fillWidth: true
        Layout.maximumHeight: Utilities.dp(600)
        Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter

        onKeyButtonPressed: function(key) {
          switch(key) {
          case Common.KeyId.KeyAccept:
            inputPanel.resultField.accepted()
            gameController.checkResult(parseInt(keypadPanel.typedValue))
            keypadPanel.buttonDisabled = Common.KeyId.KeyAccept
            break
          case Common.KeyId.KeyRemove:
            internal.clearResultField()
            break
          case Common.KeyId.KeyRefresh:
            internal.clearResultField()
            gameController.nextTask()
            keypadPanel.buttonDisabled = Common.KeyId.KeyRefresh
            break
          default:
            break
          }
        }
      }
    }
  }

  Connections {
    target: gameController

    function onLevelChanged(level) {
      internal.clearResultField()
      keypadPanel.buttonDisabled = Common.KeyId.KeyRefresh
    }

    function onAnswerTimeout() {
      keypadPanel.buttonDisabled = Common.KeyId.KeyAccept
    }
  }

  QtObject {
    id: internal

    function answerStatus( status) {
      if (status === Common.Result.Wrong) return "wrong"
      if (status === Common.Result.Right) return "right"
      return "undefined"
    }

    function clearResultField() {
      keypadPanel.typedValue = ""
      inputPanel.resultField.clear()
    }
  }
}
