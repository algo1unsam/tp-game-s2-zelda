import wollok.game.*
import zelda.*
import objetos.*
import personajes.*

class Batalla{
	const _heroe = prota
	const enemigo = ganon
	
	method iniciar(){
		game.clear()
		_heroe.iniciar()
		enemigo.iniciar()
		config.configurarTeclas()
		
		//posiciono a los personajes
		_heroe.position(_heroe.position().left(1))
		enemigo.position(enemigo.position().right(3))
		
//		//los agrego a mi tablero
//		game.addVisual(_heroe)
//		game.addVisual(enemigo)
		
		//activo onticks
		game.onTick(8000,"ganon moverse",{=>ganon.moverse()})
		game.onTick(2000,"ganon atacar",{=>ganon.atacar()})		
	}
}
















