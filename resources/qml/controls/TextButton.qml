import QtQuick
import QtQuick.Controls

import com.tu.theme 1.0
import com.tu.common 1.0

AbstractButton {
  id: root

  property alias contentText: contentTextID.text
  property alias backgroundRadius: iconButtonBackgroundID.radius
  property alias textHorizontalAlignment: contentTextID.horizontalAlignment

  property bool useBorder: true

  property color backgroundPressedColor: Theme.buttonBackgroundPressedColor
  property color backgroundReleasedColor: Theme.buttonBackgroundReleasedColor
  property color borderPressedColor: Theme.borderPressedColor
  property color borderReleasedColor: Theme.borderReleasedColor
  property color layerEffectColor: Theme.borderReleasedColor

  implicitWidth: Common.textButtonWidth
  implicitHeight: Common.textButtonHeihgt

  opacity: enabled? Theme.enabledOpacity : Theme.disabledOpacity

  background: Rectangle {
    id: iconButtonBackgroundID

    anchors.fill: parent

    color: root.pressed? root.backgroundPressedColor : root.backgroundReleasedColor
    radius: Theme.commonRadius

    border {
      width: root.useBorder? Theme.commonBorderWidth : 0
      color: root.pressed? root.borderPressedColor : root.borderReleasedColor
    }

    Behavior on opacity {
      PropertyAnimation {
        duration: Theme.defaultAnimationDuration
      }
    }

  }

  contentItem: Text {
    id: contentTextID

    elide: Text.ElideRight
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: Theme.mainFontColor
    font {
      pixelSize: Theme.smallFontSize
    }

    MouseArea {
      id: contentMouseAreaID
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      acceptedButtons: Qt.NoButton
    }

    Behavior on opacity {
      PropertyAnimation {
        duration: Theme.defaultAnimationDuration
      }
    }
  }
}
