import wollok.game.*

object zelda {

	method configurar(){	
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		game.boardGround("mapa.png")
		config.configurarTeclas()
		
	}	
	
	method iniciar(){	//metodo que inicia cada objeto del juego
		prota.iniciar()
		cambioBosque.iniciar()
	}
}

object mapa {		//mapa principal
	
	var property position = game.origin()
	method image() = "mapa.png"
	
}

object prota {		//objeto de protagonista para probar cambios de mapa
	
	var property position = game.at(3,6)
	method image() = "pj_abajo.png"
	
		
	method iniciar(){
		game.addVisual(self)
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
}

object cambioBosque {						//SIN TERMINAR
	var property position = game.at(5,6)	//cuando choque a la hechicera debe cambiar la imagen al bosque
	method image() = "hechicera.png"		
	
	method iniciar(){
		game.addVisual(self)
		//game.onCollideDo(cambioBosque, cambioBosque.choque() )
	}
	
	method choque(){
		game.addVisual("bosque.png")
	}
}

object config {
		method configurarTeclas() {
		keyboard.left().onPressDo({ prota.irA(prota.position().left(1)) })
		keyboard.right().onPressDo({ prota.irA(prota.position().right(1))})
		keyboard.up().onPressDo({ prota.irA(prota.position().up(1))})
		keyboard.down().onPressDo({ prota.irA(prota.position().down(1))})
		}
}