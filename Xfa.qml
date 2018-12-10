import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id:r
    width: parent.width*0.7
    height: parent.height
    color: 'transparent'
    anchors.centerIn: parent
    visible:app.area===5
    property int paso: 0
    onVisibleChanged: {
        if(visible){
                r.paso=0
        }
    }
    onPasoChanged: {
        //console.log('Se requiere paso '+paso)
    }
    Column{
        anchors.centerIn: parent
        spacing: app.fs*0.5
        Text{
            text: 'Ingrese la fecha de terminacion:'
            font.pixelSize: 20
        }
        //1
        Row{
            spacing: app.fs
            visible:r.paso>=0
            onVisibleChanged: {
                if(visible){
                    tiNumAnio.focus=true
                }
            }
            Text{
                id:t1
                text: 'Año(AAAA)'
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: app.fs*10
                height: 30
                TextInput{
                    id:tiNumAnio
                    width: parent.width-app.fs
                    height: 24
                    font.pixelSize: 20
                    anchors.centerIn: parent
                    Keys.onReturnPressed: {
                        unik.writeRun(text+'\n')
                        r.paso=1
                    }
                }
            }
        }

        Row{
            spacing: app.fs
            visible:r.paso>=1
            onVisibleChanged: {
                if(visible){
                    tiNumMes.focus=true
                }
            }
            Text{
                text: 'Mes(MM)'
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: app.fs*10
                height: 30
                TextInput{
                    id:tiNumMes
                    width: parent.width-app.fs
                    height: 24
                    font.pixelSize: 20
                    anchors.centerIn: parent
                    Keys.onReturnPressed: {
                        unik.writeRun(text+'\n')
                        r.paso=2
                    }
                }
            }
        }

        Row{
            spacing: app.fs
            visible:r.paso>=2
            onVisibleChanged: {
                if(visible){
                    tiNumDia.focus=true
                }
            }
            Text{
                text: 'Dìa(DD)'
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: app.fs*10
                height: 30
                TextInput{
                    id:tiNumDia
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
}
