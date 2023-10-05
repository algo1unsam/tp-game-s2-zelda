import wollok.game.*

object zelda {

	method configurar(){	
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		game.addVisual(mapa)
	}	
	
	method iniciar(){	//metodo que inicia cada objeto del juego
		prota.iniciar()
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
}