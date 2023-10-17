import wollok.game.*

object zelda {

	method configurar(){	
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		config.configurarTeclas()
		
	}	
	
	method iniciar(){	//metodo que inicia cada objeto del juego
		mapa.iniciar()
		prota.iniciar()
		game.onTick(150, "hechicera.png", {if (entradaBosque.comprueboSiProtaEstaEnEntrada()) mapa.entraBosque()})
		game.onTick(150, "espadan.png", {if (salidaBosque.comprueboSiProtaEstaEnSalida()) mapa.saleBosque()})
		//entradaBosque.iniciar()		//test1 para ver puerta de bosque
		//salidaBosque.iniciar()		//test2 para ver puerta de bosque
	}
}

object mapa {		//mapa principal
	var property position = game.origin()
	var estaEnBosque = false
	
	method image(){
		return if (estaEnBosque){
			"bosque.png"
		} else {
			"mapa.png"
		}
	} 
	
	method entraBosque(){
		estaEnBosque = true
		prota.cambiarPosicion(9, 1)
	}
	
	method saleBosque(){
		estaEnBosque = false
		prota.cambiarPosicion(9,7)
	}
	
	method iniciar(){
		game.addVisual(self)
	}
}

object prota {		//objeto de protagonista para probar cambios de mapa
	var property position = game.at(3,6)
	var property image =  "pj_abajo.png"
	
		
	method iniciar(){
		game.addVisual(self)
	}
	
	method cambiarPosicion(x, y){
		position = game.at(x, y)
	}
	
	method irA(nuevaPosicion) {
		position = nuevaPosicion
	}
	
	method miraIzquierda(){
		image = "pj_izquierda.png"
	}
	method miraAbajo(){
		image = "pj_abajo.png"
	}
	method miraDerecha(){
		image = "pj_derecha.png"
	}
	method miraArriba(){
		image = "pj_arriba.png"
	}
}

object entradaBosque {						
	var property position = game.at(9,8)
	method image() = "hechicera.png"		
	
	method iniciar(){
		//game.addVisual(self)		//visual para Test1 ver donde esta la puerta
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position())
	}
}

object salidaBosque {
	var property position = game.at(9,0)
	method image() = "espada.png"		
	
	method iniciar(){
		//game.addVisual(self) 		//visual para Test2 chequear donde esta la salida
	}
	
	method comprueboSiProtaEstaEnSalida() {
		return (prota.position() == self.position()) 
	}
}

object config {
		method configurarTeclas() {
		keyboard.left().onPressDo({ self.teclaIzquierda()})
		keyboard.right().onPressDo({ self.teclaDerecha() })
		keyboard.up().onPressDo({ self.teclaArriba() })
		keyboard.down().onPressDo({ self.teclaAbajo() })
		}
		
		method teclaIzquierda(){
			prota.irA(prota.position().left(1))
			prota.miraIzquierda()
		}
		method teclaDerecha(){
			prota.irA(prota.position().right(1))
			prota.miraDerecha()
		}
		method teclaArriba(){
			prota.irA(prota.position().up(1))
			prota.miraArriba()
		}
		method teclaAbajo(){
			prota.irA(prota.position().down(1))
			prota.miraAbajo()
		}
}