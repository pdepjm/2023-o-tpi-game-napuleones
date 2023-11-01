import wollok.game.*
import gatos.*
import menu.*
import nivel.*
import powerups.*

class Techo {

	const property tamanio
	const identificador
	var property position
	const colision = new ColisionCaida(position = self.position().right(tamanio).up(1)) // pone el objecto arriba a la derecha
	const objetoAnidado = self.generarObjeto()
	method image() = "techo" + tamanio.toString() + ".png"

	method fueraDePantallaAIzquierda() = position == game.at(-tamanio - 1, position.y())

	method estaCompletamenteEnPantalla() = position.x() + tamanio < 13
	
	method generarObjeto(){
		//const listaPosibilidades = [Nada, Nada, Whiskas]
		const numeroRandom = 0.randomUpTo(10).truncate(0)
		if (numeroRandom==5){
			return  new PowerUp(tamanioTecho = tamanio, posicionTecho = position)
		}else if(numeroRandom==4){
			return new GatoEnemigo(tamanioTecho = tamanio, posicionTecho = position)
		}else return new Nada(position =game.center())
		//return  new seleccionado
		
	}
	
	method remover() {
		game.removeTickEvent("moverTecho" + identificador.toString())
		techos.removerTechoEspecifico(self)
		game.removeVisual(colision)
		game.removeVisual(objetoAnidado)
		game.removeVisual(self)
	}
	method chocaCon(a){}
	method parar() {
		game.removeTickEvent("moverTecho" + identificador.toString())
	}

	method iniciar() {
		game.addVisual(colision)
		self.generarObjeto()
		game.addVisual(objetoAnidado)
		game.onTick(120, "moverTecho" + identificador.toString(), {=>
			if (self.fueraDePantallaAIzquierda()) {
				self.remover()
			}
			self.mover()
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
	method chocaCon(gato) {
		if(!gato.gatoGrande()) gato.caer()
	}
	method explotar(tipoProjectil){
	}
}

