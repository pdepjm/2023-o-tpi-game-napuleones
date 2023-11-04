import wollok.game.*
import proyectiles.*
import nivel.*
import inventario.*
import spawns.*

object napoleon {

	var muerto = false
	var property position = game.at(0, 1)
	var property image = "caminar3.png"
	var proyectilesLanzados = 0
	var property proyectilesActuales = bolaDePelo
	var property puedeConsumirPowerUp = true
	var puedeSaltar = true
	var property puedeDisparar = true
	var fotogramaCaminar = 0
	const listaProyectiles = #{}
	const property inventario = []
	var property framesDeCaminar = [ "caminar1.png", "caminar2.png", "caminar3.png" ]
	var property framesDeSaltar = [ "salto1.png", "salto2.png", "salto3.png" ]
	var property gatoGrande = false
	method removerProyectilesBasura() {
		listaProyectiles.forEach{ proyectil => proyectil.remover()}
	}

	method caminar() {
		game.onTick(100, "caminar", {=>
			if (puedeSaltar) {
				if (fotogramaCaminar > framesDeCaminar.size() - 1) {
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
		const sonidoSaltar = game.sound("saltar.wav")
		sonidoSaltar.shouldLoop(false)
		sonidoSaltar.play()
		
		game.schedule(50, { if (!muerto) position = position.up(1)
			self.image(framesDeSaltar.get(0))
		})
		game.schedule(150, { if (!muerto) position = position.down(1)
			self.image(framesDeSaltar.get(1))
		})
		game.schedule(250, { if (!muerto) position = position.down(1)
			self.image(framesDeSaltar.get(2))
		})
		game.schedule(260, {  if (!muerto) puedeSaltar = true 
		})
	}

	method colisiones() {
		game.onCollideDo(self, { obstaculo =>
			if (!muerto) {
				obstaculo.chocaCon(self)
			}
		})
	}

	method disparar() {
		puedeDisparar = false
		proyectilesLanzados++
		const nuevoProyectil = new Proyectil(identificador = proyectilesLanzados, tipoProjectil = proyectilesActuales)
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
			game.sound("sonidocaer.wav").play()
		})
		game.schedule(300, { position = position.up(1)})
		game.schedule(800, { position = position.down(1)
			self.image("caer3.png")
			game.sound("sonidomuerte.wav").play()
		})
		game.schedule(900, { position = position.down(1)})
		game.schedule(1000, { position = position.down(1)
			nivel.reiniciarNivel()
		})
	}

	method agregarAInventario(powerUp) {
		if (inventario.size() >= 3) {
			inventario.remove(inventario.get(0))
		}
		game.sound("agregarpowerup.wav").play()
		inventario.add(powerUp)
	}

	method consumirPowerUp(slot) {
		if (!inventario.isEmpty()) {
			puedeConsumirPowerUp = false
			game.sound("consumirpowerup.wav").play()
			inventario.get(slot - 1).usar(self)
			inventario.remove(inventario.get(slot - 1))
		}
	}

	method configurarControles() {
		muerto = false
		image = "caminar3.png"
		proyectilesActuales = bolaDePelo
		puedeConsumirPowerUp = true
		position = game.at(1, 1)
		puedeSaltar = true
		puedeDisparar = true
		fotogramaCaminar = 0
		listaProyectiles.clear()
		inventario.clear()
		gatoGrande = false
		framesDeCaminar = [ "caminar1.png", "caminar2.png", "caminar3.png" ]
		framesDeSaltar = [ "salto1.png", "salto2.png", "salto3.png" ]
		keyboard.space().onPressDo({ if (puedeSaltar) self.saltar()
		})
		keyboard.num1().onPressDo({ if (puedeConsumirPowerUp) self.consumirPowerUp(1)
		})
		keyboard.num2().onPressDo({ if (puedeConsumirPowerUp) self.consumirPowerUp(2)
		})
		keyboard.num3().onPressDo({ if (puedeConsumirPowerUp) self.consumirPowerUp(3)
		})
		keyboard.q().onPressDo({ if (puedeDisparar and !muerto) self.disparar()
		})
		self.colisiones()
		self.caminar()
	}

}

