import wollok.game.*
import combate.*
import personajes.*
import objetos.*
import utiles.*
import puzzle.*
import sonidos.*

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
		const SalidaAldea = new Salidas(X=19,Y=6)
		const EntradaAldea = new Entradas(X=3,Y=6)
		const EntradaBosque = new Entradas(X=9,Y=8)
		const SalidaBosque = new Salidas(X=9,Y=0)
		const EntradaMontania = new Entradas(X=11,Y=4)
		const SalidaMontania = new Salidas(X=11,Y=12)
		const EntradaCastillo = new Entradas(X=15,Y=8)
		game.onTick(150, "Entrada Aldea", {if (EntradaAldea.comprueboSiProtaEstaEnPuerta()) mapa.entraAldea()})
		game.onTick(150, "Salida Aldea", {if (SalidaAldea.comprueboSiProtaEstaEnPuerta()) mapa.saleAldea()})
		game.onTick(150, "Entrada Bosque", {if (EntradaBosque.comprueboSiProtaEstaEnPuerta()) mapa.entraBosque()})
		game.onTick(150, "Salida Bosque", {if (SalidaBosque.comprueboSiProtaEstaEnPuerta()) mapa.saleBosque()})
		game.onTick(150, "Entrada Montania", {if (EntradaMontania.comprueboSiProtaEstaEnPuerta()) mapa.entraMontania()})
		game.onTick(150, "Salida Montania", {if (SalidaMontania.comprueboSiProtaEstaEnPuerta()) mapa.saleMontania()})
		game.onTick(150, "Entrada Castillo", {if (EntradaCastillo.comprueboSiProtaEstaEnPuerta()) mapa.entraCastillo()})
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
//espada para el bosque
	
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
		espadaMaestra.aparecer() //la espada aprece
		}
	method saleBosque(){
		lugar = 'mapa'
		estaEnBosque = false
		estaEnMapa = true
		prota.cambiarPosicion(9,7)
		distribucion.mapa()
		espadaMaestra.desaparecer() //la espada desaparece cuando entramos al bosque
	}
	method entraMontania(){
		puzzle.iniciar()
		lugar = 'montania'
		estaEnMontania = true
		estaEnMapa = false
		prota.cambiarPosicion(11, 11)
		distribucion.montania()
		}
	method saleMontania(){
		if (puzzleResuelto == true){
			lugar = 'mapa'
		estaEnMontania = false
		estaEnMapa = true
		prota.cambiarPosicion(11,5)
		mapaPuzzle.eliminarVisualesMontania()
		distribucion.mapa()
		}
		else{
			game.say(prota, "Debería abrir el cofre primero")
		}
		
	}
		method entraCastillo(){
		lugar = 'castillo'
		estaEnMapa = false
		prota.cambiarPosicion(1, 1)
		sonidos.sound("enemigo.mp3")
		var b = new Batalla()
		b.iniciar()
		}
		
		//metodo vacio para que no me de error
		method colision(){}
}

class Puertas{
	var property X
	var property Y
	var property position = game.at(X,Y)
		
	method comprueboSiProtaEstaEnPuerta() {return (prota.position() == self.position())}
}

class Entradas inherits Puertas{
	
	override method comprueboSiProtaEstaEnPuerta(){
		return super() and mapa.estaEnMapa()
	}
}

class Salidas inherits Puertas{
	
	override method comprueboSiProtaEstaEnPuerta(){
		 return super() and not mapa.estaEnMapa() 
		 }
}