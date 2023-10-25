import wollok.game.*
import gatos.*
import menu.*
import nivel.*
import powerups.*

class GatoEnemigo {

	const property tamanio
	const identificador
	var property position
	const colision = new ColisionCaida(position = self.position().right(tamanio).up(1)) // pone el objecto arriba a la derecha
	const objetoAnidado = self.generarEnemigo()
	
	//method image() = imagen del enemigo

	method fueraDePantallaADerecha() = position == game.at(tamanio + 1, position.y())

	method estaCompletamenteEnPantalla() = position.x() - tamanio < 13
	
	method generarEnemigo(){
		//const listaPosibilidades = [Nada, Nada, Whiskas]
		const numeroRandom = 0.randomUpTo(5).truncate(0)
		return new GatoEnemigo(tamanioTecho = numeroRandom, posicionTecho = 13)		
	}
	
	method remover() {
		game.removeTickEvent("Enemigo" + identificador.toString())
		techos.removerTechoEspecifico(self)
		game.removeVisual(colision)
		game.removeVisual(objetoAnidado)
		game.removeVisual(self)
	}
	method chocaCon(){}
	method parar() {
		game.removeTickEvent("Enemigo" + identificador.toString())
	}

	method iniciar() {
		game.addVisual(colision)
		self.generarEnemigo()
		game.addVisual(objetoAnidado)
		game.onTick(300, "moverTecho" + identificador.toString(), {=>
			self.mover()
			if (self.fueraDePantallaADerecha()) {
				self.remover()
			}
		})
	}

	method mover() {
		position = self.position().left(1)
		colision.position(colision.position().left(1))
		objetoAnidado.position(objetoAnidado.position().left(1))
	}

}

class ColisionCaida {

	var property position
	//method image() = "pepita.png"
	method enemigoChocaCon(gato) {
		gato.caer()
	}
}

