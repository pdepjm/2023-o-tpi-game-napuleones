import wollok.game.*
object powerUps{
	const property powerUpsActuales = [whiskas]
}
class PowerUp {
	var tamanioTecho
	var posicionTecho
	const tipo = self.definirTipo()
	var property position = game.at(posicionTecho.x().randomUpTo(posicionTecho.x()+tamanioTecho).truncate(0), 1.randomUpTo(4).truncate(0))
	method chocaCon(gato){
		gato.agregarAInventario(tipo)
	}
	method definirTipo(){
		return powerUps.powerUpsActuales().get(0)
	}
	method image() = tipo.toString() + ".png"
}
class Nada {
	var property position
	method chocaCon(gato){}
	method definirTipo(){}
	//method image() = "pepita.png"
	
}
object whiskas {
	method usar(gato){
		gato.proyectilesActuales("boladefuego")
		game.schedule(5000,{gato.proyectilesActuales("boladepelo")})
	}
	
}
object lasagna {
	
	
}

class GatoEnemigo {
	var tamanioTecho
	var posicionTecho
	const tipo = self.definirTipo()
	var property position = game.at((posicionTecho.x()+2).randomUpTo(posicionTecho.x()+tamanioTecho-2).truncate(0), 1)//techos de 5 o mas
	method chocaCon(gato){
		gato.caer()
	}
	method definirTipo(){
		return "enemigo" + 1.randomUpTo(4).truncate(0).toString()
	}
	method image() = tipo+".png"
}