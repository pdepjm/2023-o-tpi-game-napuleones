import wollok.game.*
import nivel.*
import gato.*

object menu{
	var estaEnInstrucciones = false
	method iniciarMenu(){
		fondo.fondoActual("instrucciones.jpeg")
		keyboard.space().onPressDo({self.continuar()})
	}
	
	method mostrarInstrucciones(){
		fondo.fondoActual("menu.jpeg")
	}
	method continuar(){
		if (!estaEnInstrucciones){
			self.mostrarInstrucciones()
			estaEnInstrucciones = true
		}else {
			self.iniciarJuego()
		}
	}
	method iniciarJuego(){
		game.clear()
		game.addVisual(napoleon)

	//		game.addVisual(fondo)
		nivel.empezarNivel()
	}
}
