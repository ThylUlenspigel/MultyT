pragma Singleton
import QtQuick
import Qt.labs.folderlistmodel 2.5
import com.tu.utilities 1.0

QtObject {
  readonly property int applicationWidth: Utilities.dp(1600)
  readonly property int applicationHeight: Utilities.dp(1024)

  readonly property int headerHeight: Utilities.dp(75)
  readonly property int sideMargin: Utilities.dp(10)

  readonly property int textFieldHeihgt: Utilities.dp(40)

  readonly property int textButtonHeihgt: Utilities.dp(40)
  readonly property int textButtonWidth: Utilities.dp(100)

  readonly property int menuTextButtonHeihgt: Utilities.dp(60)
  readonly property int menuTextButtonWidth: Utilities.dp(160)

  readonly property int menuButtonHeihgt: Utilities.dp(60)
  readonly property int menuButtonWidth: Utilities.dp(60)

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
    KeyRemove,
    KeyRefresh,
    KeyNext
  }

  readonly property ListModel digitPanelModel: ListModel {
    ListElement {
      path: "qrc:/assets/digit-1.svg"
      key: Common.KeyId.Key1
      columnSpan: 1
      rowSpan: 1
      row: 0
      column: 0
    }
    ListElement {
      path: "qrc:/assets/digit-2.svg"
      key: Common.KeyId.Key2
      columnSpan: 1
      rowSpan: 1
      row: 0
      column: 1
    }
    ListElement {
      path: "qrc:/assets/digit-3.svg"
      key: Common.KeyId.Key3
      columnSpan: 1
      rowSpan: 1
      row: 0
      column: 2
    }
    ListElement {
      path: "qrc:/assets/backspace.svg"
      key: Common.KeyId.KeyRemove
      columnSpan: 1
      rowSpan: 2
      row: 0
      column: 3
    }
    ListElement {
      path: "qrc:/assets/digit-4.svg"
      key: Common.KeyId.Key4
      columnSpan: 1
      rowSpan: 1
      row: 1
      column: 0
    }
    ListElement {
      path: "qrc:/assets/digit-5.svg"
      key: Common.KeyId.Key5
      columnSpan: 1
      rowSpan: 1
      row: 1
      column: 1
    }
    ListElement {
      path: "qrc:/assets/digit-6.svg"
      key: Common.KeyId.Key6
      columnSpan: 1
      rowSpan: 1
      row: 1
      column: 2
    }
    ListElement {
      path: "qrc:/assets/digit-7.svg"
      key: Common.KeyId.Key7
      columnSpan: 1
      rowSpan: 1
      row: 2
      column: 0
    }
    ListElement {
      path: "qrc:/assets/digit-8.svg"
      key: Common.KeyId.Key8
      columnSpan: 1
      rowSpan: 1
      row: 2
      column: 1
    }
    ListElement {
      path: "qrc:/assets/digit-9.svg"
      key: Common.KeyId.Key9
      columnSpan: 1
      rowSpan: 1
      row: 2
      column: 2
    }
    ListElement {
      path: "qrc:/assets/enter.svg"
      key: Common.KeyId.KeyAccept
      columnSpan: 1
      rowSpan: 2
      row: 2
      column: 3
    }
    ListElement {
      path: "qrc:/assets/digit-0.svg"
      key: Common.KeyId.Key0
      columnSpan: 3
      rowSpan: 1
      row: 3
      column: 0
    }    
    ListElement {
      path: "qrc:/assets/refresh.svg"
      key: Common.KeyId.KeyRefresh
      columnSpan: 2
      rowSpan: 1
      row: 4
      column: 0
    }
    ListElement {
      path: "qrc:/assets/next.svg"
      key: Common.KeyId.KeyNext
      columnSpan: 2
      rowSpan: 1
      row: 4
      column: 2
    }
  }

  enum Result {
    Undefinied = -1,
    Wrong,
    Right
  }
}
