import wollok.game.*
import gato.*

class Proyectil{
	const identificador
	var property position = napoleon.position().right(1) 
	//si agregamos mas gatos o q los gatos enemigos disparen entonces tenemos q agregar
	//un atributo que identifique quien dispara el proyectil para hacerlo generico y no solo para napoleon
		
	const image = "pepita.png"
	
	method image() = image
	
	method daniar(enemigo){
		enemigo.recibirDanio(20)
	}
	method iniciar(){
		game.onTick(25,"dispararProyectil"+identificador.toString(),{=>self.mover()
			if(self.fueraDePantalla()){
			game.removeTickEvent("dispararProyectil"+identificador.toString())
			//console.println("se removio: dispararProyectil"+identificador.toString())
			game.removeVisual(self)
			
		}
		})
	}
	method mover(){
		self.position(game.at(position.x()+1,position.y()))
	}
	
	method fueraDePantalla() = position ==game.at(13,position.y()) //borde pantalla
	
}

//const bolaDePelo = new Proyectil()
//
//const bolaDeFuego = new Proyectil(image = "bolaDeFuego.png")
