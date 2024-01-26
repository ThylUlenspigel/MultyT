pragma Singleton
import QtQuick

import com.tu.utilities 1.0

QtObject {
  // Common
  readonly property color backgroundColor: "#FFCE00"
  readonly property color panelBackgroundColor: "#FFCE00"
  readonly property color headerBackgroundColor: "#FFE473"
  readonly property color headerDividerColor: "#1B0773"

  readonly property color borderReleasedColor: "#3D2D84"
  readonly property color borderPressedColor: "#1B0773"
  readonly property color buttonBackgroundPressedColor: "#644AD8"
  readonly property color buttonBackgroundReleasedColor: "#8370D8"

  readonly property color mainFontColor: "#3216B0"
  readonly property color textFieldBackgroundColor: "#FFE473"
  readonly property color textFieldDisabledBackgroundColor: "#8370D8"

  readonly property color rightAnswerBackgroundColor: "#00FF00"
  readonly property color wrongAnswerBackgroundColor: "#FF0000"

  readonly property color heartOverlayColor: "#FF0000"
  readonly property color heartDisabledOverlayColor: "#000000"

  readonly property color starOverlayColor: "#3216B0"
  readonly property color starDisabledOverlayColor: "#8370D8"

  readonly property color crossOverlayColor: "#3216B0"

  readonly property int mainFontSize: Utilities.dp(40)
  readonly property int smallFontSize: Utilities.dp(30)
  readonly property int largeFontSize: Utilities.dp(50)

  readonly property int commonRadius: Utilities.dp(12)
  readonly property int commonBorderWidth: Utilities.dp(2)

  readonly property real enabledOpacity: 1.0
  readonly property real disabledOpacity: 0.7
  readonly property int defaultAnimationDuration: 300
}
