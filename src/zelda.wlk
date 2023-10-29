import wollok.game.*
import combate.*
import personajes.*
import objetos.*
import utiles.*
import puzzle.*

object zelda {
	method configurar(){	
		//config. mapa
		game.width(20)
		game.height(13)
		game.title("Zelda: Ocarina of Wollok")
		config.configurarTeclas()
	}	
	
// 	Metodo que inicia cada objeto del juego
	method iniciar(){
		var b = new Batalla()
		mapa.iniciar() //comentar para iniciar la batalla final
		prota.iniciar() //comentar para iniciar la batalla final
		self.bordes()
		game.whenCollideDo(prota, {objeto=>objeto.colision()})
		game.onTick(150, "Entrada Aldea", {if (entradaAldea.comprueboSiProtaEstaEnEntrada()) mapa.entraAldea()})
		game.onTick(150, "Salida Aldea", {if (salidaAldea.comprueboSiProtaEstaEnSalida()) mapa.saleAldea()})
		game.onTick(150, "Entrada Bosque", {if (entradaBosque.comprueboSiProtaEstaEnEntrada()) mapa.entraBosque()})
		game.onTick(150, "Salida Bosque", {if (salidaBosque.comprueboSiProtaEstaEnSalida()) mapa.saleBosque()})
		game.onTick(150, "Entrada Montania", {if (entradaMontania.comprueboSiProtaEstaEnEntrada()) mapa.entraMontania()})
		game.onTick(150, "Salida Montania", {if (salidaMontania.comprueboSiProtaEstaEnSalida()) mapa.saleMontania()})
		game.onTick(150, "Entrada Castillo", {if (entradaCastillo.comprueboSiProtaEstaEnEntrada()) mapa.entraCastillo()})
		//entradaBosque.iniciar()		//test1 para ver puerta de bosque
	}
	
	method bordes(){
		
		21.times{l => var pared = new ParedInvisible(position=game.at(l-1,-1))
			game.addVisual(pared)
		}
		21.times{l => var pared = new ParedInvisible(position=game.at(l-1,13))
			game.addVisual(pared)
		}
		12.times{l => var pared = new ParedInvisible(position=game.at(-1,l))
			game.addVisual(pared)
		}
		12.times{l => var pared = new ParedInvisible(position=game.at(20,l))
			game.addVisual(pared)
		}
	}
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
//puzzle para la montaña	
	var property puzzleResuelto = false	
//método para marcar el puzzle como resuelto
	method resolverPuzzle(){
		puzzleResuelto = true
	}
	
	method image(){return lugar + sufijo} 
	
	method iniciar(){
		game.addVisual(self)
		distribucion.aldea()
	}
	
// Métodos de entradas y salidas del mapa
	method entraAldea(){
		lugar = 'aldea'
		estaEnAldea = true
		estaEnMapa = false
		prota.cambiarPosicion(18, 6)
		distribucion.aldea()
		}
	method saleAldea(){
		lugar = 'mapa'
		estaEnAldea = false
		estaEnMapa = true
		prota.cambiarPosicion(4,6)
		distribucion.mapa()
	}
	method entraBosque(){
		lugar = 'bosque'
		estaEnBosque = true
		estaEnMapa = false
		prota.cambiarPosicion(9, 1)
		distribucion.bosque()
		}
	method saleBosque(){
		lugar = 'mapa'
		estaEnBosque = false
		estaEnMapa = true
		prota.cambiarPosicion(9,7)
		distribucion.mapa()
	}
	method entraMontania(){
		puzzle.iniciar()
		lugar = 'montania'
		estaEnMontania = true
		estaEnMapa = false
		prota.cambiarPosicion(11, 11)
		}
	method saleMontania(){
		if (puzzleResuelto == true){
			lugar = 'mapa'
		estaEnMontania = false
		estaEnMapa = true
		prota.cambiarPosicion(11,5)
		mapaPuzzle.eliminarVisualesMontania()
		}
		else{
			game.say(prota, "Debería abrir el cofre primero")
		}
		distribucion.mapa()
	}
		method entraCastillo(){
		lugar = 'castillo'
		estaEnMapa = false
		prota.cambiarPosicion(1, 1)
		var b = new Batalla()
		b.iniciar()
		}
		
		//metodo vacio para que no me de error
		method colision(){}
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
	var property position = game.at(19,6)
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
		return (prota.position() == self.position()) and mapa.estaEnMontania() and not mapa.estaEnMapa()}
}
object entradaCastillo {						
	var property position = game.at(15,8)
	method image() = "zelda.png"		
	
	method iniciar(){
		//game.addVisual(self)
	}
	
	method comprueboSiProtaEstaEnEntrada() {	
		return (prota.position() == self.position()) and not mapa.estaEnCastillo() and mapa.estaEnMapa()//////SUPERCLASE de entrada y de salida (fabri)
	}
}

