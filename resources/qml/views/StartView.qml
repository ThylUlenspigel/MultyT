import QtQuick
import QtQuick.Layouts

import controls 1.0
import panels 1.0

import com.tu.theme 1.0
import com.tu.common 1.0
import com.tu.utilities 1.0

BasicView {
  id: root

  objectName: "StartGameScreen"

  signal newGameStarted

  RowLayout {
    id: row

    anchors.centerIn: parent

    enabled: !gameController.onPause
    spacing: Utilities.dp(15)

    TextFieldControl {
      id: nameInput

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredHeight: Utilities.dp(120)
      Layout.preferredWidth: Utilities.dp(400)
      Layout.alignment: Qt.AlignHCenter

      title: qsTr("Player name")
      enabled: true
      state: "undefined"
    }

    TextButton {
      id: startButton

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(160)
      Layout.preferredHeight: Utilities.dp(160)

      contentText: qsTr("Start")
      enabled: nameInput.input.length !==0

      onPressed: function() {
        nameInput.input.accepted()
        gameController.setPlayerName(nameInput.fieldText)
        gameController.startNewGame(true)
        root.newGameStarted()
      }
    }
  }
}
