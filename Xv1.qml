import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id:r
    width: parent.width
    height: parent.height
    anchors.centerIn: parent
    visible:false
    property alias txt: t1.text
    Flickable{
        width: r.width-app.fs*2
        height: r.height
        anchors.centerIn: r
        contentWidth: r.width
        contentHeight: t1.contentHeight
        Text{
            id:t1
            width: r.width-app.fs*2
            wrapMode: Text.WordWrap
            font.pixelSize: 20
        }
    }

    Boton{
        w:app.fs*1.5
        h: w
        t: 'X'
        b: 'black'
        c:'white'
        d:'Cerrar'
        tp:1
        anchors.right: r.right
        anchors.rightMargin: app.fs*0.5
        anchors.top: r.top
        anchors.topMargin: app.fs*0.5
        onClicking: {
            r.visible=false
            app.area=0
        }
    }
}
