import wollok.game.*
import combate.*
import personajes.*
import objetos.*


object zelda {

	method configurar(){	
		//config. mapa
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		config.configurarTeclas()
		
	}	
	
	method iniciar(){
		mapa.iniciar()
		prota.iniciar()
		game.onTick(150, "hechicera.png", {if (entradaBosque.comprueboSiProtaEstaEnEntrada()) mapa.entraBosque()})
		game.onTick(150, "espadan.png", {if (salidaBosque.comprueboSiProtaEstaEnSalida()) mapa.saleBosque()})
		entradaBosque.iniciar()		//test1 para ver puerta de bosque
		salidaBosque.iniciar()		//test2 para ver puerta de bosque
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

object config {
	
	
		method configurarTeclas() {
		keyboard.left().onPressDo({ self.teclaIzquierda()})
		keyboard.right().onPressDo({ self.teclaDerecha() })
		keyboard.up().onPressDo({ self.teclaArriba() })
		keyboard.down().onPressDo({ self.teclaAbajo() })
		keyboard.s().onPressDo({self.atacar()})
		}
		
		method teclaIzquierda(){
			prota.dir(new Izquierda())
			prota.mover(prota.position().left(1))
			prota.mirar('izquierda')
		}
		method teclaDerecha(){
			prota.dir(new Derecha())
			prota.mover(prota.position().right(1))
			prota.mirar('derecha')
		}
		method teclaArriba(){
			prota.dir(new Arriba())
			prota.mover(prota.position().up(1))
			prota.mirar('arriba')
		}
		method teclaAbajo(){
			prota.dir(new Abajo())
			prota.mover(prota.position().down(1))
			prota.mirar('abajo')
		}

		
		
		method atacar(){
			//hacemos dañio la celda correspondiente
			prota.dir().atacar()
			//agregamos el sprite del ataque al tablero
			game.addVisual(prota.dir())
			//necesito una variable temporal que me almacene el visual del ataque, pq sino esta puede cambiar y romperme el codigo
			var temp = prota.dir() 
			//eliminamos el sprite del ataque
			game.schedule(10,{game.removeVisual(temp)})
		}
}




