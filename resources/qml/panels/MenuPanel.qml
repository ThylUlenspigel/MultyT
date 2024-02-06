import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import controls 1.0

import com.tu.theme 1.0
import com.tu.utilities 1.0
import com.tu.common 1.0

Menu {
  id: root

  property int menuItemDisabled: Common.MenuId.Undefined
  signal menuItemSelected(var menuId)

  background: Rectangle {
      color: Theme.headerBackgroundColor
      radius: Theme.commonRadius
  }

  leftPadding: Utilities.dp(10)
  closePolicy: Popup.NoAutoClose

  Repeater {
    id: repeater

    model: Common.menuModel

    delegate: TextButton {
      id: button

      backgroundRadius: 0
      useBorder: false
      backgroundPressedColor: Theme.panelBackgroundColor
      backgroundReleasedColor: Theme.headerBackgroundColor
      textHorizontalAlignment: Text.AlignLeft
      contentText: model["menuName"]
      enabled: model["menuId"] !== root.menuItemDisabled

      onPressed: function () {
        root.menuItemSelected(model["menuId"])
      }
    }
  }
}
