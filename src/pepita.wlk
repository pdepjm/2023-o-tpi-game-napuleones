import wollok.game.*

object napoleon {
	var comioWhiskas = false
	var property position = game.at(0,1)
	//var proyectil bolas de pelo o de fuego
	

	method image() = "napoleon.png"
	method saltar(){
		position = position.up(1)
		game.schedule(50,{position = position.up(1)})
		game.schedule(150,{position = position.down(1)})
		game.schedule(200,{position = position.down(1)})
		
	}
	method disparar(){
		//supongo que addVisual del proyectil y hacer que se mueva
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
		
	}
	
	
	method configurarControles(){
		keyboard.space().onPressDo({ self.saltar()})
		keyboard.q().onPressDo({ self.disparar()})	
		keyboard.c().onPressDo({self.caer()})		
	}
}

object whiskas{
	
}

object bolaDeFuego{
	//cuando dispare tiene que aparecer en una position (posicion napoleon)+(1,0) y moverse a la derecha (onTick supongo, hasta que colisione con un enemigo y lo mate, suma puntos)
}
object bolaDePelo{
	//idem bola de fuego, pero deberia hacer menos danio y sumar menos puntos
}

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
