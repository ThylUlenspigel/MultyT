import QtQuick
import QtQuick.Layouts

import com.tu.theme 1.0
import com.tu.utilities 1.0

RowLayout {
  id: root

  property bool isHeader: false
  property string textName: ""
  property int valueScore: 0
  property int timeDuration: 0

  spacing: Utilities.dp(30)

  BodyText {
    id: nameText

    Layout.fillWidth: true
    Layout.preferredWidth: root.width/3
    Layout.alignment: Qt.AlignLeft

    text: root.isHeader? qsTr("Player' name") : root.textName
    wrapMode: Text.NoWrap
    fontSizeMode: Text.Fit
    font.pixelSize: root.isHeader? Theme.largeFontSize : Theme.mainFontSize
  }

  BodyText {
    id: scoreText

    Layout.fillWidth: true
    Layout.preferredWidth: root.width/3
    Layout.alignment: Qt.AlignHCenter

    text: root.isHeader? qsTr("Player' score") : root.valueScore
    wrapMode: Text.NoWrap
    fontSizeMode: Text.Fit
    font.pixelSize: root.isHeader? Theme.largeFontSize : Theme.mainFontSize
  }

  BodyText {
    id: timeHeader

    Layout.fillWidth: root.isHeader
    Layout.preferredWidth: root.isHeader? root.width/3 : 0
    Layout.alignment: Qt.AlignRight
    visible: root.isHeader

    text: qsTr("Player' time")
    wrapMode: Text.NoWrap
    fontSizeMode: Text.Fit
    font.pixelSize: Theme.largeFontSize
  }

  TimeIndicator {
    id: timeIndicator

    Layout.fillWidth: !root.isHeader
    Layout.preferredWidth: !root.isHeader? root.width/3 : 0
    Layout.alignment: Qt.AlignRight

    visible: !root.isHeader
    duration: root.timeDuration
  }
}
