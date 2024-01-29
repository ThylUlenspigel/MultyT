import QtQuick
import QtQuick.Layouts

import controls 1.0

import com.tu.theme 1.0
import com.tu.utilities 1.0
import com.tu.global 1.0
import com.tu.common 1.0

RowLayout {
  id: root

  property int imageAmount: 10
  property int globalParameter: 0
  property color enabledColor: Theme.starOverlayColor
  property color disabledColor: Theme.starDisabledOverlayColor
  property url enabledImageSource: "qrc:/assets/star.svg"
  property url disabledImageSource: "qrc:/assets/star-empty.svg"

  property int imageSize: Utilities.dp(40)

  spacing: Utilities.dp(3)

  Repeater {
    id: repeater
    model: root.imageAmount
    delegate: OverlayedImage {
      id: heartDelegate

      Layout.fillWidth: true
      Layout.preferredHeight: root.imageSize
      Layout.preferredWidth: root.imageSize

      source: index < root.globalParameter? root.enabledImageSource
                                          : root.disabledImageSource
      enabled: index < root.globalParameter
      layerEffectColorEnabled: root.enabledColor
      layerEffectColorDisabled: root.disabledColor
    }
  }
}
