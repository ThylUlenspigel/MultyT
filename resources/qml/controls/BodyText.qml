import QtQuick

import com.tu.theme 1.0

Text {
    id: root

    elide: Text.ElideRight
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: Theme.mainFontColor
    font {
      pixelSize: Theme.mainFontSize
    }
}
