import wollok.game.*

class Batalla{
	const _heroe = heroe
	const enemigo = ganon
	
	method iniciar(){
		//seteo el campo de batalla
		game.clear()
		game.ground("ground.png")
		game.height(13) //cambio las dimensione spor las dudas
		game.width(20)
		
		//posiciono a los personajes
		_heroe.position(_heroe.position().left(1))
		enemigo.position(enemigo.position().right(3))
		
		//los agrego a mi tablero
		game.addVisual(_heroe)
		game.addVisual(enemigo)
		
		//agrego mi cuadro de habilidades
		const root = new CuadroTexto()
		root.position(game.at(3,0))
		game.addVisual(root)
		
		
		//agrego las habilidades--se puede hacer con una lista
		const ataque = new CuadroHabilidad(image = "boton_ataque.png")
		const defensa = new CuadroHabilidad(image = "boton_defensa.png")
		const curarse = new CuadroHabilidad(image = "boton_curarse.png")
		const mover = new CuadroHabilidad(image = "boton_moverse.png")
		
		//los posiciono dentro de mi marco
		ataque.position(game.at(4,1))
		defensa.position(game.at(7,1))
		curarse.position(game.at(11,1))
		mover.position(game.at(14,1))
		
		
		//agrego los botones
		game.addVisual(ataque)
		game.addVisual(defensa)
		game.addVisual(curarse)
		game.addVisual(mover)
				
		
	}
}


//objeto que va a tener el cuadro con opciones
class CuadroTexto{
	var property position = new Position()
	var property image = "cuadro.png"
	

}

class CuadroHabilidad inherits CuadroTexto{
	
	
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

object escudo{
	method defender(){}
	method curarse(){}
}

object espada{
	method atacar(){}
}

//continuar aca
object keyboardConfig{
	var property free = false //en false tengo habilitado el menu de juego, en true el movimientod el personaje
	
	method empezar()
	{
		if (not free){
			keyboard.num4().onPressDo{self.liberarHeroe()}
			keyboard.num3().onPressDo{escudo.curarse()}
			keyboard.num2().onPressDo{escudo.defender()}
			keyboard.num1().onPressDo{espada.atacar()}
			game.say(heroe, "kill niggers")
		}
		
	}
	
	//checkear como bloquear el menu y habilitar el movimiento del personaje
	method liberarHeroe()
	{
		
		
	}
}
