import wollok.game.*
import nivel.*
import gatos.*
import inventario.*

object menu {

	var estaEnInstrucciones = false

	method iniciarMenu() {
		fondo.position(game.origin())
		fondo.fondoActual("menu.png")
		estaEnInstrucciones = false
		keyboard.space().onPressDo({ self.continuar()})
	}

	method mostrarInstrucciones() {
		fondo.fondoActual("instrucciones.png")
	}

	method continuar() {
		game.sound("boton.wav").play()
		if (!estaEnInstrucciones) {
			self.mostrarInstrucciones()
			estaEnInstrucciones = true
		} else {
			self.iniciarJuego()
		}
	}

	method iniciarJuego() {
		game.clear()
		game.addVisual(napoleon)
		game.addVisual(score)
		game.addVisual(inventarioUI)
		inventarioUI.iniciar()
		nivel.empezarNivel()
	}

}

