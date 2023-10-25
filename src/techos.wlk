import wollok.game.*
import gatos.*
import menu.*
import nivel.*

class Techo{
	const property tamanio
	const identificador
	var property position
	const colision = new ColisionCaida(position=self.position().right(tamanio).up(1))//pone el objecto arriba a la derecha
	method image() = "techo"+tamanio.toString()+".png"
	method fueraDePantallaAIzquierda() = position == game.at(-tamanio-2,position.y())
	method estaCompletamenteEnPantalla() = position.x()+tamanio < 13
	method remover(){
			game.removeTickEvent("moverTecho"+identificador.toString())
			techos.removerTechoEspecifico(self)
			game.removeVisual(colision)
			game.removeVisual(self)
	}
	method parar(){
			game.removeTickEvent("moverTecho"+identificador.toString())
	}
	method iniciar(){
	    game.addVisual(colision)
		game.onTick(100,"moverTecho"+identificador.toString(),{=>
			self.mover()
			if(self.fueraDePantallaAIzquierda()){
				self.remover()
		}
		})
	}
	method mover(){
		position=self.position().left(1)
		colision.position(colision.position().left(1))
	}
}
class ColisionCaida{
	var property position
	method chocaCon(gato){
		gato.caer()
	}
}
