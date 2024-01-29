import QtQuick
import QtQuick.Layouts

import controls 1.0
import com.tu.utilities 1.0
import com.tu.theme 1.0

BasicView {
  id: root

  signal newGameRequested
  signal continueGameRequested
  signal exitApplicationRequested

  ColumnLayout {
    id: column

    anchors.centerIn: parent

    spacing: Utilities.dp(10)

    BodyText {
      id: text

      Layout.fillHeight: true
      Layout.fillWidth: true

      text: qsTr("Game over")
      font.pixelSize: Theme.largeFontSize
    }

    //TODO Add result table with TOP-10 results
    Item {
      id: resultTable
    }

    TextButton {
      id: newGameButton

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(200)
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
      Layout.preferredWidth: Utilities.dp(200)
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
      Layout.preferredWidth: Utilities.dp(200)
      Layout.preferredHeight: Utilities.dp(60)

      contentText: qsTr("Exit game")

      onPressed: function() {
        root.exitApplicationRequested()
      }
    }
  }
}
