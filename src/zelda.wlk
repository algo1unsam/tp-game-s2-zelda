import wollok.game.*
import personajes.*

object zelda {

	method configurar(){	
		//config. mapa
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		game.addVisual(mapa)
		
		keyboard.up().onPressDo{wollink.mover(wollink.position().up(1))}
		keyboard.down().onPressDo{wollink.mover(wollink.position().down(1))}
		keyboard.left().onPressDo{wollink.mover(wollink.position().left(1))}
		keyboard.right().onPressDo{wollink.mover(wollink.position().right(1))}
		keyboard.a().onPressDo{}
		keyboard.s().onPressDo{wollink.atacar()}
	}
	
	method iniciar(){	
		//metodo que inicia cada objeto del juego
		wollink.iniciar()
		npc.iniciar()
		bloques.iniciar()	
	}
}

object mapa {
	//mapa principal
	var  property position = game.origin()
	method image() = "mapa.png"
	
	method agregarBloque(){
		game.addVisualIn("escudo.png",game.at(4,7))
		
	}
	
}

object bloques{
	var property position = 0
	
	//game.at(4,7),game.at(5,7),game.at(6,7),game.at(7,7),game.at(8,7),game.at(10,7),game.at(11,7),game.at(12,7),game.at(13,7), game.at(14,7)
	//game.at(3,5),game.at(4,5) ,game.at(5,5),game.at(6,5),game.at(7,5),game.at(8,5),game.at(9,5),game.at(11,5),game.at(12,5), game.at(13,5), game.at(14,5), game.at(15,5),game.at(16,5)
	//game.at(16,6), game.at(16,7)
	//game.at(2,5),game.at(2,6), game.at(2,7)
	
	method iniciar(){}
}
