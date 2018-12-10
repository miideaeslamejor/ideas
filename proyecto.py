import shelve

class Idea:
    titulo = ""
    descripcion = ""
    campo = ""
    minaporte = 0.0
    mindinero = 0.0
    estado = ""
    fechater = ""
    fechaentrega = ""
    valoract = 0.0
    documentoper = ""
    codigo = ""
    def __init__ (self,t,d,c,ma,md,es,ft,fe,v,dp,cd):
        self.titulo = t
        self.descripcion = d
        self.campo = c
        self.minaporte = ma
        self.mindinero = md
        self.estado = es
        self.fechater = ft
        self.fechaentrega = fe
        self.valoract = v
        self.documentoper = dp
        self.codigo = cd
class Persona:
    nombre = ""
    documento = ""
    cuenta = ""
    pagina = ""
    def __init__ (self,n,d,c,p):
        self.nombre = n
        self.documento = d
        self.cuenta = c
        self.pagina = p
class Donador:
    nombre = ""
    mail = ""
    direccion = ""
    valordon = 0.0
    cuenta = ""
    codigoadon = ""
    def __init__ (self,n,m,d,v,c,cad):
        self.nombre = n
        self.cuenta = c
        self.mail = m
        self.valordon = v
        self.direccion = d
        self.codigoadon = cad
class Fecha:
    año = 0
    mes = 0
    dia = 0
    def __init__ (self,a,m,d):
        self.año = a
        self.mes = m
        self.dia = d
    def crearfecha(self):
        return (str(self.año)+"/"+str(self.mes)+"/"+str(self.dia))
    
def adicionar(cosa,arreglo):
    arreglo.append(cosa)

def actualizarestado (año,mes,dia,ideas):
    rta= ""
    for vc in range (len(ideas)):
        if (ideas[vc].fechater.año == año):
            if(ideas[vc].fechater.mes == mes):
                if(ideas[vc].fechater.dia > dia):
                    rta = "SI"
                elif(ideas[vc].fechater.dia <= dia):
                    if(ideas[vc].valoract >= ideas[vc].mindinero):
                        rta = "NO PERO SI"
                    elif(ideas[vc].valoract < ideas[vc].mindinero):
                        rta = "NO PERO TAMPOCO"
            if(ideas[vc].fechater.mes < mes):
                if(ideas[vc].valoract >= ideas[vc].mindinero):
                        rta = "NO PERO SI"                        
                elif(ideas[vc].valoract < ideas[vc].mindinero):
                        rta = "NO PERO TAMPOCO"                        
            if(ideas[vc].fechater.mes > mes):
                rta = "SI"                
        if(ideas[vc].fechater.año > año):
            rta = "SI"            
        if(ideas[vc].fechater.año < año):
            if(ideas[vc].valoract >= ideas[vc].mindinero):
                rta = "NO PERO SI"
            elif(ideas[vc].valoract < ideas[vc].mindinero):
                rta = "NO PERO TAMPOCO"
        if(rta == "SI"):
            ideas[vc].estado = "Abierto"
        if(rta == "NO PERO SI"):
            ideas[vc].estado = "Cerrado y cumplió meta"
        if(rta == "NO PERO TAMPOCO"):
            ideas[vc].estado = "Cerrado y no cumplió meta"    

donantes,ideas,personas = [],[],[]
opc = ""
print("¡¡¡ BIENVENIDO A NUESTRA APLICACIÓN !!!")
while (opc != "8"):
    opc = input("\nMenu de ocpiones:\n\n1)Adicionar una idea. \n2)Buscar idea a apoyar. \n3)Donar a una idea. \n4)Enlistar donantes de una idea." +
                "\n5)Ingresas fecha para actualizacion de estados." +"\n6)Guardar datos de informacion. \n7)Leer y cargar datos de informacion." +
                "\n8)Salir \nQue opcion desea:  ")
    if(opc == "1"):
        verificacion = ""
        documento = input ("Ingrese el documento de identidad de la persona que brinda la idea:  ")
        if ((len(documento) == 8) or (len(documento) == 10)):
            persona= Persona(input("Ingrese el nombre de la persona:  "),
                             documento,
                             input("Ingrese el numero de cuenta donde se podra hacer el aporte:  "),
                             input("Ingrese el link de una pagina web donde se pueda profundizar la descripcion del programa:  "))
        if((len(documento) != 8) and (len(documento) != 10)):
            print("\Ingresó un documento de intedidad no valido.(Deben ser 8 o 10 digitos)")
            verificacion = "NO"
        if(verificacion == ""):
            año = int(input("Ingrese la fecha de terminacion:  Año(AAAA): "))
            mes = int(input("                                  Mes(MM):  "))
            dia = int(input("                                  Día(DD):  "))
            if((año >= 2100) or (año < 2018)):
                print("Ingreso un año demasiado alto o sin sentido.")
                verificacion = "NO"
            if((mes <= 0) or(mes > 12)):
                print("Ingreso un mes que no tiene sentido.")
                verificacion = "NO"
            if((dia < 1) or (dia > 31)):
                print("Ingreso un dia que no tiene sentido.")
                verificacion = "NO"
        if(verificacion == ""):
            añoe = int(input("Ingrese la fecha de entrega del proyecto o fecha maxima:  Año(AAAA):  "))
            mese = int(input("                                                          Mes(MM):  "))
            diae = int(input("                                                          Día(DD):  "))
            if((añoe >= 2100) or (añoe < 2018)):
                print("Ingreso un año demasiado alto o sin sentido.")
                verificacion = "NO"
            if((mese <= 0) or(mese > 12)):
                print("Ingreso un mes que no tiene sentido.")
                verificacion = "NO"
            if((diae < 1) or (diae > 31)):
                print("Ingreso un dia que no tiene sentido.")
                verificacion = "NO"
            if(verificacion == ""):
                fechater = Fecha(año,mes,dia)
                fechaentrega = Fecha(añoe,mese,diae)
                idea = Idea(input("Ingrese el nombre de la idea:  "),
                            input("Realice una descripcion del producto del software, y para que servira cuando este elaborado:  "),
                            input ("Ingrese el campo en que se desarrolla la idea (salud, comercio, etc.):  "),
                            float(input("Ingrese el valor del minimo aporte que se podra realizar:  ")),
                            float(input("Ingrese el valor minimo para poder elaborar la idea:  ")),
                            "Abierto", 
                            fechater,
                            fechaentrega,
                            0.0,
                            documento,
                            documento+fechater.crearfecha())
                adicionar(persona,personas)
                adicionar(idea,ideas)
    elif(opc == "2"):
        verificacion = ""
        if((len(ideas)) != 0):
            campo = input("Ingrese el campo de la ideas que desea conocer:  ")
            for vc in range (len(ideas)):
                if (ideas[vc].campo == campo):
                    verificacion = "SI"
                    print("\n#Nombre de Idea: " + ideas[vc].titulo + "\n  Campo:  " + campo + "\n  Nombre de Creador:  " + personas[vc].nombre +
                          "\n  Codigo: " + ideas[vc].codigo +"\n  Descripcion:  "+ ideas[vc].descripcion + "\n  Pagina web de la idea:  " + personas[vc].pagina +
                          "\n  Valor minimo para poder aportar:  " + str(ideas[vc].minaporte)+"\n  Valor para desarrollar la idea: " + str(ideas[vc].mindinero) +
                          "\n  Estado: " + ideas[vc].estado + "\n  Fecha de terminacion(AAAA/MM/DD): " +
                          ideas[vc].fechater.crearfecha() + "\n  Fecha de entrega: " + ideas[vc].fechaentrega.crearfecha() +
                          "\n  Valor recaudado hasta el momento:  " + str(ideas[vc].valoract))
            if(verificacion == ""):
                print("\nNo se encontraron ideas con el campo ingresado.")
        elif((len(ideas)) == 0):
            print ("\nAun no se han registrado ideas en la base de datos.")
    elif(opc == "3"):
        verificacion = ""
        if( (len(ideas)) == 0):
            print("\nAun no se han registrado ideas en la base de datos.")
        elif( (len(ideas)) != 0):
            codigo = input("Ingrese el codigo de la idea a la que desea hacer su donacion:  ")
            for y in range (len(ideas)):
                if (ideas[y].codigo == codigo):
                    if(ideas[y].estado != "Abierto"):
                        verificacion = "NO"
                        print("\nLo sentimos pero la idea ya paso su fecha de terminacion y por este motivo se encuentra cerrada.")
                    elif(ideas[y].estado == "Abierto"):
                        verificacion = "SI"
                        valoradon = float(input("Ingrese el valor a donar:  "))
                        if(valoradon >= ideas[y].minaporte):
                            donante = Donador(input("Ingrese su nombre:  "),input("Ingrese su coreo electronico:  "),input("Ingrese su direccion de residencia actual:  "),
                                              valoradon,input("Ingrese su numero de cuenta en caso de devolucion:  "),codigo)
                            adicionar(donante,donantes)
                            ideas[y].valoract = ideas[y].valoract + valoradon
                        elif(valoradon < ideas[y].minaporte):
                            print("\nSu aporte es demasiado bajo para la idea que desea apoyar")
            if(verificacion == ""):
                print("\nEl codigo que ingreso es incorrecto o no se encuentra en la base de datos.")
                
    elif(opc == "4"):
        verificacion = ""
        if( len(donantes) == 0):
            print("\nAun no se han realizado donanciones a ninguna idea.")
        elif( (len(donantes)) != 0):
            codigo = input("Ingrese el codigo de la idea:  ")
            for vc in range (len(donantes)):
                if(donantes[vc].codigoadon == codigo):
                    verificacion = "SI"
                    print("\n#Nombre de donante:  " + donantes[vc].nombre + "   Valor donado: " + str(donantes[vc].valordon))
            if(verificacion == ""):
                print("\nIngreso un codigo incorrecto.")
    elif( opc == "5"):
        if( (len(ideas)) != 0):
            año = int(input("Igrese la fecha de hoy: Año(AAAA): "))
            mes = int(input("                        Mes(MM): "))
            dia = int(input("                        Día(DD): "))
            if((año >= 2100) or (año < 2018)):
                print("\nIngreso un año demasiado alto o sin sentido.")
            if((mes <= 0) or(mes > 12)):
                print("\nIngreso un mes que no tiene sentido.")
            if((dia < 1) or (dia > 31)):
                print("\nIngreso un dia que no tiene sentido.")
            if((año <= 2100) and (año >= 2018)):
                if((mes > 0) and (mes <= 12)):
                    if((dia >= 1) and (dia <= 31)):
                        actualizarestado(año,mes,dia,ideas)
                        for vc in range (len(ideas)):
                            if(ideas[vc].estado == "Cerrado y no cumplió meta"):
                                print( "#Nombre de idea que no cumplio meta:  " + ideas[vc].titulo + "\nDevoluciones: ")
                                for i in range (len(donantes)):
                                    if( ideas[vc].codigo == donantes[i].codigoadon):
                                        ideas[vc].valoract = ideas[vc].valoract - ideas[vc].valoract
                                        print("              Nombre de persona: " + donantes[i].nombre + "   N° de Cuenta y Valor devuelto:  " +
                                              donantes[i].cuenta + "    " + str(donantes[i].valordon))
                            if(ideas[vc].estado == "Cerrado y cumplió meta"):
                                print("#Nombre de idea que ya cumplio meta:  " + ideas[vc].titulo + "\n Fecha en que se realizara la etrega:  " + ideas[vc].fechaentrega.crearfecha)
        elif( (len(ideas)) == 0):
            print("\nAun no se han registrado ideas en la base de datos.")
    elif(opc == "6"):
        if( (len(ideas)) != 0):
            fd = shelve.open(input("Igrese el nombre del archivo donde guardará los datos:  "))
            fd["Las Ideas"] = ideas
            fd["Los Donantes"] = donantes
            fd["Las Personas"] = personas
            fd.close() 
        elif( (len(ideas)) == 0):
            print("\nNo hay datos por guardar aun.")
    elif(opc == "7"):
        fd = shelve.open(input("Cual es el nombre del archivo del que desea cargar los datos:  "))
        try:
            personas = fd["Las Personas"]
            ideas = fd["Las Ideas"]
            donantes = fd["Los Donantes"]
        except:
            fd["Las Personas"] = personas
            fd["Los Donantes"] = donantes
            fd["Las Ideas"] = ideas
        fd.close()
    elif(opc != "8"):
        print("\nIngresó una opcion que no se encuentra en el menu. Intente de nuevo.") 
print("\n GRACIAS POR UTILIZAR NUESTRA APLICACION.    QUE TENGA BUEN DÍA :) \n")
