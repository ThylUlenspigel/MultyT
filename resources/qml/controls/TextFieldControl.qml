import QtQuick
import QtQuick.Controls

import common 1.0
import controls 1.0
import com.tu.utilities 1.0

Item {
  id: root

  property alias title: fieldTitle.text
  property alias fieldText: textField.text
  property alias enabled: textField.enabled

  Column {
    id: fieldColumn

    anchors.fill: parent

    spacing: Utilities.dp(5)

    Text {
      id: fieldTitle

      width: parent.width

      color: Theme.mainFontColor
      font.pixelSize: Theme.smallFontSize
      wrapMode: Text.WordWrap
      verticalAlignment: Text.AlignVCenter
    }

    TextField {
      id: textField

      height: fieldColumn.height - fieldColumn.spacing - fieldTitle.height
      width: parent.width

      leftPadding: Common.textFieldPadding
      rightPadding: Common.textFieldPadding
      verticalAlignment: Text.AlignVCenter
      color: Theme.mainFontColor
      font.pixelSize: Theme.mainFontSize

      background: Rectangle {
        anchors.fill: parent
        radius: 10
        color: textField.enabled? Theme.textFieldBackgroundColor
                                : Theme.textFieldDisabledBackgroundColor
        border {
          width: Theme.commonBorderWidth
          color: Theme.borderReleasedColor
        }

        Behavior on opacity {
          PropertyAnimation {
            duration: Theme.defaultAnimationDuration
          }
        }
      }
    }
  }
}
