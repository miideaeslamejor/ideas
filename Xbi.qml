import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id:r
    width: parent.width*0.7
    height: parent.height
    color: 'transparent'
    anchors.centerIn: parent
    visible:app.area===2
    onVisibleChanged: {
        if(visible){
            tiNomIdea.focus=true
        }
    }

        //1
        Column{
            spacing: app.fs
            anchors.centerIn: r
            Text{
                id:t1
                text: 'Ingrese el campo de la ideas que desea conocer'
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: r.width-t1.contentWidth-app.fs*2
                height: 30
                TextInput{
                    id:tiNomIdea
                    width: parent.width-app.fs
                    height: 24
                    font.pixelSize: 20
                    anchors.centerIn: parent
                    Keys.onReturnPressed: {
                        unik.writeRun(text+'\n')
                        app.area=0
                    }
                }
            }
        }


}
