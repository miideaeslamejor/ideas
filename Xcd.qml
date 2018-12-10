import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id:r
    width: parent.width*0.7
    height: parent.height
    color: 'transparent'
    anchors.centerIn: parent
    visible:app.area===3
    property int paso: 0
    onVisibleChanged: {
        if(visible){
            r.paso=0
        }
    }

    //1
    Column{
        spacing: app.fs
        visible:r.paso===1
        anchors.centerIn: r
        onVisibleChanged: {
            if(visible){
                tiCodDon.focus=true
            }
        }
        Text{
            text: 'Ingrese el codigo de la idea a la que desea hacer su donacion'
            font.pixelSize: 20
        }
        Row{
            Text{
                text: 'Código: '
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: app.fs*10
                height: 30
                TextInput{
                    id:tiCodDon
                    width: parent.width-app.fs
                    height: 24
                    font.pixelSize: 20
                    anchors.centerIn: parent
                    Keys.onReturnPressed: {
                        unik.writeRun(text+'\n')
                        r.paso++
                    }
                }
            }
        }
    }

    //2
    Row{
        spacing: app.fs
        visible:r.paso===2
        anchors.centerIn: r
        onVisibleChanged: {
            if(visible){
                tiValDon.focus=true
            }
        }
        Text{
            text: 'Ingrese el valor a donar: '
            font.pixelSize: 20
        }
        Rectangle{
            border.width: 2
            radius: 6
            width: app.fs*10
            height: 30
            TextInput{
                id:tiValDon
                width: parent.width-app.fs
                height: 24
                font.pixelSize: 20
                anchors.centerIn: parent
                Keys.onReturnPressed: {
                    unik.writeRun(text+'\n')
                    r.paso++
                }
            }
        }
    }

    //3
    Row{
        spacing: app.fs
        visible:r.paso===3
        anchors.centerIn: r
        onVisibleChanged: {
            if(visible){
                tiNomDon.focus=true
            }
        }
        Text{
            id:t1
            text: 'Ingrese su nombre: '
            font.pixelSize: 20
        }
        Rectangle{
            border.width: 2
            radius: 6
            width: r.width-t1.contentWidth-app.fs*2
            height: 30
            TextInput{
                id:tiNomDon
                width: parent.width-app.fs
                height: 24
                font.pixelSize: 20
                anchors.centerIn: parent
                Keys.onReturnPressed: {
                    unik.writeRun(text+'\n')
                    r.paso++
                }
            }
        }
    }

    //4
    Column{
        spacing: app.fs
        visible:r.paso===4
        anchors.centerIn: r
        onVisibleChanged: {
            if(visible){
                tiNumCuenta.focus=true
            }
        }
        Text{
            text: 'Ingrese su numero de cuenta en caso de devolucion'
            font.pixelSize: 20
        }
        Row{
            spacing: app.fs
            Text{
                text: 'Número de cuenta: '
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: app.fs*10
                height: 30
                TextInput{
                    id:tiNumCuenta
                    width: parent.width-app.fs
                    height: 24
                    font.pixelSize: 20
                    anchors.centerIn: parent
                    Keys.onReturnPressed: {
                        unik.writeRun(text+'\n')
                        r.paso++
                    }
                }
            }
        }
    }

    //5 Correo
    Column{
        spacing: app.fs
        visible:r.paso===5
        anchors.centerIn: r
        onVisibleChanged: {
            if(visible){
                tiEmail.focus=true
            }
        }
        Text{
            text: 'Ingrese su coreo electronico'
            font.pixelSize: 20
        }
        Row{
            spacing: app.fs
            Text{
                id:t2
                text: 'E-Mail: '
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: r.width-t2.contentWidth-app.fs*2
                height: 30
                TextInput{
                    id:tiEmail
                    width: parent.width-app.fs
                    height: 24
                    font.pixelSize: 20
                    anchors.centerIn: parent
                    Keys.onReturnPressed: {
                        unik.writeRun(text+'\n')
                        r.paso++
                    }
                }
            }
        }

    }


    //6 Ingrese su direccion de residencia actual:
    Column{
        spacing: app.fs
        visible:r.paso===6
        anchors.centerIn: r
        onVisibleChanged: {
            if(visible){
                tiLugRes.focus=true
            }
        }
        Text{
            text: 'Ingrese su direccion de residencia actual'
            font.pixelSize: 20
        }
        Row{
            spacing: app.fs
            Text{
                id:t3
                text: 'Lugar: '
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: r.width-t3.contentWidth-app.fs*2
                height: 30
                TextInput{
                    id:tiLugRes
                    width: parent.width-app.fs
                    height: 24
                    font.pixelSize: 20
                    anchors.centerIn: parent
                    Keys.onReturnPressed: {
                        unik.writeRun(text+'\n')
                    }
                }
            }
        }
    }


    //7 Ingrese su numero de cuenta en caso de devolucion
    Column{
        spacing: app.fs
        visible:r.paso===7
        anchors.centerIn: r
        onVisibleChanged: {
            if(visible){
                tiNumCuentaDev.focus=true
            }
        }
        Text{
            text: 'Ingrese su numero de cuenta en caso de devolucion'
            font.pixelSize: 20
        }
        Row{
            spacing: app.fs
            Text{
                text: 'Número de Cuenta: '
                font.pixelSize: 20
            }
            Rectangle{
                border.width: 2
                radius: 6
                width: app.fs*10
                height: 30
                TextInput{
                    id:tiNumCuentaDev
                    width: parent.width-app.fs
                    height: 24
                    font.pixelSize: 20
                    anchors.centerIn: parent
                    Keys.onReturnPressed: {
                        unik.writeRun(text+'\n')
                        app.area=1
                        xApp.focus=true
                    }
                }
            }
        }

    }


    Text{
        text: 'Paso '+r.paso+' de 7'
        font.pixelSize: 20
    }
}
