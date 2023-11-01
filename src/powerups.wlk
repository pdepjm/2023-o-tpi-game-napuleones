import wollok.game.*
import nivel.*
import proyectiles.*
object powerUps{
	const property powerUpsActuales = [whiskas, croqueta]
}
class PowerUp {
	var tamanioTecho
	var posicionTecho
	const tipo = self.definirTipo()
	var property image = tipo.toString() + ".png"
	var property position = game.at(posicionTecho.x().randomUpTo(posicionTecho.x()+tamanioTecho).truncate(0), 1.randomUpTo(3).truncate(0))
	method chocaCon(gato){
		self.image("estrellas.png")
		gato.agregarAInventario(tipo)
	}
	method explotar(tipoProjectil){
	}
	method definirTipo(){
		return powerUps.powerUpsActuales().get(0.randomUpTo(2).truncate(0))
	}
	
}
class Nada {
	var property position
	method chocaCon(gato){}
	method definirTipo(){}
	method explotar(tipoProjectil){
	}
	//method image() = "pepita.png"
	
}
object whiskas {
	method image() = "whiskas.png"
	method usar(gato){
		gato.proyectilesActuales(bolaDeFuego)
		game.schedule(5000,{gato.proyectilesActuales(bolaDePelo) gato.puedeConsumirPowerUp(true)})
	}
	
}
object croqueta {
	const framesCaminarNormal = ["caminar1.png","caminar2.png","caminar3.png"]
	const framesCaminarGrande = ["caminar1Grande.png","caminar2Grande.png","caminar3Grande.png"]
	const framesSaltoNormal = ["salto1.png","salto2.png","salto3.png"]
	const framesSaltoGrande = ["salto1Grande.png","salto2Grande.png","salto3Grande.png"]
	
	method image() = "croqueta.png"
	method usar(gato){
		gato.framesDeCaminar(framesCaminarGrande)
		gato.framesDeSaltar(framesSaltoGrande)
		gato.gatoGrande(true)
		game.schedule(5000,{gato.framesDeCaminar(framesCaminarNormal) gato.gatoGrande(false) gato.framesDeSaltar(framesSaltoNormal) gato.puedeConsumirPowerUp(true)})
	}
	
}

class GatoEnemigo {
	var tamanioTecho
	var posicionTecho
	const tipo = self.definirTipo()
	var property image = tipo+".png"
	var puedeDaniar = true
	var property position = game.at((posicionTecho.x()+2).randomUpTo(posicionTecho.x()+tamanioTecho-2).truncate(0), 1)
	method chocaCon(gato){
		if (puedeDaniar and !gato.gatoGrande()){gato.caer()}else self.explotar(bolaDePelo)
	}
	method explotar(tipoProjectil){
		puedeDaniar = false
		tipoProjectil.sumarPuntos()
		self.image("estrellas.png")
	}
	method definirTipo(){
		return "enemigo" + 1.randomUpTo(4).truncate(0).toString()
	} 
}