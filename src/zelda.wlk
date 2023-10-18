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
		game.onTick(150, "hechicera.png", {if (entradaMontania.comprueboSiProtaEstaEnEntrada()) mapa.entraMontania()})
		game.onTick(150, "espada.png", {if (salidaMontania.comprueboSiProtaEstaEnSalida()) mapa.saleMontania()})
		game.onTick(150, "hechicera.png", {if (entradaAldea.comprueboSiProtaEstaEnEntrada()) mapa.entraAldea()})
		game.onTick(150, "espada.png", {if (salidaAldea.comprueboSiProtaEstaEnSalida()) mapa.saleAldea()})
		//entradaBosque.iniciar()		//test1 para ver puerta de bosque
		//salidaBosque.iniciar()		//test2 para ver salida de bosque
		entradaCastillo.iniciar()		//test3 para ver puerta de castillo
	}
}

object mapa {		//mapa principal
	var property position = game.origin()
	var property estaEnAldea = true
	var property estaEnMapa = false
	var property estaEnBosque = false
	var property estaEnCastillo = false
	var property estaEnMontania = false
	var property lugar = 'aldea'
	const sufijo = '.png'
	
	method image(){
		
		return lugar + sufijo
	} 
	
	method entraAldea(){
		lugar = 'aldea'
		estaEnAldea = true
		estaEnMapa = false
		prota.cambiarPosicion(19, 6)
		//entradaBosque.estaDentro(true)
		}
		
	method saleAldea(){
		lugar = 'mapa'
		estaEnAldea = false
		estaEnMapa = true
		prota.cambiarPosicion(3,6)
		//entradaBosque.estaDentro(false)
	}
		
	method entraBosque(){
		lugar = 'bosque'
		estaEnBosque = true
		prota.cambiarPosicion(9, 1)
		//entradaBosque.estaDentro(true)
		}
	
	method saleBosque(){
		lugar = 'mapa'
		estaEnBosque = false
		prota.cambiarPosicion(9,7)
		//entradaBosque.estaDentro(false)
	}
		
	method entraMontania(){
		lugar = 'montania'
		estaEnMontania = true
		prota.cambiarPosicion(11, 12)
		//entradaBosque.estaDentro(true)
		}
	
	method saleMontania(){
		lugar = 'mapa'
		estaEnMontania = false
		prota.cambiarPosicion(11,6)
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

object entradaAldea {						
	var property position = game.at(2,6)
	//var property estaDentro = false
	method image() = "hechicera.png"		
	
	method iniciar(){
		//game.addVisual(self)		//visual para Test1 ver donde esta la puerta
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnAldea() and mapa.estaEnMapa()
	}
}

object salidaAldea {
	var property position = game.at(20,6)
	method image() = "espada.png"		
	
	method iniciar(){
		//game.addVisual(self) 		//visual para Test2 chequear donde esta la salida
	}
	
	method comprueboSiProtaEstaEnSalida() {
		return (prota.position() == self.position()) and mapa.estaEnAldea() and not mapa.estaEnMapa()
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

object entradaMontania {						
	var property position = game.at(11,4)
	//var property estaDentro = false
	method image() = "hechicera.png"		
	
	method iniciar(){
		//game.addVisual(self)		//visual para Test1 ver donde esta la puerta
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnMontania()
	}
}

object salidaMontania {
	var property position = game.at(11,12)
	method image() = "espada.png"		
	
	method iniciar(){
		//game.addVisual(self) 		//visual para Test2 chequear donde esta la salida
	}
	
	method comprueboSiProtaEstaEnSalida() {
		return (prota.position() == self.position()) and mapa.estaEnMontania()
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