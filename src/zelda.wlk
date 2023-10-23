import wollok.game.*
import combate.*
import personajes.*
import objetos.*
import utiles.*

object zelda {

	method configurar(){	
		//config. mapa
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		config.configurarTeclas()
		
	}	
	
	method iniciar(){
		var b = new Batalla()
//		b.iniciar() activar parainicir la batalla final
		mapa.iniciar() //comentar para iniciar la batalla final
		prota.iniciar() //comentar para iniciar la batalla final
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





