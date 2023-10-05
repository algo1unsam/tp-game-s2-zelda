import wollok.game.*

class Batalla{
	const _heroe = heroe
	const enemigo = ganon
	
	method iniciar(){
		//seteo el campo de batalla
		game.ground("ground.png")
		game.height(10) //cambio las dimensione spor las dudas
		game.width(10)
		
		//posiciono a los personajes
		_heroe.position(_heroe.position().left(1))
		enemigo.position(enemigo.position().right(3))
		
		//los agrego a mi tablero
		game.addVisual(_heroe)
		game.addVisual(enemigo)
		
	}
}



//Para debugear mi codigo necesito dos personajes genericos
object heroe{
	var property position = game.center()
	
	method image() = "pj_derecha.png"
}

object ganon{
	var property position = game.center()
	
	method image() = "jefe_1.png"
	
}