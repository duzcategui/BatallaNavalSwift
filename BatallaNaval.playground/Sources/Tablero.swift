import Foundation

public class Tablero{
    var largo: Int
    var ancho: Int
    public var Casillas = [[String]]()

    public init(largo: Int, ancho: Int){
        self.largo = largo
        self.ancho = ancho
    }
    public func llenaTablero(){
        var row = [String]()
        for _ in 0..<largo {
            for _ in 0..<ancho {
                row.append("00")
            }
            Casillas.append(row)
        }
    }
    public func pintaTablero(){
        var temporal: String = "TT"
		for i in 0..<largo {
			temporal.append("|0\(i)")
		}
		print(temporal)
		temporal = ""
        for i in 0..<largo {
            for j in 0..<ancho {
                temporal.append("|\(Casillas[i][j])")
            }
            print("0\(i)\(temporal)")
            temporal = ""
        }
    }
    public func getLargo() -> String{
        return "Largo:\(largo)"
    }
    public func getAncho() -> String{
        return "Ancho:\(ancho)"
    }
    public func checkColocar(x: Int, y: Int, orientacion: String, barco: Barco) ->Bool{
        var check: Bool = false
		//print("Check Colocar \(barco.getNombre()) en posicion \(y) , \(x) con orientacion \(orientacion)")
        if orientacion == "HOR" {
			if (x+barco.agujeros.count) < largo {
				for i in x..<(x+barco.agujeros.count){
					if Casillas[i][y] == "00" {
						check = true
					}
				}
			}
        }
        else {
			if (y+barco.agujeros.count) < largo {
				for i in y..<(y+barco.agujeros.count){
					if Casillas[x][i] == "00" {
						check = true
					}
				}
			}
        }
        return check
    }
    public func colocar(x: Int, y: Int, orientacion: String, barco: Barco){
        if orientacion == "HOR" {
            for i in x..<(x+barco.agujeros.count){
                Casillas[i][y] = barco.getNombre()
                }
        }
        else {
            for i in y..<(y+barco.agujeros.count){
                Casillas[x][i] = barco.getNombre()
            }
        }
		//print("Colocado \(barco.getNombre()) en posicion \(y) , \(x) con orientacion \(orientacion)")
    }
	public func disparoAnterior(x: Int, y: Int) -> Bool{
		if Casillas[x][y] == "00" {
			return false
		}
		return true
	}
	public func disparo(x: Int, y: Int){
		Casillas[x][y] = "XX"
	}
}
