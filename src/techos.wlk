import wollok.game.*
import gatos.*
import menu.*
import nivel.*
import spawns.*

class Techo {

	const property tamanio
	const identificador
	var property position
	const colision = new ColisionCaida(position = self.position().right(tamanio).up(1)) 
	const objetoAnidado = if (identificador != 1) self.generarObjeto() else new Nada(position =game.center())
	method image() = "techo" + tamanio.toString() + ".png"

	method fueraDePantallaAIzquierda() = position == game.at(-tamanio - 1, position.y())

	method estaCompletamenteEnPantalla() = position.x() + tamanio < 13
	
	method generarObjeto(){
		const numeroRandom = 0.randomUpTo(7).truncate(0)
		if (numeroRandom==5){
			return  new PowerUp(tamanioTecho = tamanio, posicionTecho = position)
		}else if(numeroRandom==4){
			return new GatoEnemigo(tamanioTecho = tamanio, posicionTecho = position)
		}else return new Nada(position =game.center())
		
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
		game.addVisual(objetoAnidado)
		objetoAnidado.reproducirSonidoAlAparecer()
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
	method chocaCon(gato) {
		if(!gato.gatoGrande()) gato.caer()
	}
	method explotar(tipoProjectil){
	}
}

