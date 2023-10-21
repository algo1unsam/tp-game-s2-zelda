import wollok.game.*
import combate.*

object zelda {

	method configurar(){	
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
	var property poder = 0
	var property dir = new Derecha()
	var property arr = position.up(1)
	
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
		keyboard.s().onPressDo({self.atacar()})
		}
		
		method teclaIzquierda(){
			prota.dir(new Izquierda())
			prota.irA(prota.position().left(1))
			prota.miraIzquierda()
		}
		method teclaDerecha(){
			prota.dir(new Derecha())
			prota.irA(prota.position().right(1))
			prota.miraDerecha()
		}
		method teclaArriba(){
			prota.dir(new Arriba())
			prota.irA(prota.position().up(1))
			prota.miraArriba()
		}
		method teclaAbajo(){
			prota.dir(new Abajo())
			prota.irA(prota.position().down(1))
			prota.miraAbajo()
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


//superclase que indica la direccion en la que miró el presonaje por ultima vez
class Direccion{
	method position(){
		return prota.position()
	}
	
	//hacemos daño si esta ganon
	method atacar(){
		game.getObjectsIn(self.position()).forEach{x=>x.recibirDanio(prota.poder())}
	}
	
}

class Arriba inherits Direccion{
	var property image = "golpe_arriba.png"
	override method position(){
		return prota.position().up(1)
	}
}

class Abajo inherits Direccion{
	var property image = "golpe_abajo.png"
	override method position(){
		return prota.position().down(1)
	}
}

class Izquierda inherits Direccion{
	var property image = "golpe_izquierda.png"
	override method position(){
		return prota.position().left(1)
	}
}

class Derecha inherits Direccion{
	var property image = "golpe_derecha.png"
	override method position(){
		return prota.position().right(1)
	}
}

