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
		game.onTick(150, "espada.png", {if (salidaBosque.comprueboSiProtaEstaEnSalida()) mapa.saleBosque()})
		game.onTick(150, "zelda.png", {if (entradaCastillo.comprueboSiProtaEstaEnEntrada()) mapa.entraCastillo()})
		//entradaBosque.iniciar()		//test1 para ver puerta de bosque
		//salidaBosque.iniciar()		//test2 para ver salida de bosque
		entradaCastillo.iniciar()		//test3 para ver puerta de castillo
	}
}

object mapa {		//mapa principal
	var property position = game.origin()
	var property estaEnBosque = false
	var property estaEnCastillo = false
	var property lugar = 'aldea'
	const sufijo = '.png'
	
	method image(){
		
		return lugar + sufijo
		//return if (estaEnBosque){
		//	"bosque.png"
		//} else {
		//	"mapa.png"
		//}
	} 
	
	method entraBosque(){
		lugar = 'bosque'
		estaEnBosque = true
		prota.cambiarPosicion(9, 1)
		//entradaBosque.estaDentro(true)
		}
	
	method saleBosque(){
		lugar = 'aldea'
		estaEnBosque = false
		prota.cambiarPosicion(9,7)
		//entradaBosque.estaDentro(false)
	}
	
	method entraCastillo(){
		lugar = 'castillo'
		estaEnCastillo = true
		prota.cambiarPosicion(1, 1)
		//entradaBosque.estaDentro(true)
		}
		
	method iniciar(){
		game.addVisual(self)
	}
}


object entradaCastillo {						
	var property position = game.at(15,8)
	//var property estaDentro = false
	method image() = "zelda.png"		
	
	method iniciar(){
		game.addVisual(self)		//visual para Test1 ver donde esta la puerta
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnCastillo()
	}
}


object entradaBosque {						
	var property position = game.at(9,8)
	//var property estaDentro = false
	method image() = "hechicera.png"		
	
	method iniciar(){
		//game.addVisual(self)		//visual para Test1 ver donde esta la puerta
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnBosque()
	}

}

object salidaBosque {
	var property position = game.at(9,0)
	method image() = "espada.png"		
	
	method iniciar(){
		//game.addVisual(self) 		//visual para Test2 chequear donde esta la salida
	}
	
	method comprueboSiProtaEstaEnSalida() {
		return (prota.position() == self.position()) and mapa.estaEnBosque()
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
	
	method mirar(direccion) {
		
		const prefijo = 'pj_'
		const sufijo = '.png'
		
		image = prefijo + direccion + sufijo	
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
			prota.mirar('izquierda')
		}
		method teclaDerecha(){
			prota.irA(prota.position().right(1))
			prota.mirar('derecha')
		}
		method teclaArriba(){
			prota.irA(prota.position().up(1))
			prota.mirar('arriba')
		}
		method teclaAbajo(){
			prota.irA(prota.position().down(1))
			prota.mirar('abajo')
		}
}