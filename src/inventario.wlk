import wollok.game.*
import gatos.*

object inventarioUI {

	const slot1 = new Slot(position = game.at(10, 4))
	const slot2 = new Slot(position = game.at(11, 4))
	const slot3 = new Slot(position = game.at(12, 4))

	method position() = game.at(10, 4)

	method image() = "inventario.png"

	method parar() {
	}

	method iniciar() {
		game.addVisual(slot1)
		game.addVisual(slot2)
		game.addVisual(slot3)
		game.onTick(10, "mostrarSlots", {=>
			if (napoleon.inventario().size() > 0) {
				slot1.image(napoleon.inventario().get(0).image())
			} else slot1.image("vacio.png")
			if (napoleon.inventario().size() > 1) {
				slot2.image(napoleon.inventario().get(1).image())
			} else slot2.image("vacio.png")
			if (napoleon.inventario().size() > 2) {
				slot3.image(napoleon.inventario().get(2).image())
			} else slot3.image("vacio.png")
		})
	}

}

class Slot {

	const position
	var property image = "vacio.png"

	method position() = position

}

