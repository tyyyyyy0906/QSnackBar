import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 2.3

Window {
    id: root
    width: 800
    height: 480
    visible: true
    title: qsTr("Hello World")

    SnackBarBasicItem {
        id: snackBar
        width: parent.width; height: bgWindowHeight;
    }

    Button {
        anchors.centerIn: parent
        width: 150; height: 50
        text: "click"
        onClicked: snackBar.snackShow(items(modes), ({ content: "Hello" }))
    }

    property int index: 0
    property var modes: ["message", "telcome", "volume"]
    property var items: (arr) => {
        if (index > 2) index = 0
        return arr[index++]
    }
}
