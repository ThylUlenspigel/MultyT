import QtQuick
import QtQuick.Controls

import views 1.0
import com.tu.utilities 1.0

Window {
  id: root
  width: Utilities.dp(1050)
  height: Utilities.dp(1680)
  visible: true
  title: qsTr("Test")

  StackView {
      id: stackView
      anchors.fill: parent
      Component.onCompleted: function() {
          stackView.push(componentStartView)
      }
  }

  Component {
    id: componentStartView
    StartView {
      id: startView
      onNewGameStarted: function () {
        stackView.push(componentGameView)
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
        stackView.push(componentStartView)
        gameController.startNewGame(true);
      }

      onContinueGameRequested: function () {
        gameController.startNewGame(false);
        stackView.push(componentGameView)
      }

      onExitApplicationRequested: function () {
        root.close()
      }
    }
  }

  Connections {
    target: gameController

    function onGameEnded () {
      stackView.push(componentEndView)
    }
  }
}
