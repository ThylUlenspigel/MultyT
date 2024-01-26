import QtQuick
import QtQuick.Layouts

import controls 1.0

import com.tu.theme 1.0
import com.tu.utilities 1.0
import com.tu.common 1.0
import com.tu.global 1.0

ColumnLayout {
  id: root

  property alias lifeAmount: heartPanel.imageAmount
  property int lifeCount: Global.lifesCount

  property alias curentLevel: levelIndicator.value
  property alias curentScore: scoreIndicator.value

  property alias gameDuration: totalTimeIndicator.duration
  property alias answerDuration: answerTimeIndicator.duration

  spacing: 15

  ImagesPanel {
    id: heartPanel

    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    imageAmount: 4
    globalParameter: root.lifeCount//Global.lifesCount
    enabledColor: Theme.heartOverlayColor
    disabledColor: Theme.heartDisabledOverlayColor
    enabledImageSource: "qrc:/assets/heart.svg"
    disabledImageSource: "qrc:/assets/heart-empty.svg"
  }

  RowLayout {
    id: levelScoreRow
    spacing: Utilities.dp(15)

    Layout.preferredHeight: Utilities.dp(30)
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    StatIndicator {
      id: levelIndicator

      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(400)
      Layout.alignment: Qt.AlignLeft

      stat: qsTr("Level")
    }

    StatIndicator {
      id: scoreIndicator

      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(400)
      Layout.alignment: Qt.AlignRight

      stat: qsTr("Score")
      value: 999999
    }
  }

  RowLayout {
    id: timersRow

    Layout.alignment: Qt.AlignHCenter
    Layout.fillWidth: true

    TimeIndicator {
      id: totalTimeIndicator

      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(400)
      Layout.alignment: Qt.AlignLeft
    }

    TimeIndicator {
      id: answerTimeIndicator

      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(400)
      Layout.alignment: Qt.AlignRight
    }
 }
}
