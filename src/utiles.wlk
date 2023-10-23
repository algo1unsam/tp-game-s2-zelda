import wollok.game.*
import personajes.*

object config {
	
	
		method configurarTeclas() {
		keyboard.left().onPressDo({ self.teclaIzquierda()})
		keyboard.right().onPressDo({ self.teclaDerecha() })
		keyboard.up().onPressDo({ self.teclaArriba() })
		keyboard.down().onPressDo({ self.teclaAbajo() })
		keyboard.s().onPressDo({self.atacar()})
		}
		
		method teclaIzquierda(){
			prota.dir(new Izquierda())
			prota.mover(prota.position().left(1))
			prota.mirar('izquierda')
		}
		method teclaDerecha(){
			prota.dir(new Derecha())
			prota.mover(prota.position().right(1))
			prota.mirar('derecha')
		}
		method teclaArriba(){
			prota.dir(new Arriba())
			prota.mover(prota.position().up(1))
			prota.mirar('arriba')
		}
		method teclaAbajo(){
			prota.dir(new Abajo())
			prota.mover(prota.position().down(1))
			prota.mirar('abajo')
		}

		
		
		method atacar(){
			//hacemos dañio la celda correspondiente
			prota.atacar()
			
		}
}






//superclase que indica la direccion en la que miró el presonaje por ultima vez
class Direccion{
	method position(){
		return prota.position()
	}
	
	//hacemos daño si esta ganon
	method atacar(poder){
		game.getObjectsIn(self.position()).forEach{x=>x.recibirDanio(poder)}
	}
	
	method recibirDanio(_danio){}
	
}

class Arriba inherits Direccion{
	var property image = "golpe_arriba.png"
	override method position(){
		return prota.position().up(1)
	}
}

class Abajo inherits Direccion{
	var property image = "golpe_abajo.png"
	override method position(){
		return prota.position().down(1)
	}
}

class Izquierda inherits Direccion{
	var property image = "golpe_izquierda.png"
	override method position(){
		return prota.position().left(1)
	}
}

class Derecha inherits Direccion{
	var property image = "golpe_derecha.png"
	override method position(){
		return prota.position().right(1)
	}

}



//zonas rojas de peligro en el piso
class CuboRojo{
	var property position = 0
	var danio = ganon.poder()
	
	var property image = "rojo.jpg" //aca va la imagen de un cubo rojo
	
	
	//la imagen cambia y la zona esa ahora hace daño si tiene al heroe encima
	method explotar(){
		image="explosion.png" //aca va la imagen de una explosion/fuego
		if game.colliders(self).contains(prota){
			prota.recibirDanio(danio)
		}
		//si recibe contacto recibe mucho daño
//		game.onCollideDo(prota, {x=>prota.recibirDanio(1)}) Esto me realintiza el juego
		return image
	}
	

	
	method recibirDanio(_danio){}
	
	
}






