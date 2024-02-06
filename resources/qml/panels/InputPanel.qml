import QtQuick
import QtQuick.Layouts

import controls 1.0

import com.tu.theme 1.0
import com.tu.utilities 1.0
import com.tu.common 1.0

ColumnLayout {
  id: root

  property int valueMultiplier: 0
  property int valueMultiplicand: 0
  property alias resultField: fieldResult.input

  state: "wrong"

  RowLayout {
    id: rowInput

    spacing: 3
    Layout.fillWidth: true
    Layout.preferredHeight: Utilities.dp(120)
    Layout.alignment: Qt.AlignHCenter

    TextFieldControl {
      id: fieldMultiplier

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(160)
      Layout.preferredHeight: Utilities.dp(80)

      title: qsTr("Multiplier")
      enabled: false
      fieldText: root.valueMultiplier.toString()
    }

    OverlayedImage {
      id: crossImage

      Layout.preferredHeight: Utilities.dp(30)
      Layout.preferredWidth: Utilities.dp(30)
      Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

      source: "qrc:/assets/cross.svg"
      enabled: true
      layerEffectColorEnabled: Theme.crossOverlayColor
    }

    TextFieldControl {
      id: fieldMultiplicand
      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.preferredWidth: Utilities.dp(160)
      Layout.preferredHeight: Utilities.dp(80)

      title: qsTr("Multiplicand")
      enabled: false
      fieldText: root.valueMultiplicand.toString()
    }
  }

  TextFieldControl {
    id: fieldResult

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: Utilities.dp(120)
    Layout.preferredWidth:  Utilities.dp(160)
    Layout.alignment: Qt.AlignHCenter

    title: qsTr("Result")
    enabled: true

    input.maximumLength: 3

    input.validator:IntValidator {
      bottom: 0
      top: 999
    }
  }

  states: [
    State {
      name: "undefined"
      PropertyChanges {
        target: fieldResult
        textFieldBackgroundColor: Theme.textFieldBackgroundColor
      }
    },
    State {
      name: "right"
      PropertyChanges {
        target: fieldResult
        textFieldBackgroundColor: Theme.rightAnswerBackgroundColor
      }
    },
    State {
      name: "wrong"
      PropertyChanges {
        target: fieldResult
        textFieldBackgroundColor: Theme.wrongAnswerBackgroundColor
      }
    }
  ]
}
