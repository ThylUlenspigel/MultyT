pragma Singleton
import QtQuick

// Container for global, not readonly properties.
QtObject {
  property int passedTaskCount: 0
  property int liveCount: 3
}
