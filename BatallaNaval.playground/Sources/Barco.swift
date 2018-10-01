import Foundation

public class Barco {
    var nombre: String
    var tipo: String
    var punto: Int
    var agujeros = [String]()
    var posicion = [[Int]]()
    var estado: String = "OK"
    
    let tipos: [String: String] = ["portaviones": "P", "carguero": "C", "pesquero": "E", "lancha": "L"]
    let puntos: [String: Int] = ["portaviones": 5, "carguero": 4, "pesquero": 3, "lancha": 2]
    
    public init(){
        self.nombre = "nada"
        self.tipo = "nada"
        self.punto = 0
        self.agujeros = []
    }
    public init(nombre:String, tipo: String) {
        self.nombre = nombre
        self.tipo = tipo
        self.punto = puntos[tipo]!
        for _ in 0..<puntos[tipo]!{
            self.agujeros.append("0")
        }
    }
    public func getNombre() -> String{
        return nombre
    }
    public func getTipo() -> String{
        return tipo
    }
    public func asignarPosiciones(x: Int, y: Int, orientacion: String){
        var par = [Int]()
        if orientacion == "HOR" {
            for i in x..<(x+self.agujeros.count){
                par = []
                par.append(i)
                par.append(y)
                posicion.append(par)
            }
        }
        else {
            for i in y..<(y+self.agujeros.count){
                par = []
                par.append(x)
                par.append(i)
                posicion.append(par)
            }
        }
    }
    public func vidaMenos(){
        if (agujeros.contains("0")){
            agujeros.insert("X", at: agujeros.index(of: "0")!)
        }
        else {
            estado = "KO"
        }
    }
    public func pintaAgujeros(){
        var temp: String = "|"
        for i in 0..<self.agujeros.count{
            temp.append(agujeros[i])
            temp.append("|")
        }
        print(temp)
    }
}
