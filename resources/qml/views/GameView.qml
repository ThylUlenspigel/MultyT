import QtQuick
import QtQuick.Layouts

import controls 1.0
import panels 1.0

import com.tu.theme 1.0
import com.tu.common 1.0
import com.tu.utilities 1.0

BasicView {
  id: root

  header: Rectangle {
    id: header

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

        Layout.fillHeight: true
        Layout.minimumWidth: Common.menuButtonWidth
        Layout.minimumHeight: Common.menuButtonHeihgt

        iconSource: "qrc:/assets/menu.svg"
        backgroundRadius: 0
        useOverlayLayer: true
      }

      BodyText {
        id: playerName

        Layout.fillHeight: true
        Layout.fillWidth: true

        text: qsTr("Kiril")
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: Theme.largeFontSize
      }
    }
  }

  Item {
    id: contentWrapper

    anchors {
      fill: parent
      margins: Common.sideMargin
    }

    ColumnLayout {
      id: panelsColumn

      anchors.fill: parent

      spacing: Utilities.dp(10)

      GameStatPanel {
        id: gameStatPanel

        Layout.preferredHeight: Utilities.dp(150)
        Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
      }

      InputPanel {
        id: inputPanel
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: Utilities.dp(250)
        Layout.maximumHeight: Utilities.dp(250)
        Layout.alignment: Qt.AlignHCenter
      }

      ImagesPanel {
        id: starsPanel

        Layout.fillWidth: true
        Layout.fillHeight: true
      }

      KeyPadPanel {
        id: keypadPanel

        Layout.fillWidth: true
        Layout.maximumHeight: Utilities.dp(600)
        Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
      }
    }
  }
}
