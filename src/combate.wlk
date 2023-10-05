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
		
		//agrego mi cuadro de habilidades
		const root = new CuadroTexto()
		root.position(game.at(1,0))
		game.addVisual(root)
		
		
		//agrego las habilidades
		const arriba_izq = new CuadroHabilidad()
		const abajo_izq = new CuadroHabilidad()
		const abajo_der = new CuadroHabilidad()
		const arriba_der = new CuadroHabilidad()
		
		//losposiciono dentro de mi marco
		arriba_izq.position(game.at(2,1))
		arriba_der.position(game.at(5,1))
		abajo_der.position(game.at(8,1))
		abajo_izq.position(game.at(11,1))
		
		
		//agrego los botones
		game.addVisual(arriba_izq)
		game.addVisual(abajo_izq)
		game.addVisual(arriba_der)
		game.addVisual(abajo_der)
				
		
	}
}


//objeto que va a tener el cuadro con opciones
class CuadroTexto{
	var property position = new Position()
	
	method image() = "cuadro.png"
}

class CuadroHabilidad inherits CuadroTexto{
	override method image() = "ggg.png"
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

