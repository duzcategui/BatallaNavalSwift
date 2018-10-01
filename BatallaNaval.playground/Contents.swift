import Foundation
var ganador: Bool = false
var jugadas = [[Int]]()

let Jugador1 = Jugador(nombre: "David", edad: 9, tipo: "humano", skill: "bajo")
let Jugador2 = Jugador(nombre: "Esther", edad: 7, tipo: "humano", skill: "bajo")
Jugador1.colocarBarcos()
Jugador2.colocarBarcos()
print("Jugador: \(Jugador1.getNombre())")
Jugador1.jugadorTablero.pintaTablero()
Jugador1.pintaFlota()
print("Jugador: \(Jugador2.getNombre())")
Jugador2.jugadorTablero.pintaTablero()
Jugador2.pintaFlota()
print("Comienza el juego")
while (ganador == false){
    print("turno para el jugador 1:\(Jugador1.nombre)")
    jugadas.append(Jugador1.Disparo())
    Jugador1.jugadorTableroDisparos.pintaTablero()
    if (Jugador2.Hit(coordenadas: jugadas.last!)) == true {
        ganador = Jugador1.checkGanador()
        Jugador1.pintaFlota()
    }
    print("turno para el jugador 2:\(Jugador2.nombre)")
    jugadas.append(Jugador2.Disparo())
    Jugador2.jugadorTableroDisparos.pintaTablero()
    if (Jugador1.Hit(coordenadas: jugadas.last!)) == true {
        ganador = Jugador2.checkGanador()
        Jugador2.pintaFlota()
    }
}