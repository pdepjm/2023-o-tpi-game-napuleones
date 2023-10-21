import wollok.game.*


class Techo{
	const property tamanio
	const identificador
	var property position
	const colision = new ColisionCaida(position=self.position().right(tamanio).up(1))//pone el objecto arriba a la derecha
	method image() = "techo"+tamanio.toString()+".png"
	method fueraDePantalla() = position == game.at(-tamanio,position.y())
	method iniciar(){
		game.addVisual(colision)
		game.onTick(50,"moverTecho"+identificador.toString(),{=>self.mover()
			if(self.fueraDePantalla()){
			game.removeTickEvent("moverTecho"+identificador.toString())
			//console.println("se removio: moverTecho"+identificador.toString())
			game.removeVisual(colision)
			game.removeVisual(self)
			
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
	method imagen() = "pepita.png"//para ver
	
}
