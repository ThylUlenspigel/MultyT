pragma Singleton
import QtQuick
import Qt.labs.folderlistmodel 2.5
import com.tu.utilities 1.0

QtObject {
  readonly property int applicationWidth: Utilities.dp(1600)
  readonly property int applicationHeight: Utilities.dp(1024)

  readonly property int textFieldHeihgt: Utilities.dp(40)

  readonly property int textButtonHeihgt: Utilities.dp(40)
  readonly property int textButtonWidth: Utilities.dp(100)

  readonly property int menuTextButtonHeihgt: Utilities.dp(40)
  readonly property int menuTextButtonWidth: Utilities.dp(100)

  readonly property int digitButtonHeight: Utilities.dp(40)
  readonly property int digitButtonWidth: Utilities.dp(40)

  readonly property int lifeImageHeight: Utilities.dp(40)
  readonly property int lifeImageWidth: Utilities.dp(40)

  readonly property int starImageHeight: Utilities.dp(30)
  readonly property int starImageWidth: Utilities.dp(30)

  enum KeyId {
    Key0 = 0,
    Key1,
    Key2,
    Key3,
    Key4,
    Key5,
    Key6,
    Key7,
    Key8,
    Key9,
    KeyAccept,
    KeyRemove
  }

  readonly property ListModel digitPanelModel: ListModel {
    ListElement {
      path: "qrc:/assets/digit-1.svg"
      key: Common.KeyId.Key1
    }
    ListElement {
      path: "qrc:/assets/digit-2.svg"
      key: Common.KeyId.Key2
    }
    ListElement {
      path: "qrc:/assets/digit-3.svg"
      key: Common.KeyId.Key3
    }
    ListElement {
      path: "qrc:/assets/digit-4.svg"
      key: Common.KeyId.Key4
    }
    ListElement {
      path: "qrc:/assets/digit-5.svg"
      key: Common.KeyId.Key5
    }
    ListElement {
      path: "qrc:/assets/digit-6.svg"
      key: Common.KeyId.Key6
    }
    ListElement {
      path: "qrc:/assets/digit-7.svg"
      key: Common.KeyId.Key7
    }
    ListElement {
      path: "qrc:/assets/digit-8.svg"
      key: Common.KeyId.Key8
    }
    ListElement {
      path: "qrc:/assets/digit-9.svg"
      key: Common.KeyId.Key9
    }

    ListElement {
      path: "qrc:/assets/backspace.svg"
      key: Common.KeyId.KeyRemove
    }
    ListElement {
      path: "qrc:/assets/digit-0.svg"
      key: Common.KeyId.Key0
    }
    ListElement {
      path: "qrc:/assets/confirm.svg"
      key: Common.KeyId.KeyAccept
    }
  }

}
