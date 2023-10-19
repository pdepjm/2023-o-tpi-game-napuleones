import wollok.game.*

object napoleon {
	//var comioWhiskas = false creo que no es necesario
	var property position = game.at(0,1)
	var proyectil = bolaDePelo
	
	method image() = "napoleon.png"
	
	method saltar(){
		position = position.up(1)
		game.schedule(50,{position = position.up(1)})
		game.schedule(150,{position = position.down(1)})
		game.schedule(200,{position = position.down(1)})
		
	}
	
	method disparar(){
		game.addVisual(proyectil) 
		game.onTick(50,"dispararProyectil",{=>proyectil.mover()})
		if(proyectil.fueraDePantalla()){
			game.removeTickEvent("dispararProyectil")
			game.removeVisual(proyectil)
		}
		//onTick mover el proyectil a la derecha hasta que colisione con el enemigo
	}
	
	method caer(){
		game.schedule(100,{position = position.down(1)})
		game.schedule(200,{position = position.up(1)})
		game.schedule(300,{position = position.up(1)})
		game.schedule(800,{position = position.down(1)})
		game.schedule(900,{position = position.down(1)})
		game.schedule(1000,{position = position.down(1)})
	}
	
	method comerWhiskas(){
		proyectil = bolaDeFuego
	}
	
	
	method configurarControles(){
		keyboard.space().onPressDo({ self.saltar()})
		keyboard.q().onPressDo({ self.disparar()})	
		keyboard.c().onPressDo({self.caer()})		
	}
}

object whiskas{
	
}

class Proyectil{
	
	var property position = game.at(1,1)
		
	const image = "pepita.png"
	
	method image() = image
	
	method daniar(enemigo){
		enemigo.recibirDanio()
	}
	
	method mover(){
		self.position(game.at(position.x()+1,position.y()))
	}
	
	//method fueraDePantalla() = self.position() == borde pantalla
	
}

const bolaDePelo = new Proyectil()

const bolaDeFuego = new Proyectil(image = "bolaDeFuego.png")

object espacioEntreTechos{
	//invisible
	//cuando napoleon llegue aca, cae y game over
}

object nivel{
	method inicializarNivel(){
		techos.mostrarTechoInicial()
		//hay que hacer que aparezca el score
		//debe hacer una cuenta regresiva desde 3 y empieza a mover todo
	} 
	method empezarNivel(){
					napoleon.configurarControles()
					console.println("hola")
					techos.generar()
	}
	method score(){}
}
object techos{
	method mostrarTechoInicial(){} //hace que aparezcan el primer techo que ocupa todas las celdas hasta que se generen otros
	method generar(){}//ya cuando termina la cuenta empieza a generar y mover los techos moviendo a su vez el primero hasta desaparecer(lo toma como si fuera el primer techo)
}
object fondo{
	var property fondoActual = "menu.jpeg"
	
	method position() = game.origin()

	method image() = fondoActual
}
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
		nivel.inicializarNivel()
		nivel.empezarNivel()
	}
}
