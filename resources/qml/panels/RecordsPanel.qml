import QtQuick
import QtQuick.Layouts

import controls 1.0

import com.tu.theme 1.0
import com.tu.utilities 1.0

ColumnLayout {
  id: root

  property alias model: listView.model

  spacing: Utilities.dp(10)

  BodyText {
    id: title

    Layout.fillWidth: true
    Layout.preferredWidth: Utilities.dp(160)
    Layout.alignment: Qt.AlignHCenter

    text: qsTr("Game record's table")
    font.pixelSize: Theme.largeFontSize
  }

  ListView {
    id: listView

    Layout.fillWidth: true
    Layout.fillHeight: true

    clip: true
    enabled: false
    model: root.recordsModel

    spacing: Utilities.dp(10)

    header: RecordDelegate {
      id: header
      isHeader: true
      width: parent.width
    }

    delegate: RecordDelegate {
      id: delegate

      width: root.width
      isHeader: false
      textName: name
      valueScore: gameScore
      timeDuration: gameDuration
    }
  }
}
