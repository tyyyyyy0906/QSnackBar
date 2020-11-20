import QtQuick 2.3 as OfficialMain
import QtQuick.Controls 2.3 as OfficialControl

OfficialMain.Item {
    id: root

    property string registerComponmentName: "isNaN"
    property var    dataMode: ({ /* content(string), duration(int), otherUserSelf(any)*/ })

    function itemClose(callBack) { _.showTime.stop(); callBack(registerComponmentName) }
    function itemShows(callBack) {
        _.showTime.restart()
        _.callBack = callBack || function() {}
    }

    onDataModeChanged: _.modeParse()
    OfficialMain.QtObject {
        id: _

        property var callBack: undefined
        property var showTime: OfficialMain.Timer {
            interval: 3000; repeat: false; running: false
            onTriggered: { _.callBack(registerComponmentName) }
        }

        function typerCheck(type) {
            return Object.prototype.toString.call(type).slice(8, -1)
        }
        function modeParse() { console.log("modeParse function") }
    }
}
