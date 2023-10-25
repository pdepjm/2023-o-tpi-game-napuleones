import wollok.game.*
import proyectiles.*
import nivel.*

object napoleon {

	// var comioWhiskas = false creo que no es necesario
	var property position = game.at(0, 1)
	var property image = "caminar3.png"
	var proyectilesLanzados = 0
	var property proyectilesActuales = "boladepelo"
	var property puedeConsumirPowerUp = true
	var puedeSaltar = true
	var property puedeDisparar = true
	var fotogramaCaminar = 1
	const listaProyectiles = #{}
	const inventario = []
	// var proyectil = bolaDePelo
	method removerProyectilesBasura() {
		listaProyectiles.forEach{ proyectil => proyectil.remover()}
	}

	method caminar() {
		game.onTick(100, "caminar", {=>
			if (puedeSaltar) {
				if (fotogramaCaminar > 3) {
					fotogramaCaminar = 1
				}
				self.image("caminar" + fotogramaCaminar.toString() + ".png")
				fotogramaCaminar++
			}
		})
	}

	method pararCaminata() {
		game.removeTickEvent("caminar")
		fotogramaCaminar = 0
	}

	method saltar() {
		puedeSaltar = false
		position = position.up(1)
		game.schedule(50, { position = position.up(1)
			self.image("salto1.png")
		})
		game.schedule(150, { position = position.down(1)
			self.image("salto2.png")
		})
		game.schedule(250, { position = position.down(1)
			self.image("salto3.png")
		})
		game.schedule(260, { puedeSaltar = true})
	}

	method colisiones() {
		game.onCollideDo(self, { obstaculo => obstaculo.chocaCon(self)})
	}

	method disparar() {
		puedeDisparar = false
		proyectilesLanzados++
		const nuevoProyectil = new Proyectil(identificador = proyectilesLanzados, image = proyectilesActuales+".png")
		listaProyectiles.add(nuevoProyectil)
		game.addVisual(nuevoProyectil)
		nuevoProyectil.iniciar()
	}

	method caer() {
		puedeSaltar = false
		puedeDisparar = false
		puedeConsumirPowerUp = false
		techos.parar()
		self.pararCaminata()
		nivel.gameOver()
		game.schedule(100, { position = position.down(1)
			self.image("caer1.png")
		})
		game.schedule(200, { position = position.up(1)
			self.image("caer2.png")
		})
		game.schedule(300, { position = position.up(1)})
		game.schedule(800, { position = position.down(1)
			self.image("caer3.png")
		})
		game.schedule(900, { position = position.down(1)})
		game.schedule(1000, { position = position.down(1) nivel.reiniciarNivel()})
	}

	method agregarAInventario(powerUp) {
		if (inventario.size()>=3){
			inventario.remove(inventario.get(0))
		}
		inventario.add(powerUp)
	}
	method consumirPowerUp(slot){
		if(!inventario.isEmpty()){
			inventario.get(slot-1).usar(self)
			inventario.remove(inventario.get(slot-1))
		}
	}
	method configurarControles() {
		image = "caminar3.png"
		puedeConsumirPowerUp = true
		position = game.at(0, 1)
		puedeSaltar = true
		puedeDisparar = true
		fotogramaCaminar = 1
		listaProyectiles.clear()
		inventario.clear()
		keyboard.space().onPressDo({ if (puedeSaltar) self.saltar()
		})
		keyboard.num1().onPressDo({ if (puedeConsumirPowerUp) self.consumirPowerUp(1)
		})
		keyboard.num2().onPressDo({ if (puedeConsumirPowerUp) self.consumirPowerUp(2)
		})
		keyboard.num3().onPressDo({ if (puedeConsumirPowerUp) self.consumirPowerUp(3)
		})
		keyboard.q().onPressDo({ if (puedeDisparar) self.disparar()
		})
		self.colisiones()
		self.caminar()
	}

}

