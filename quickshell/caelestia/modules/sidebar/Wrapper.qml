pragma ComponentBehavior: Bound

import QtQuick
import Caelestia
import Caelestia.Config
import qs.components

Item {
    id: root

    required property ScreenState screenState
    readonly property Props props: Props {}

    readonly property bool shouldBeActive: screenState.sidebar && Config.sidebar.enabled
    property real offsetScale: shouldBeActive ? 0 : 1

    visible: offsetScale < 1
    anchors.topMargin: (-implicitHeight - 5) * offsetScale
    implicitWidth: Tokens.sizes.sidebar.width
    implicitHeight: 500
    opacity: 1 - offsetScale

    Behavior on offsetScale {
        Anim {}
    }

    Loader {
        id: content

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: Tokens.padding.large
        anchors.margins: CUtils.clamp(anchors.bottomMargin - Config.border.thickness, 0, anchors.bottomMargin)

        active: root.shouldBeActive || root.visible

        sourceComponent: Content {
            implicitHeight: root.implicitHeight - content.anchors.bottomMargin - content.anchors.margins
            props: root.props
            screenState: root.screenState
        }
    }
}
