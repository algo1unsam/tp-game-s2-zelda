import wollok.game.*
import zelda.*

class Personaje{
	var property position
	var property vida = 100
	var vivo = true
	
	method iniciar(){ game.addVisual(self) }
	//la idea es usarlo para terminar el juego		
	method morir(){	
		vivo = false
		game.removeVisual(self)
	}
}
object wollink inherits Personaje(position = game.at(3,6)){
	var property inventario = #{}
	
	override method position() = position
	
	method mover(newPosition){
		self.position(newPosition)
	}
		

	/*method noArriba(){
		game.onCollideDo(bloques,keyboard.up().onPressDo{self.mover(self.position().down(1))})
	}
	
	method noAbajo(){
		game.onCollideDo(bloques,keyboard.down().onPressDo{self.mover(self.position().up(1))})
	}
	
	method noDerecha(){
		game.onCollideDo(bloques,keyboard.right().onPressDo{self.mover(self.position().left(1))})
	}
	
	method noIzquierda(){
		game.onCollideDo(bloques, keyboard.left().onPressDo{self.mover(self.position().right(1))})
	}*/

	method encontrar(armas){
		game.whenCollideDo(armas,inventario.add(armas))
		game.removeVisual(armas)
	}
	
	
	method atacar(){}
	
	method image() = "pj_abajo.png"
}

object jefe inherits Personaje(position = game.origin()){
	
	method atacar(){}
	
	method image() = "jefe_1.png"	
}

object npc inherits Personaje(position = game.origin()){
	method image() = ""
}
