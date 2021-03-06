import QtQuick 2.3 as OfficialMain
import QtQuick.Controls 2.3 as OfficialControl

SnackBarDelegateItem {
    id: root
    registerComponmentName: "volume"

    readonly property string title: root.registerComponmentName

    OfficialMain.Text {
        id: content
        anchors.centerIn: parent
        font.pixelSize: 36
        text: root.title
    }
}
