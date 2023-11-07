import wollok.game.*
import zelda.*
import objetos.*
import personajes.*
import utiles.*

class Batalla{
	const _heroe = prota
	const enemigo = ganon
	
	method iniciar(){
		game.clear()
		game.addVisual(mapa)
		_heroe.iniciar()
		enemigo.iniciar()
		config.configurarTeclas()
		zelda.bordes()
		game.whenCollideDo(prota, {objeto=>objeto.colision()})
		Corazoncitos.iniciar()
		
		
		//posiciono a los personajes
		_heroe.position(_heroe.position().left(1))
		enemigo.position(enemigo.position().right(3))
		
		
		//activo onticks
		game.onTick(7000,"ganon moverse",{=>ganon.moverse()})
		game.onTick(1000,"ganon atacar",{=>ganon.atacar()})		
	}
}