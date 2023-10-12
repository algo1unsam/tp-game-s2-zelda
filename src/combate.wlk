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
		
		//activo onticks
		game.onTick(10000,"ganon moverse",{=>ganon.moverse()})
		game.onTick(2000,"ganon atacar",{=>ganon.atacar()})
		
//		//agrego mi cuadro de habilidades
//		const root = new CuadroTexto()
//		root.position(game.at(3,0))
//		game.addVisual(root)
//		
//		
//		//agrego las habilidades--se puede hacer con una lista
//		const ataque = new CuadroHabilidad(image = "boton_ataque.png")
//		const defensa = new CuadroHabilidad(image = "boton_defensa.png")
//		const curarse = new CuadroHabilidad(image = "boton_curarse.png")
//		const mover = new CuadroHabilidad(image = "boton_moverse.png")
//		
//		//los posiciono dentro de mi marco
//		ataque.position(game.at(4,1))
//		defensa.position(game.at(7,1))
//		curarse.position(game.at(11,1))
//		mover.position(game.at(14,1))
//		
		
		//agrego los botones
//		game.addVisual(ataque)
//		game.addVisual(defensa)
//		game.addVisual(curarse)
//		game.addVisual(mover)
		
	}
}


//objeto que va a tener el cuadro con opciones
//class CuadroTexto{
//	var property position = new Position()
//	var property image = "cuadro.png"
//	
//
//}
//
//class CuadroHabilidad inherits CuadroTexto{
//	
//	
//}

class ObjetoInvisible{
	var position = new Position()
	var property image
	
}





//continuar aca
object keyboardConfig{
	//var property free = true //me habilita a hacer mis turnos
	
	method empezar()
	{
//			keyboard.num4().onPressDo{arco.atacar()}
//			keyboard.num3().onPressDo{escudo.curarse()}
//			keyboard.num2().onPressDo{escudo.defender()}
//			keyboard.num1().onPressDo{espada.atacar()}
			keyboard.up().onPressDo{heroe.position(heroe.position().up(1))}
			keyboard.down().onPressDo{heroe.position(heroe.position().down(1))}
			keyboard.right().onPressDo{heroe.position(heroe.position().right(1))}
			keyboard.left().onPressDo{heroe.position(heroe.position().left(1))}
//			keyboard.enter().onPressDo{asignarTurno.turnoGanon()}
	}

//no se pude desactivar el teclado? las teclas se superponen//probar con delay para habilidades(problema con acumular habilidades//
	
//	method desactivarTeclado(){
//			game.schedule(1000, {=>self.empezar()})
//			keyboard.num4().onPressDo{heroe.position(heroe.position().down(1))}
//			keyboard.num3().onPressDo{heroe.position(heroe.position().down(1))}
//			keyboard.num2().onPressDo{heroe.position(heroe.position().down(1))}
//			keyboard.num1().onPressDo{heroe.position(heroe.position().down(1))}
//			keyboard.up().onPressDo{heroe.position(heroe.position().down(1))}
//			keyboard.down().onPressDo{heroe.position(heroe.position().down(1))}
//			keyboard.right().onPressDo{heroe.position(heroe.position().down(1))}
//			keyboard.left().onPressDo{heroe.position(heroe.position().down(1))}
//			keyboard.enter().onPressDo{heroe.position(heroe.position().down(1))}
//			
//	}
	
//	method nada(){
//		heroe.position(heroe.position())
//	}
}


//object asignarTurno {
//	
//	method turnoHeroe()
//	{
////		keyboardConfig.empezar()
//	}
//	
//	method turnoGanon()
//	{
////		keyboardConfig.desactivarTeclado()
//		ganon.atacar()
//	}
//}



//Para debugear mi codigo necesito dos personajes genericos
object heroe{
	var property position = game.center()
	
	method image() = "pj_derecha.png"
	
	
	
}

object ganon{
	var property position = game.center()
	var property poder
	var property vida
	
	method image() = "jefe_1.png"
	
	
	method atacar()
	{
		5.times({=> self.crearCubo()})
	}
	
	method crearCubo(){
		return new CuboRojo()
	}
	
	//desplazamiento del enemigo
	method moverse(){
		position=game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0))
	}
	
	//a mitad de vida va a asubir su ataque en un 25%
	method rugir(){
		poder += poder *0.25
	}
	
	// se cura una vez nada mas, 50%
	method curarse(){
	}
	
	//recibir daño me va  aservir para checkear la vida y fijarme que el cambio de fase
	method recibirDanio(danio){
		vida -= danio
		if (vida <= 25){
			self.curarse()
			self.rugir()
			game.removeTickEvent("ganon moverse")
			game.onTick(5000,"ganon moverse rapido",{=>self.moverse()})
		}
		
	}
}


class CuboRojo{
	var property position = 0
	
	var property image = "nada.jpg"
	
	
}



object escudo{
	method defender(){}
	method curarse(){}
}

object espada{
	method atacar(){}
}

object arco{
	method atacar(){}
}
