import QtQuick
import Qt5Compat.GraphicalEffects

import com.tu.theme 1.0
import com.tu.common 1.0

Image {
    id: root

    property bool useOverlayLayer: true
    property color layerEffectColorEnabled: Theme.heartOverlayColor
    property color layerEffectColorDisabled: Theme.heartDisabledOverlayColor

    layer {
      enabled: root.useOverlayLayer
      mipmap: true

      effect: ColorOverlay {
        cached: true
        color: root.enabled? root.layerEffectColorEnabled : root.layerEffectColorDisabled
      }
    }

    fillMode: Image.PreserveAspectFit
    sourceSize {
      height: root.height
      width: root.width
    }
}
