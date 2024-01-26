import QtQuick

import com.tu.theme 1.0
import controls 1.0

BodyText {
  id: root

  property int duration: 1000

  text: internal.setTiming(root.duration)
  wrapMode: Text.NoWrap
  fontSizeMode: Text.Fit

  QtObject {
    id: internal

    function minutes( length ) {
      var min = Math.floor( length / 60 ) % 60;
      return ( min < 10 ) ?  "0" + min  :  min ;
    }

    function seconds( length ) {
        var sec = Math.floor( length % 60 );
        return ( sec < 10 ) ? "0" + sec  : sec;
    }

    function setTiming( drtn ) {
      var inSec = drtn/1000;
      if( root.duration <= 0 ) {
          return qsTr( "00:00" )
      }
      if( root.duration !== "0" ) {
          return qsTr(minutes(inSec) + ":" + seconds(inSec))
      }
    }
  }
}
