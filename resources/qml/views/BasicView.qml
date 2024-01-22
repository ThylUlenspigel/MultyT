import QtQuick
import QtQuick.Controls

import com.tu.theme 1.0
import com.tu.common 1.0

Page {
  id: root

  property alias backgroundColor: background.color

  background: Rectangle {
    id    : background
    color : Theme.backgroundColor
  }

}
