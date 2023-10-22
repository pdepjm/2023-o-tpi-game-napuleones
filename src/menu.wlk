import wollok.game.*
import nivel.*
import gatos.*

object menu{
	var estaEnInstrucciones = false
	method iniciarMenu(){
		fondo.fondoActual("menu.png")
		keyboard.space().onPressDo({self.continuar()})
	}
	
	method mostrarInstrucciones(){
		fondo.fondoActual("instrucciones.png")
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
