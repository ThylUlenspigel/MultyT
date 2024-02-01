import QtQuick
import QtQuick.Controls
import QtQuick.Window

import views 1.0
import com.tu.utilities 1.0

ApplicationWindow {
  id: root
  width: Utilities.dp(1050)
  height: Utilities.dp(1680)
  visible: true
  title: qsTr("Test")

  StackView {
      id: stackView
      anchors.fill: parent

      initialItem: componentStartView

      replaceEnter: Transition {
        PropertyAnimation {
          property: "opacity"
          from: 0
          to: 1
          duration: 500
          easing.type: Easing.InOutCirc
        }
      }
      replaceExit: Transition {
        PropertyAnimation {
          property: "opacity"
          from: 1
          to: 0
          duration: 200
          easing.type: Easing.OutInQuad
        }
      }
  }

  Component {
    id: componentStartView

    StartView {
      id: startView
      onNewGameStarted: function () {
        stackView.replace(componentGameView)
        gameController.startNewGame(true)
      }
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
      onNewGameRequested: function () {
        stackView.replace(componentStartView)
        gameController.startNewGame(true);
      }

      onContinueGameRequested: function () {
        gameController.startNewGame(false);
        stackView.replace(componentGameView)
      }

      onExitApplicationRequested: function () {
        root.close()
      }
    }
  }

  Connections {
    target: gameController

    function onGameEnded () {
      stackView.replace(componentEndView)
    }
  }
}
