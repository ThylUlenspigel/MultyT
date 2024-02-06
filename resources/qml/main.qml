import QtQuick
import QtQuick.Controls
import QtQuick.Window

import views 1.0
import panels 1.0
import com.tu.utilities 1.0
import com.tu.common 1.0

ApplicationWindow {
  id: root
  width: Utilities.dp(1050)
  height: Utilities.dp(1680)
  visible: true
  title: qsTr("Test")

  header: HeaderPanel {
    id: header

    onMenuButtonPressed: function() {
      menuPanel.menuItemDisabled = (stackView.currentItem.objectName === "StartGameScreen")? Common.MenuId.NewGame
                                                                                           : Common.MenuId.Undefined
    }

    menuPanel.onMenuItemSelected: function (menuId) {
      switch(menuId) {
      case Common.MenuId.NewGame:
        console.log("NG")
        if(stackView.currentItem.objectName !== "StartGameScreen" ) {
          stackView.replace(componentStartView)
        }
        gameController.startNewGame(true)
        gameController.setPlayerName("")
        menuPanel.close()
        break
      case Common.MenuId.Records:
        console.log("Popup with records table")
        infoPopup.open();
        infoPopup.showRecords = true
        gameController.loadRecords()
        menuPanel.close()
        break
      case Common.MenuId.About:
        console.log("Popup with about table")
        infoPopup.open();
        infoPopup.showRecords = false
        menuPanel.close()
        break
      case Common.MenuId.Exit:
        root.close()
        break
      }
    }
  }

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
        gameController.startNewGame(true)
        gameController.setPlayerName("")
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

  InfoPopup {
    id: infoPopup

    x: Common.infoPopupMargin
    y: Common.infoPopupMargin
    width: parent.width - 2*Common.infoPopupMargin
    height: parent.height - 2*Common.infoPopupMargin

    model: recordsModel

    onOpened: function() {
      gameController.onPause = true
      header.enabled = false
    }

    onClosed: function() {
      header.enabled = true
      header.menuPanel.open()
    }
  }

  Connections {
    target: gameController

    function onGameEnded () {
      stackView.replace(componentEndView)
    }
  }
}
