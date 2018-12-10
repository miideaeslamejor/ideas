/*
  Esta aplicaciòn fue desarrollada por David Ramos
  utilizando el FrameWork Qt, QtQuick, Unik y Python

  Todo el SoftWare es Còdigo Abierto, Open Source
  bajo las licencias GPL y LGPL.

  Qml es un lenguaje de Programaciòn para el desarrollo
  ràpido de aplicaciones del tipo Qt Quick.

  QtQuick parte del FrameWork Qt.
  Fuè creado por el Qt Project
  como una nueva manera, màs dinàmica y àgil
  de programar aplicaciones Qt
  con Interfaz Gràficas de Ûltima Generaciòn.

  Este còdigo està programado en QML, el Qt Meta Lenguaje
  de Qt para el entorno QtQuick.

  Qml es un lenguaje Declarativo Basado en JavaScript,
   es por este motivo que para programar las funciones lògicas
   que nos conectan con Python, utilizamos funciones JavaScript
   conjuntamente con el motor Qml Unik para interactuar
   con procesos QProccess cuya Salida Estandar supervisamos
   en un elemento Qml que hemos denominado LogView.

*/
import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0

ApplicationWindow {
    id:app
    visible: true
    width: 640
    height: 480
    title: "Menu Donaciònes"
    color: "white"
    visibility: 'Maximized'
    property string moduleName: 'ideas'
    property int area: -1
    property int fs: width*0.02

    onAreaChanged: {
        if(area===0){
            xApp.focus=true
        }
    }

    Settings{
        id: appSettings
        category: 'conf-ideas'
        property bool logViewVisible

        //Variables de Actualizaciòn
        property string ubicacionExePython
        property string ubicacionCodigoPython

        property int lvh
    }
    Item{
        id:xApp
        anchors.fill: parent
        Connections {target: unik;onUkStdChanged: procesar((''+unik.ukStd));}
        Connections {target: unik;onStdErrChanged: procesar((''+unik.ukStd));}

        Column{
            id: menuPrincipal
            anchors.centerIn: parent
            spacing: 10
            visible:app.area===0
            Text {
                text: '<b>¿Que opción desea?</b>'
                font.pixelSize: 28
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button{//1
                text: '<b>1) Adicionar Idea</b>'
                font.pixelSize: 20
                onClicked: {
                    app.area=1
                    unik.writeRun('1\n')
                }
            }
            Button{//2
                text: '<b>2) Buscar Idea a Apoyar</b>'
                font.pixelSize: 20
                onClicked: {
                    app.area=2
                    unik.writeRun('2\n')
                }
            }
            Button{//3
                text: '<b>3) Donar a Idea</b>'
                font.pixelSize: 20
                onClicked: {
                    app.area=3
                    unik.writeRun('3\n')
                }
            }
            Button{//4
                text: '<b>4) Enlistar Donantes de una idea</b>'
                font.pixelSize: 20
                onClicked: {
                    app.area=4
                    unik.writeRun('4\n')
                }
            }
            Button{//5
                text: '<b>5) Ingresar Fecha para Actualizaciòn de Estados</b>'
                font.pixelSize: 20
                onClicked: {
                    app.area=5
                    unik.writeRun('5\n')
                }
            }
            Button{//6
                text: '<b>6) Guardar datos de Informaciòn</b>'
                font.pixelSize: 20
                onClicked: {
                    app.area=6
                    unik.writeRun('6\n')
                }
            }
            Button{//7
                text: '<b>7) Leer y cargar datos de Informaciòn</b>'
                font.pixelSize: 20
                onClicked: {
                    app.area=7
                    unik.writeRun('7\n')
                }
            }
            Button{//8
                text: '<b>8) Salir</b>'
                font.pixelSize: 20
                onClicked: Qt.quit()
            }
        }
        Text {
            id: txtSplash
            text: '<b>Ideas</b>'
            font.pixelSize: 48
            anchors.centerIn: parent
            visible:app.area===-1
        }
        Xfd{
            id:xFd
        }//Formulario Datos
        Xgi{
            id:xGi
        }//Guardar Idea
        Xbi{
            id:xBi
        }//Buscar Idea
        Xcd{
            id:xCd
        }//Cargar Donación
        Xed{
            id:xEd
        }//Enlistar donantes
        Xfa{
            id:xFa
        }//Fecha de Actualizaciòn
        Xca{
            id:xCa
        }//Cargar Archivo
        Xv1{
            id:xV1
        }//Visor 1

        LogView{
            width: parent.width
            height: appSettings.lvh
            fontSize: app.fs
            topHandlerHeight: Qt.platform.os!=='android'?app.fs*0.25:app.fs*0.75
            anchors.bottom: parent.bottom
            //visible: appSettings.logViewVisible
        }
        focus:true
        Keys.onEscapePressed:  Qt.quit()
        Keys.onDigit0Pressed: {
            unik.writeRun('\n')
        }
        Keys.onDigit1Pressed: {
            app.area=1
            unik.writeRun('1\n')
        }
        Keys.onDigit2Pressed: {
            app.area=2
            unik.writeRun('2\n')
        }
        Keys.onDigit3Pressed: {
            app.area=3
            unik.writeRun('3\n')
        }
        Keys.onDigit4Pressed: {
            app.area=4
            unik.writeRun('4\n')
        }
        Keys.onDigit5Pressed: {
            app.area=5
            unik.writeRun('5\n')
        }
        Keys.onDigit6Pressed: {
            app.area=6
            unik.writeRun('6\n')
        }
        Keys.onDigit7Pressed: {
            app.area=7
            unik.writeRun('7\n')
        }
    }
    Timer{
        id:tstart
        running: true
        repeat: false
        interval: 2000
        onTriggered: {
            iniciarPython()
        }
    }
    FileDialog {
        id: fileDialog1
        title: "Seleccione el Ejecutable Python"
        visible: false
        onAccepted: {
            var f0=fileDialog1.fileUrls[0]
            var f1
            if(Qt.platform.os==='windows'){
                f1=(''+f0).replace('file:///','')
            }else{
                f1=(''+f0).replace('file://','')
            }
            appSettings.ubicacionExePython=f1
            console.log('Ejecutable Python: '+f1)
        }
        onRejected: {

        }
        Component.onCompleted: {
            var f0=(''+unik.getPath(4)).replace('/Roaming/nextsigner/unik','/Local/Programs/Python/Python37-32')
            folder='file:///'+f0
            if(appSettings.ubicacionExePython===''){
                appSettings.ubicacionExePython=f0+'/python.exe'
                console.log('Ubicación por defecto de Python: '+f0)
            }
        }
    }
    FileDialog {
        id: fileDialog2
        title: "Seleccione el Código Python"
        visible: false
        onAccepted: {
            var f0=fileDialog2.fileUrls[0]
            var f1
            if(Qt.platform.os==='windows'){
                f1=(''+f0).replace('file:///','')
            }else{
                f1=(''+f0).replace('file://','')
            }
            appSettings.ubicacionCodigoPython=f1
            console.log('Código Python: '+f1)
            iniciarPython()
        }
        onRejected: {

        }
        Component.onCompleted: {
            var f0=''+appsDir+'/ideas'
            folder='file:///'+f0
            if(appSettings.lvh<=0){
                appSettings.lvh=300
            }
            if(appSettings.ubicacionCodigoPython===''){
                appSettings.ubicacionCodigoPython=(f0+'/proyecto.py').replace('file:///','')
                console.log('Ubicación por defecto de Código Python: '+(f0+'/proyecto.py').replace('file:///',''))
            }
        }
    }
    Component.onCompleted: {


        //->[1] Creamos de manera automàtica un archivo del tipo .ukl para que la aplicaciòn ideas aparezca en la lista de aplicaciones instaladas en unik.
        var ukldata='-folder='+appsDir+'/'+app.moduleName+' -cfg'
        var ukl=appsDir+'/link_'+app.moduleName+'.ukl'
        unik.setFile(ukl, ukldata)
        ukldata='-folder='+appsDir+'/'+app.moduleName+' -git=https://github.com/nextsigner/ideas.git -cfg'
        ukl=appsDir+'/link_'+app.moduleName+'_update.ukl'
        unik.setFile(ukl, ukldata)
        //<-[1]


        //->[2] Creamos automàticamente un Acceso Directo en el Escritorio para ejecutar ideas
        var nclink
        if(Qt.platform.os==='linux'){
            unik.createLink(appExec+' -folder='+appsDir+'/ideas -cfg', unik.getPath(6)+'/ideas.desktop', 'ideas', 'It is created by Unik Qml Engine with the UnikTools')
            unik.createLink(appExec+' -folder='+appsDir+'/ideas -git=https://github.com/nextsigner/ideas.git  -cfg', unik.getPath(6)+'/ideas_update.desktop', 'ideas_update', 'It is created by Unik Qml Engine with the UnikTools')
        }
        if(Qt.platform.os==='windows'){
            var flc='-folder='+appsDir+'/ideas -cfg'
            var flc2='-folder='+appsDir+'/ideas -git=https://github.com/nextsigner/ideas.git -cfg'
            unik.createLink(appExec, flc, unik.getPath(6)+'/ideas.lnk',"It is a file created by Unik Qml Engine", appsDir+'/ideas' )
            unik.createLink(appExec, flc2, unik.getPath(6)+'/ideas_update.lnk',"It is a file created by Unik Qml Engine", appsDir+'/ideas' )
        }
        //<-[2]

        //Mostramos informaciòn en LogView con el mètodo JavaScript llamado console.log()
        console.log('Ubicación del Ejecutable Python: '+appSettings.ubicacionExePython)
        console.log('Ubicación del Código Python: '+appSettings.ubicacionCodigoPython)
    }
    function iniciarPython(){
        //QProccess C++ Object
        unik.run('"'+appSettings.ubicacionExePython+'" "'+appSettings.ubicacionCodigoPython+'"')
    }
    function procesar(l){
        var m0
        //Buscar Idea
        if((''+l).indexOf("#Nombre de Creador:")>=0){
            m0=(''+l).split('1)Adicionar idea')
            xV1.txt=m0[0]
            xV1.visible=true
            return
        }
        //Lista Donantes
        if((''+l).indexOf("#Nombre de donante:")>=0){
            m0=(''+l).split('1)Adicionar idea')
            xV1.txt=m0[0]
            xV1.visible=true
            return
        }

        if((''+l).indexOf('Que opcion desea')>=0){
            app.area=0
            return
        }
        if((''+l).indexOf('Ingrese el documento de identidad de la persona que brinda la idea')>=0){
            xFd.paso=1
            return
        }
        if((''+l).indexOf('Ingrese el nombre de la persona')>=0){
            xFd.paso=2
            return
        }
        if((''+l).indexOf('Ingrese el numero de cuenta donde se podra hacer el aporte')>=0){
            xFd.paso=3
            return
        }
        if((''+l).indexOf('Ingrese el link de una pagina web donde se pueda profundizar la descripcion del programa')>=0){
            xFd.paso=4
            return
        }
        if((''+l).indexOf('Ingrese la fecha de terminacion')>=0){
            xFd.paso=5
            return
        }
        if((''+l).indexOf('Ingrese el nombre de la idea')>=0){
            xFd.paso=8
            return
        }
        if((''+l).indexOf('Realice una descripcion del producto del software')>=0){
            xFd.paso=9
            return
        }
        if((''+l).indexOf('Ingrese el campo en que se desarrolla la idea')>=0){
            xFd.paso=10
            return
        }
        if((''+l).indexOf('Ingrese el valor del minimo aporte que se podra realizar')>=0){
            xFd.paso=11
            return
        }
        if((''+l).indexOf('Ingrese el valor minimo para poder elaborar la idea')>=0){
            xFd.paso=12
            return
        }

        //Ingresar Cargar Donaciones
        if((''+l).indexOf('Ingrese el codigo de la idea a la que desea hacer su donacion:')>=0){
            xCd.paso=1
            return
        }
        if((''+l).indexOf('Ingrese su numero de cuenta en caso de devolucion')>=0){
            xCd.paso=7
            return
        }
    }
}
