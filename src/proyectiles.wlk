import wollok.game.*
import gatos.*
import nivel.*

class Proyectil {

	const identificador
	var property position = napoleon.position().right(1)
	var property tipoProjectil
	var property image = tipoProjectil.image()

	method remover() {
		game.removeTickEvent("dispararProyectil" + identificador.toString())
		napoleon.puedeDisparar(true)
		game.removeVisual(self)
	}

	method iniciar() {
		tipoProjectil.reproducirSonido()
		game.onCollideDo(self, { obstaculo => obstaculo.explotar(tipoProjectil)})
		game.onTick(25, "dispararProyectil" + identificador.toString(), {=>
			self.mover()
			if (self.fueraDePantalla()) {
				self.remover()
			}
		})
	}

	method mover() {
		self.position(game.at(position.x() + 1, position.y()))
	}

	method fueraDePantalla() = position == game.at(14, position.y())

}

object bolaDePelo {

	method image() = "boladepelo.png"
	method reproducirSonido(){
		game.sound("dispararbolapelo.wav").play()
	}
	method sumarPuntos() {
		score.score(score.score() + 5)
	}

}

object bolaDeFuego {

	method image() = "boladefuego.png"
	method reproducirSonido(){
		game.sound("dispararbolafuego.wav").play()
	}
	method sumarPuntos() {
		score.score(score.score() + 20)
	}

}

