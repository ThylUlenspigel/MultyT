import QtQuick

import com.tu.theme 1.0
import controls 1.0

BodyText {
  id: root

  property string stat:""
  property int value: 1

  text: qsTr(stat + ": " + value.toLocaleString())
}
