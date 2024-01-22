pragma Singleton
import QtQuick
import QtQuick.Window
import QtQuick.Controls

QtObject {
  id: root

  property StackView appStackView: null

  /* Sice on small high dpi screens the window size is too large we apply a small correction
    to make it proportional
    The formula used is purely subjective
 */
  readonly property real smallScreenSizeCorrection: Screen.pixelDensity
                                                    > 4 ? 1 / (Math.log2(
                                                                 Screen.pixelDensity) - 1) : 1
  /*
    Function for calulating desity independet pixels.
    Desired logical size is passed as parameter, then it is multiplied by pixel density of the screen.
    Due to pixel desity unit (dots per milimeter) value needs to be multiplied by 25.4 to get
    number of dots per inch. After that value needs to be devided by 160 which is standard screen desity.
    */
  function dp(pixels) {
    return pixels * Screen.pixelDensity * smallScreenSizeCorrection * 25.4 / 160
  }

  function ptToDp(point) {
    return dp(point * 1.33)
  }
}
