pragma Singleton
import QtQuick

// Container for global, not readonly properties.
QtObject {
  property int passedTaskCount: 5
  property int lifesCount: 3
}
