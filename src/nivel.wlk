import wollok.game.*
import gato.*
import techos.*

object espacioEntreTechos{
	//invisible
	//cuando napoleon llegue aca, cae y game over
}

object nivel{
	method empezarNivel(){
					napoleon.configurarControles()
					techos.iniciar()
	}
	method score(){}
	method pararPorPerdida(){}
}

object techos{
	var contadorTechos = 0
	var techoAnterior 
	method tamanioRandom(){
		return 8 //por ahora
	}
	method generarTechos(){
		contadorTechos++
		const nuevoTecho = new Techo (position = techoAnterior.position().right(1+techoAnterior.tamanio()), identificador = contadorTechos, tamanio = self.tamanioRandom())
		techoAnterior = nuevoTecho
		game.addVisual(nuevoTecho)
		nuevoTecho.iniciar()
	}
	method iniciar(){
		const primerTecho = new Techo(position = game.origin(), identificador = 1, tamanio = 13)//que ocupe toda la pantalla
		contadorTechos++
		techoAnterior = primerTecho
		game.addVisual(primerTecho)
		primerTecho.iniciar()
		game.onTick(500,"generarTechos",{=>self.generarTechos()})
	}
	
	}

object fondo{
	var property fondoActual = "menu.jpeg"
	
	method position() = game.origin()

	method image() = fondoActual
}
