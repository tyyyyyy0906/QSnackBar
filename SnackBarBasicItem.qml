import QtQuick 2.3
import QtQuick.Controls 1.3 as QtControl

Item {
    id: root

    readonly property real bgWindowHeight: background.height

    function snackShow(register, data) {
        console.log("arguments data = ", data["content"])
        if (typeof register !== "string" && typeof data !== "object") {
            console.error("arguments type error!!!"); return
        }
        //demo test:
        container.push({ item: _.activityMap[register].page || null, replace: false, "properties": { "dataMode": data }})
        if (!!_.activityMap[register].page) _.show = true
    }

    function snackHide(register) {
        if (typeof register !== "string") { console.error("pop arguments type error"); return }
        //demo test
        container.pop({ item: _.activityMap[register].page || null })
        if (!!_.activityMap[register].page) _.show = false
    }

    function backstageClose(register) {
        container.pop({ item: _.activityMap[register].page || null })
    }

    MouseArea { anchors.fill: parent }
    Rectangle {
        id: background
        width: parent.width; height: 100
        color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
    }

    y: _.show ? 0 : -parent.height
    opacity: _.show ? 1 : 0

    Behavior on y       { YAnimator       { duration: 450 }}
    Behavior on opacity { OpacityAnimator { duration: 450 }}

    QtObject {
        id: _

        property Component message: SnackBarForMessage{}
        property Component volume : SnackBarForVolume {}
        property Component telcome: SnackBarForTelCome{}

        readonly property var activityMap: ({
            "message": { page: _.message },
            "volume" : { page: _.volume  },
            "telcome": { page: _.telcome }
        })
        property bool show  : false
        property bool hold  : false
        property var  cacher: ([])

        property Timer deley: Timer {
            interval: 3000; repeat: false
            onTriggered: _.show = false
        }
    }

    QtControl.StackView {
        id: container
        width : parent.width
        height: (parent.height - 2)  //avoid clip effect
        clip: true
        initialItem: { "item": _.telcome, "properties": { opacity: 0 } }
        delegate: QtControl.StackViewDelegate {
            pushTransition: QtControl.StackViewTransition {
                ParallelAnimation {
                    PropertyAnimation {
                        target: enterItem; properties: "opacity"
                        from: 0; to: 1; duration: 400
                    }
                    PropertyAnimation {
                        target: enterItem; properties: "y"
                        from: -container.height; to: 0; duration: 400
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: exitItem; properties: "scale"
                        from: 1; to: 0; duration: 400
                        onStopped: exitItem.itemClose(backstageClose) || function() { console.warn("itemClose dosen't exist")}()
                    }
                    PropertyAnimation {
                        target: exitItem; properties: "opacity"
                        from: 1; to: 0; duration: 350
                    }
                }
            }

            function transitionFinished(properties) {
                console.log("current stack enterItem = ", properties.enterItem.title)
                properties.enterItem.itemShows(snackHide)
            }
        }

        onDepthChanged: console.log("current stack depth number = ", depth)
    }

    Component.onDestruction: container.clear()
}
