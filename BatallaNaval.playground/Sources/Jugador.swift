import Foundation

public class Jugador {
    public var nombre: String
    var edad: Int
    var tipo: String
    var skill: String
    public var ocupadas = [[Int]]()
    
    let tipos: [String] = ["humano", "ia"]
    let skills: [String] = ["alto", "medio", "bajo"]
    
    //var tipos: [String: Int] = ["portaviones": 5, "carguero": 4, "pesquero": 3, "lancha": 2]
    //var puntos: [String: Int] = ["portaviones": 5, "carguero": 4, "pesquero": 3, "lancha": 2]
    
    public var flota = Array(repeating: Barco(), count: 8)
    
    var barco1 = Barco(nombre: "P1", tipo: "portaviones")
    var barco2 = Barco(nombre: "P2", tipo: "portaviones")
    var barco3 = Barco(nombre: "C1", tipo: "carguero")
    var barco4 = Barco(nombre: "C2", tipo: "carguero")
    var barco5 = Barco(nombre: "E1", tipo: "pesquero")
    var barco6 = Barco(nombre: "E2", tipo: "pesquero")
    var barco7 = Barco(nombre: "L1", tipo: "lancha")
    var barco8 = Barco(nombre: "L2", tipo: "lancha")
    
    public var jugadorTablero = Tablero(largo: 10, ancho: 10)
    public var jugadorTableroDisparos = Tablero(largo: 10, ancho: 10)
    
    public init(nombre: String, edad: Int, tipo: String, skill: String) {
        self.nombre = nombre
        self.edad = edad
        self.tipo = tipo
        self.skill = skill
        flota[0] = barco1
        flota[1] = barco2
        flota[2] = barco3
        flota[3] = barco4
        flota[4] = barco5
        flota[5] = barco6
        flota[6] = barco7
        flota[7] = barco8
        jugadorTablero.llenaTablero()
        jugadorTableroDisparos.llenaTablero()
        //print("Tablero de \(self.nombre)")
        //jugadorTablero.pintaTablero()
    }
    public func getNombre() -> String {
        return "Tu nombre es: \(nombre)"
    }
    public func getEdad() -> String {
        return  "Edad:\(edad)"
    }
    public func getTipo() -> String {
        return "Tipo:\(tipo)"
    }
    public func getSkill() -> String {
        return "Skill:\(skill)"
    }
    public func getFlota() -> [Barco]{
        return self.flota
    }
    public func colocarBarcos(){
        var aleatorioPosX: Int
        var aleatorioPosY: Int
        var aleatorioOrientacion: String
        
        var colocado: Bool = false
        
        let orientacion = ["VER", "HOR"]
        
        for i in 0..<flota.count{
            repeat {
                aleatorioPosX = Int(arc4random_uniform(UInt32(jugadorTablero.ancho)))
                aleatorioPosY = Int(arc4random_uniform(UInt32(jugadorTablero.largo)))
                aleatorioOrientacion = orientacion[Int(arc4random_uniform(UInt32(orientacion.count)))]
                if (jugadorTablero.checkColocar(x: aleatorioPosX, y: aleatorioPosY, orientacion: aleatorioOrientacion, barco: flota[i])) == true {
                    jugadorTablero.colocar(x: aleatorioPosX, y: aleatorioPosY, orientacion: aleatorioOrientacion, barco: flota[i])
                    flota[i].asignarPosiciones(x: aleatorioPosX, y: aleatorioPosY, orientacion: aleatorioOrientacion)
                    llenarOcupadas(x: aleatorioPosX, y: aleatorioPosY, orientacion: aleatorioOrientacion, barco: flota[i])
                    colocado = true
                    //print("\(flota[i].getNombre()) colocado!")
                }
                else {
                    //print("\(flota[i].getNombre()) NO colocado!")
                    colocado = false
                }
            } while (colocado == false)
        }
    }
    public func llenarOcupadas(x: Int, y: Int, orientacion: String, barco: Barco){
        var tt: [Int] = []
        if orientacion == "HOR" {
            for i in x..<(x+barco.agujeros.count){
                tt.append(i)
                tt.append(y)
                ocupadas.append(tt)
                tt = []
            }
        }
        else {
            for i in y..<(y+barco.agujeros.count){
                tt.append(x)
                tt.append(i)
                ocupadas.append(tt)
                tt = []
            }
        }
        //print("Colocado \(barco.getNombre()) en posicion \(y) , \(x) con orientacion \(orientacion)")
    }
    public func Disparo() -> [Int] {
        var aleatorioPosX: Int = 0
        var aleatorioPosY: Int = 0
        var paso: Bool = false
        var temp = [Int]()
        while paso == false {
            aleatorioPosX = Int(arc4random_uniform(UInt32(jugadorTablero.ancho)))
            aleatorioPosY = Int(arc4random_uniform(UInt32(jugadorTablero.largo)))
            if (jugadorTableroDisparos.disparoAnterior(x: aleatorioPosX, y: aleatorioPosY)) == true {
                paso = false
            }
            else {
                jugadorTableroDisparos.disparo(x: aleatorioPosX, y: aleatorioPosY)
                print("Ha disparado: \(self.nombre) a \(aleatorioPosX),\(aleatorioPosY)")
                paso = true
            }
        }
        temp.append(aleatorioPosX)
        temp.append(aleatorioPosY)
        return temp
    }
    public func Hit(coordenadas: [Int]) -> Bool{
        var coord = [Int]()
        var resp: Bool = false
        var respuesta: String = "Agua!"
        coord = coordenadas
        /*for i in 0..<flota.count {
            if flota[i].posicion.index
            }
        }*/
        /*if ocupadas.contains(where: coord) then {
            print("si")
        }*/
        for i in 0..<ocupadas.count {
            if ocupadas[i] == coord {
                for i in 0..<flota.count {
                    if (flota[i].estado == "OK") {
                        for j in 0..<flota[i].posicion.count {
                            if (flota[i].posicion[j] == coord){
                                flota[i].vidaMenos()
                                flota[i].pintaAgujeros()
                            }
                        }
                    }
                }
                respuesta = "HIT!"
                resp = true
            }
        }
        print(respuesta)
        return resp
    }
    public func checkGanador() -> Bool{
        var respuesta: Bool = true
        for i in 0..<flota.count {
            if (flota[i].estado == "OK") {
                respuesta = false
            }
        }
        //print(flota)
        return respuesta
    }
    public func pintaFlota(){
        for i in 0..<flota.count{
            flota[i].pintaAgujeros()
            print(flota[i].posicion)
        }
        print(ocupadas)
    }
}
