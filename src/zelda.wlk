import wollok.game.*
import example.*

object zelda {

	method configurar(){	
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		game.addVisual(mapa)
		
		keyboard.up().onPressDo{wollink.mover(wollink.position().up(1))}
		keyboard.down().onPressDo{wollink.mover(wollink.position().down(1))}
		keyboard.left().onPressDo{wollink.mover(wollink.position().left(1))}
		keyboard.right().onPressDo{wollink.mover(wollink.position().right(1))}
		}
		
	method iniciar(){	//metodo que inicia cada objeto del juego
		wollink.iniciar()
		
	}
}

object mapa {		//mapa principal
	
	var property position = game.origin()
	method image() = "mapa.png"
	
}
	
	