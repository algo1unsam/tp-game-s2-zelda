import wollok.game.*

object zelda {

	
	
	method configurar(){	
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		config.configurarTeclas()	
	}	
	
	//metodo que inicia cada objeto del juego
	method iniciar(){	
		mapa.iniciar()
		prota.iniciar()
		
		game.onTick(150, "Entrada Aldea", {if (entradaAldea.comprueboSiProtaEstaEnEntrada()) mapa.entraAldea()})
		game.onTick(150, "Salida Aldea", {if (salidaAldea.comprueboSiProtaEstaEnSalida()) mapa.saleAldea()})
		game.onTick(150, "Entrada Bosque", {if (entradaBosque.comprueboSiProtaEstaEnEntrada()) mapa.entraBosque()})
		game.onTick(150, "Salida Bosque", {if (salidaBosque.comprueboSiProtaEstaEnSalida()) mapa.saleBosque()})
		game.onTick(150, "Entrada Montania", {if (entradaMontania.comprueboSiProtaEstaEnEntrada()) mapa.entraMontania()})
		game.onTick(150, "Salida Montania", {if (salidaMontania.comprueboSiProtaEstaEnSalida()) mapa.saleMontania()})
		game.onTick(150, "Entrada Castillo", {if (entradaCastillo.comprueboSiProtaEstaEnEntrada()) mapa.entraCastillo()})
		//entradaBosque.iniciar()		//test1 para ver puerta de bosque
		
		game.whenCollideDo(prota, {pared => pared.colision()})
		
	}
}

class ParedIzq{
	var property position
	method image() = "hechicera.png"
	
	method iniciar(){
		game.addVisual(self)	
	}
	
	
	method colision(){
		prota.irA(prota.position().right(1))
	}
}

object paredes{
	
	const paredIzq1 = new ParedIzq(position = game.at(1,1))
	const paredIzq2 = new ParedIzq(position = game.at(1,2))
	const paredIzq3 = new ParedIzq(position = game.at(1,3))
	const paredIzq4 = new ParedIzq(position = game.at(1,4))
	const paredIzq5 = new ParedIzq(position = game.at(1,5))

}

// Objeto Mapa Principal
object mapa {
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
	
	method iniciar(){
		game.addVisual(self)
	}
	// Métodos de entradas y salidas del mapa
	method entraAldea(){
		lugar = 'aldea'
		estaEnAldea = true
		estaEnMapa = false
		prota.cambiarPosicion(19, 6)
		}
	method saleAldea(){
		lugar = 'mapa'
		estaEnAldea = false
		estaEnMapa = true
		prota.cambiarPosicion(4,6)
	}
	method entraBosque(){
		lugar = 'bosque'
		estaEnBosque = true
		estaEnMapa = false
		prota.cambiarPosicion(9, 1)
		}
	method saleBosque(){
		lugar = 'mapa'
		estaEnBosque = false
		estaEnMapa = true
		prota.cambiarPosicion(9,7)
	}
	method entraMontania(){
		lugar = 'montania'
		estaEnMontania = true
		estaEnMapa = false
		prota.cambiarPosicion(11, 11)
		}
	method saleMontania(){
		lugar = 'mapa'
		estaEnMontania = false
		estaEnMapa = true
		prota.cambiarPosicion(11,5)
	}
		method entraCastillo(){
		lugar = 'castillo'
		estaEnCastillo = true
		estaEnMapa = false
		prota.cambiarPosicion(1, 1)
		}
}

// Objetos Entradas y Salidas
object entradaAldea {						
	var property position = game.at(3,6)
	method image() = "hechicera.png"		
	
	method iniciar(){
		//game.addVisual(self)		//visual para Test
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnAldea() and mapa.estaEnMapa()
	}
}
object salidaAldea {
	var property position = game.at(20,6)
	method image() = "espada.png"		
	
	method iniciar(){
		//game.addVisual(self) 	
	}
	
	method comprueboSiProtaEstaEnSalida() {
		return (prota.position() == self.position()) and mapa.estaEnAldea() and not mapa.estaEnMapa()
	}
}
object entradaBosque {						
	var property position = game.at(9,8)
	method image() = "hechicera.png"		
	
	method iniciar(){
		//game.addVisual(self)		
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnBosque() and mapa.estaEnMapa()
	}
}
object salidaBosque {
	var property position = game.at(9,0)
	method image() = "espada.png"		
	
	method iniciar(){
		//game.addVisual(self) 
	}
	
	method comprueboSiProtaEstaEnSalida() {
		return (prota.position() == self.position()) and mapa.estaEnBosque() and not mapa.estaEnMapa()
	}
}
object entradaMontania {						
	var property position = game.at(11,4)
	method image() = "hechicera.png"		
	
	method iniciar(){
		//game.addVisual(self)
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnMontania() and mapa.estaEnMapa()
	}
}
object salidaMontania {
	var property position = game.at(11,12)
	method image() = "espada.png"		
	
	method iniciar(){
		//game.addVisual(self)
	}
	
	method comprueboSiProtaEstaEnSalida() {
		return (prota.position() == self.position()) and mapa.estaEnMontania() and not mapa.estaEnMapa()
	}
}
object entradaCastillo {						
	var property position = game.at(15,8)
	method image() = "zelda.png"		
	
	method iniciar(){
		//game.addVisual(self)
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnCastillo() and mapa.estaEnMapa()
	}
}

// Objeto Protagonista
object prota {		
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