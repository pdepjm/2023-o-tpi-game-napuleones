import wollok.game.*
import nivel.*
import proyectiles.*

object powerUps {

	const property powerUpsActuales = [ whiskas, croqueta, lasagna ]

}

class PowerUp {

	var tamanioTecho
	var posicionTecho
	const tipo = self.definirTipo()
	var property image = tipo.image()
	var property position = game.at(posicionTecho.x().randomUpTo(posicionTecho.x() + tamanioTecho).truncate(0), 1.randomUpTo(3).truncate(0))
	method reproducirSonidoAlAparecer(){
		game.sound("powerupaparicion.wav").play()
	}
	method chocaCon(gato) {
		self.image("estrellas.png")
		gato.agregarAInventario(tipo)
	}

	method explotar(tipoProjectil) {
	}

	method definirTipo() {
		return powerUps.powerUpsActuales().get(0.randomUpTo(powerUps.powerUpsActuales().size()).truncate(0))
	}

}

class Nada {

	var property position

	method chocaCon(gato) {
	}

	method definirTipo() {
	}

	method explotar(tipoProjectil) {
	}
	method reproducirSonidoAlAparecer(){}
}

object whiskas {

	method image() = "whiskas.png"

	method usar(gato) {
		gato.proyectilesActuales(bolaDeFuego)
		game.schedule(5000, { gato.proyectilesActuales(bolaDePelo)
			gato.puedeConsumirPowerUp(true)
		})
	}

}
object lasagna{
	method image() = "lasagna.png"

	method usar(gato) {
		game.schedule(5000, {
			gato.puedeConsumirPowerUp(true)
		})
	}
}
object croqueta {

	const framesCaminarNormal = [ "caminar1.png", "caminar2.png", "caminar3.png" ]
	const framesCaminarGrande = [ "caminar1Grande.png", "caminar2Grande.png", "caminar3Grande.png" ]
	const framesSaltoNormal = [ "salto1.png", "salto2.png", "salto3.png" ]
	const framesSaltoGrande = [ "salto1Grande.png", "salto2Grande.png", "salto3Grande.png" ]

	method image() = "croqueta.png"

	method usar(gato) {
		gato.framesDeCaminar(framesCaminarGrande)
		gato.framesDeSaltar(framesSaltoGrande)
		gato.gatoGrande(true)
		game.schedule(5000, { gato.framesDeCaminar(framesCaminarNormal)
			gato.gatoGrande(false)
			gato.framesDeSaltar(framesSaltoNormal)
			gato.puedeConsumirPowerUp(true)
		})
	}

}

class GatoEnemigo {

	var tamanioTecho
	var posicionTecho
	const tipo = self.definirTipo()
	var property image = tipo + ".png"
	var muerto = false
	var property position = game.at((posicionTecho.x() + 2).randomUpTo(posicionTecho.x() + tamanioTecho - 2).truncate(0), 1)

	method chocaCon(gato) {
		if (!muerto and !gato.gatoGrande()) {
			gato.caer()
		} else self.explotar(bolaDePelo)
	}

	method explotar(tipoProjectil) {
		if (!muerto){
		muerto = true
		tipoProjectil.sumarPuntos()
		const sonidoMuerte = game.sound("enemigomuerte.mp3")
		sonidoMuerte.shouldLoop(false)
		sonidoMuerte.play()
		self.image("estrellas.png")
		}
	}
	method reproducirSonidoAlAparecer(){
		game.sound("maullido"+tipo.toString()+".mp3").play()
	}
	method definirTipo() {
		return "enemigo" + 1.randomUpTo(4).truncate(0).toString()
	}

}

