import wollok.game.*
import proyectiles.*

object napoleon {
	//var comioWhiskas = false creo que no es necesario
	var property position = game.at(0,1)
	var proyectilesLanzados = 0
	//var proyectil = bolaDePelo
	
	method image() = "napoleon.png"
	
	method saltar(){
		position = position.up(1)
		game.schedule(50,{position = position.up(1)})
		game.schedule(150,{position = position.down(1)})
		game.schedule(200,{position = position.down(1)})
		
	}
	
	method disparar(){
		proyectilesLanzados++
		const p = new Proyectil(identificador=proyectilesLanzados)
		game.addVisual(p) 
		p.iniciar()
//		game.onTick(50,"dispararProyectil",{=>p.mover()})
//		if(p.fueraDePantalla()){
//			game.removeTickEvent("dispararProyectil")
//			game.removeVisual(p)
//					console.println("se rem")
//			
//		}
		//onTick mover el proyectil a la derecha hasta que colisione con el enemigo
	}
	
	method caer(){
		game.schedule(100,{position = position.down(1)})
		game.schedule(200,{position = position.up(1)})
		game.schedule(300,{position = position.up(1)})
		game.schedule(800,{position = position.down(1)})
		game.schedule(900,{position = position.down(1)})
		game.schedule(1000,{position = position.down(1)})
	}
	
	method comerWhiskas(){
		//proyectil = bolaDeFuego
	}
	
	
	method configurarControles(){
		keyboard.space().onPressDo({ self.saltar()})
		keyboard.q().onPressDo({ self.disparar()})	
		keyboard.c().onPressDo({self.caer()})		
	}
}
