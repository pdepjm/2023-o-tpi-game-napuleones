import wollok.game.*

object napoleon {
	var comioWhiskas = false
	var property position = game.at(0,0)

	method image() = "napoleon.png"
	method saltar(){}
	method disparar(){}
	method caer(){}
	method comerWhiskas(){}
	
	
	method configurarControles(){
		keyboard.space().onPressDo({ self.saltar()})
		keyboard.q().onPressDo({ self.disparar()})			
	}
}
object nivel{
	method inicializarNivel(){
		techos.mostrarTechoInicial()
		//hay que hacer que aparezca el score
		//debe hacer una cuenta regresiva desde 3 y empieza a mover todo
	} 
	method empezarNivel(){
					napoleon.configurarControles()
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
	}
}
