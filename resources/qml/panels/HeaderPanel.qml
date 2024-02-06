import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import com.tu.theme 1.0
import com.tu.common 1.0
import controls 1.0

Rectangle {
  id: root

  property alias menuPanel: menuPanel
  signal menuButtonPressed

  height: Common.headerHeight
  color: Theme.headerBackgroundColor

  RowLayout {
    id: headerRow

    anchors {
      fill: parent
      margins: Common.sideMargin
    }
    spacing: 10

    IconButton {
      id: menuButton

      property bool isPaused: false

      Layout.fillHeight: true
      Layout.minimumWidth: Common.menuButtonWidth
      Layout.minimumHeight: Common.menuButtonHeihgt

      iconSource: "qrc:/assets/menu.svg"
      backgroundRadius: 0
      useOverlayLayer: true

      onPressed: function() {
        root.menuButtonPressed()
        gameController.onPause =!gameController.onPause

        if(gameController.onPause) {
          menuPanel.open()
        } else {
          menuPanel.close()
        }
      }
    }

    BodyText {
      id: playerName

      Layout.fillHeight: true
      Layout.fillWidth: true

      text: gameController.playerName
      horizontalAlignment: Text.AlignLeft
      font.pixelSize: Theme.largeFontSize
    }
  }

  MenuPanel {
    id: menuPanel

    width: Common.menuWidth
    x: 0
    y: parent.height
  }
}
