import wollok.game.*

class Batalla{
	const _heroe = heroe
	const enemigo = ganon
	
	method iniciar(){
		//seteo el campo de batalla
		game.clear()
		game.ground("ground.png")
		game.height(15) //cambio las dimensione spor las dudas
		game.width(15)
		
		//posiciono a los personajes
		_heroe.position(_heroe.position().left(1))
		enemigo.position(enemigo.position().right(3))
		
		//los agrego a mi tablero
		game.addVisual(_heroe)
		game.addVisual(enemigo)
		
		//agrego mi cuadro de texto
		cuadroTexto.position(game.at(5,10))
		game.addVisual(cuadroTexto)
		
	}
}

object cuadroTexto{
	var property position
	
	
	method image() = "cuadro.png"
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

