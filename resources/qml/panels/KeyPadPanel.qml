import QtQuick
import QtQuick.Layouts

import controls 1.0

import com.tu.theme 1.0
import com.tu.utilities 1.0
import com.tu.common 1.0

GridLayout {
  id: root

  signal keyButtonPressed(int key)

  rows: 5
  columns: 4
  columnSpacing: Utilities.dp(1)
  rowSpacing: Utilities.dp(1)

  Repeater {
    id: repeater
    model: Common.digitPanelModel
    delegate: IconButton {
      id: delegeteButton
      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.columnSpan: model["columnSpan"]
      Layout.rowSpan: model["rowSpan"]
      Layout.row: model["row"]
      Layout.column: model["column"]

      iconSource: model["path"]
      backgroundRadius: 0
      useOverlayLayer: true

      onPressed: function () {
        root.keyButtonPressed( model["key"])
        console.log(model["key"])
      }
    }
  }
}

