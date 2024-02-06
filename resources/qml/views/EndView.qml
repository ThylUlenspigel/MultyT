import QtQuick
import QtQuick.Layouts

import controls 1.0
import panels 1.0
import com.tu.utilities 1.0
import com.tu.theme 1.0

BasicView {
  id: root

  signal newGameRequested
  signal continueGameRequested
  signal exitApplicationRequested

  objectName: "EndGameScreen"

  ColumnLayout {
    id: column

    anchors.centerIn: parent

    enabled: !gameController.onPause

    width: Utilities.dp(600)
    spacing: Utilities.dp(10)

    BodyText {
      id: text

      Layout.fillHeight: true
      Layout.fillWidth: true

      text: qsTr("Game over")
      font.pixelSize: Theme.largeFontSize
    }

    RecordsPanel {
      id: recordPanel

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredHeight: Utilities.dp(800)
      model: recordsModel
    }

    TextButton {
      id: newGameButton

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredHeight: Utilities.dp(60)

      contentText: qsTr("Start new game")

      onPressed: function() {
        root.newGameRequested()
      }
    }

    TextButton {
      id: continueGameButton

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredHeight: Utilities.dp(60)

      contentText: qsTr("Continue...")

      onPressed: function() {
        root.continueGameRequested()
      }
    }

    TextButton {
      id: exitGameButton

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredHeight: Utilities.dp(60)

      contentText: qsTr("Exit game")

      onPressed: function() {
        root.exitApplicationRequested()
      }
    }
  }
}
