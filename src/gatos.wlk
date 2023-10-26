import wollok.game.*
import proyectiles.*
import nivel.*
import inventario.*
import powerups.*

object napoleon {

	// var comioWhiskas = false creo que no es necesario
	var muerto = false
	var property position = game.at(0, 1)
	var property image = "caminar3.png"
	var proyectilesLanzados = 0
	var property proyectilesActuales = "boladepelo"
	var property puedeConsumirPowerUp = true
	var puedeSaltar = true
	var property puedeDisparar = true
	var fotogramaCaminar = 0
	const listaProyectiles = #{}
	const property inventario = []
	var property framesDeCaminar = ["caminar1.png","caminar2.png","caminar3.png"]
	var property framesDeSaltar = ["salto1.png","salto2.png","salto3.png"]
	var property gatoGrande = false
	// var proyectil = bolaDePelo
	method removerProyectilesBasura() {
		listaProyectiles.forEach{ proyectil => proyectil.remover()}
	}

	method caminar() {
		game.onTick(100, "caminar", {=>
			if (puedeSaltar) {
				if (fotogramaCaminar > framesDeCaminar.size()-1) {
					fotogramaCaminar = 0
				}
				self.image(framesDeCaminar.get(fotogramaCaminar))
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
			self.image(framesDeSaltar.get(0))
		})
		game.schedule(150, { position = position.down(1)
			self.image(framesDeSaltar.get(1))
		})
		game.schedule(250, { position = position.down(1)
			self.image(framesDeSaltar.get(2))
		})
		game.schedule(260, { puedeSaltar = true})
	}

	method colisiones() {
		game.onCollideDo(self, { obstaculo => if(!muerto){obstaculo.chocaCon(self)}})
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
		muerto = true
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
			puedeConsumirPowerUp = false
			inventario.get(slot-1).usar(self)
			inventario.remove(inventario.get(slot-1))
		}
	}
	method configurarControles() {
		muerto = false
		image = "caminar3.png"
		proyectilesActuales = "boladepelo"
		puedeConsumirPowerUp = true
		position = game.at(1, 1)
		puedeSaltar = true
		puedeDisparar = true
		fotogramaCaminar = 0
		listaProyectiles.clear()
		inventario.clear()
		gatoGrande = false
	    framesDeCaminar = ["caminar1.png","caminar2.png","caminar3.png"]
	    framesDeSaltar = ["salto1.png","salto2.png","salto3.png"]
		//3.times({ i =>inventario.add(whiskas) })
		//3.times({inventario.add(invisible)})
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