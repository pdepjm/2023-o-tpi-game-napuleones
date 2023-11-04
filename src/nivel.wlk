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
		fondo.fondoActual("gameover.png")
		fondo.position(game.at(5, 3))
	}

	method reiniciarNivel() {
		keyboard.space().onPressDo({ game.sound("boton.wav").play() if (puedeReiniciarse) menu.iniciarJuego()
		})
	}

}

object techos {

	var contadorTechos = 0
	var techoAnterior
	const listaTechos = #{}

	method tamanioRandom() {
		return 5.randomUpTo(8).truncate(0)
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
		const primerTecho = new Techo(position = game.origin(), identificador = 1, tamanio = 13)
		contadorTechos++
		techoAnterior = primerTecho
		listaTechos.add(primerTecho)
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
	var property position = game.at(6, 4)

	method text() = "Score: " + score.toString()

	method textColor() = "FFFFFF"

	method parar() {
		game.removeTickEvent("sumar")
	}
	method explotar(){}
	method iniciar() {
		score = 0
		position = game.at(6, 4)
		game.onTick(150, "sumar", {=> score++})
	}

}

object fondo {

	var property fondoActual = "menu.jpeg"
	var property position = game.origin()

	method chocaCon(a) {
	}

	method image() = fondoActual

}

