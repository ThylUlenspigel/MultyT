import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import controls 1.0
import panels 1.0
import views 1.0
import com.tu.theme 1.0
import com.tu.global 1.0
import com.tu.utilities 1.0

Window {
  width: Utilities.dp(1050)
  height: Utilities.dp(1680)
  visible: true
  title: qsTr("Test")

  StackView {
      id: stackView
      anchors.fill: parent
      Component.onCompleted: function() {
          stackView.push(componentGameView)
      }
  }

  Component {
    id: componentSartView
    StartView {
      id: startView
    }
  }

  Component {
    id: componentGameView
    GameView {
      id:gameView
    }
  }

  Component {
    id: componentEndView
    EndView {
      id: endView
    }
  }

}
