import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import controls 1.0

import com.tu.utilities 1.0
import com.tu.common 1.0
import com.tu.theme 1.0

Popup {
  id: root

  property alias showRecords: recordsPanel.visible
  property alias model: recordsPanel.model

  closePolicy: Popup.NoAutoClose

  background: Rectangle {
    id: background

    color : Theme.backgroundColor
    border {
      width: Theme.commonBorderWidth
      color: Theme.borderPressedColor
    }
  }

  contentItem: ColumnLayout {
    id: column

    RecordsPanel {
      id: recordsPanel

      Layout.fillHeight: recordsPanel.visible
      Layout.fillWidth: recordsPanel.visible
      Layout.preferredHeight: Utilities.dp(800)
    }

    TextArea {
      id: textArea

      Layout.fillHeight: !recordsPanel.visible
      Layout.fillWidth: !recordsPanel.visible

      visible: !recordsPanel.visible
      padding: Common.infoPopupMargin
      horizontalAlignment: Text.AlignLeft
      verticalAlignment: Text.AlignVCenter
      wrapMode: TextEdit.Wrap
      text: gameController.about
      color:Theme.mainFontColor
      font {
        pixelSize: Theme.mainFontSize
      }
    }

    TextButton {
      id: closeButton

      Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(160)
      Layout.preferredHeight: Utilities.dp(60)

      contentText: qsTr("Close")

      onPressed: function() {
        root.close()
      }
    }
  }
}
