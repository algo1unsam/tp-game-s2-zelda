import wollok.game.*
import personajes.*

//Configuracion del teclado y del ataque en direccion que mira el personaje
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
	var vieja_position = prota.position()
	method position(){return prota.position()}
	
	//hacemos daño si esta ganon
	method atacar(poder){game.getObjectsIn(self.position()).forEach{x=>x.recibirDanio(poder)}}
	
	method vieja_posicion(){return vieja_position}
	//para evitar problemas si el personaje ataca muy rapido y se pisan las visuals
	method recibirDanio(_danio){}
}

class Arriba inherits Direccion{
	var property image = "golpe_arriba.png"
	override method position(){return prota.position().up(1)}
}

class Abajo inherits Direccion{
	var property image = "golpe_abajo.png"
	override method position(){return prota.position().down(1)}
}

class Izquierda inherits Direccion{
	var property image = "golpe_izquierda.png"
	override method position(){return prota.position().left(1)}
}

class Derecha inherits Direccion{
	var property image = "golpe_derecha.png"
	override method position(){return prota.position().right(1)}
}

//zonas rojas de peligro en el piso
class CuboRojo{
	var property position = 0
	var danio = ganon.poder()
	var property image = "rojo.jpg" //aca va la imagen de un cubo rojo
	
	//la imagen cambia y la zona esa ahora hace daño si tiene al heroe encima
	method explotar(){
		image="explosion.png" 
		//si el jugador se encuentra en el momento de la explosion recibe daño
		if (game.colliders(self).contains(prota)){
			prota.recibirDanio(danio)
		}
		return image
	}
	//metodo vacio por si el jugador le pega al cuboRojo o al fuego, no me explote el juego
	method recibirDanio(_danio){}
	method colision(){}
}

//Objeto que me termian el juego cuando uno de los personajes se muere
object muerte{
	var property position = game.at(1,1)
	var property image 
	
	//cuando un personaje muere se invoca la pantalla de fin de juego, se pasa como parametro el asset
	method morir(imagen){
		game.clear()
		image=imagen
		game.addVisual(self)
	}
}


//Colisiones

class ParedInvisible{
	var property position
	
	method colision(){prota.position(prota.dir().vieja_posicion())}
	
	//metodo vacio
	method recibirDanio(algo){}
}


object distribucion{
	method aldea(){
		const matriz=[
			[0,11], [1,11], [2,11], [3,11], [4,11], [5,11], [6,11], [7,11], [8,11], [9,11], [10,11], [11,11], [12,11], [13,11], [14,11], [15,11], [16,11], [17,11], [18,10], [19,10],
			[0,5], [1,5], [0,2], [0,3], [1,0], [1,1], [1,8], [2,8], [2,9], [3,9],[1,9], [5,8],[6,8],[5,9],[6,9],[11,8],[12,8],[14,8],[15,8],[11,9],[12,9],[14,9],[15,9]
		]
		
		self.agregarPared(matriz)
	}
	method bosque(){}
	method mapa(){}
	
	method agregarPared(matriz){
		matriz.forEach{l=>
			var pared = new ParedInvisible(position=game.at(l.get(0),l.get(1)))
			game.addVisual(pared)
		}
	}
}
