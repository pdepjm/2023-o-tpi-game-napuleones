import wollok.game.*
import gatos.*
import techos.*
import menu.*

object nivel {
	var puedeReiniciarse = false
	method empezarNivel() {
		puedeReiniciarse = false
		napoleon.configurarControles()
		techos.iniciar()
		score.iniciar()
	}

	method gameOver() {
		puedeReiniciarse = true
		score.position(game.center())
		score.parar()
		game.addVisual(fondo)
		fondo.fondoActual("gameOver.png")
		fondo.position(game.center())
	}
	method reiniciarNivel(){
		keyboard.space().onPressDo({ if (puedeReiniciarse) menu.iniciarMenu()})
	}
}

object techos {

	var contadorTechos = 0
	var techoAnterior
	const listaTechos = #{}

	method tamanioRandom() {
		return 4.randomUpTo(7).truncate(0)
	}

	method removerBasura() {
		listaTechos.forEach{ techo => techo.remover()}
	}

	method removerTechoEspecifico(techo) {
		listaTechos.remove(techo)
	}

	method generarTechos() {
		contadorTechos++
		const nuevoTecho = new Techo(position = game.at(13, 0), identificador = contadorTechos, tamanio = self.tamanioRandom())
		techoAnterior = nuevoTecho
		listaTechos.add(nuevoTecho)
		game.addVisual(nuevoTecho)
		nuevoTecho.iniciar()
	}

	method iniciar() {
		const primerTecho = new Techo(position = game.origin(), identificador = 1, tamanio = 13) // que ocupe toda la pantalla
		contadorTechos++
		techoAnterior = primerTecho
		game.addVisual(primerTecho)
		primerTecho.iniciar()
		game.onTick(1, "generarTechos", {=>
			if (techoAnterior.estaCompletamenteEnPantalla()) {
				self.generarTechos()
			}
		})
	}

	method parar() {
		game.removeTickEvent("generarTechos")
		listaTechos.forEach{ techo => techo.parar()}
		listaTechos.clear()
		contadorTechos = 0
	}

}

object score {

	var property score = 0
	var property position = game.at(0, 4)

	method text() = "Score: " + score.toString()

	method textColor() = "FFFFFF"

	method parar() {
		game.removeTickEvent("sumar")
	}


	method iniciar() {
		score = 0
		position = game.at(0, 4)
		game.onTick(150, "sumar", {=> score++})
	}

}

object fondo {

	var property fondoActual = "menu.jpeg"
	var property position = game.origin()

	method image() = fondoActual

}

