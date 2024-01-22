import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import com.tu.theme 1.0
import com.tu.common 1.0

AbstractButton {
  id: root

  property alias iconSource: contentImageID.source
  property alias backgroundRadius: iconButtonBackgroundID.radius
  property alias imageAnchors: contentImageID.anchors

  property bool useBorder: true
  property bool useOverlayLayer: false

  property color backgroundPressedColor: Theme.buttonBackgroundPressedColor
  property color backgroundReleasedColor: Theme.buttonBackgroundReleasedColor
  property color borderPressedColor: Theme.borderPressedColor
  property color borderReleasedColor: Theme.borderReleasedColor
  property color layerEffectColor: Theme.borderReleasedColor

  implicitWidth: 30
  implicitHeight: 30

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

  contentItem: Image {
    id: contentImageID

    layer {
      enabled: root.useOverlayLayer
      mipmap: true

      effect: ColorOverlay {
        cached: true
        color: root.layerEffectColor
      }
    }

    fillMode: Image.PreserveAspectFit

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
