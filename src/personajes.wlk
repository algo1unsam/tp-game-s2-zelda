import wollok.game.*
import zelda.*

class Personaje{
	var property position = new Position()
	var property vida = 100
	var vivo = true
	var property poder = 5
	
	method iniciar(){ game.addVisual(self) }
	//la idea es usarlo para terminar el juego		
	method morir(){	
		vivo = false
		game.removeVisual(self)
	}
}


object prota inherits Personaje(position = game.at(3,6)){
	var property inventario = #{}
	var property image =  "pj_abajo.png"
	var property dir = new Derecha()
	override method position() = position
	
	method mover(newPosition){
		self.position(newPosition)
	}
	
	method mirar(direccion) {
		
		const prefijo = 'pj_'
		const sufijo = '.png'
		
		image = prefijo + direccion + sufijo	
	}
		

	


	method encontrar(armas){
		game.whenCollideDo(armas,inventario.add(armas))
		game.removeVisual(armas)
	}
	
	
	method cambiarPosicion(x, y){
		position = game.at(x, y)
	}
	
	method recibirDanio(danio){
		vida-=danio
		console.println(vida)
		game.say(self, "auchis")
		self.checkMuerto()
	}
	
	method checkMuerto(){
		if (vida <= 0){
			game.removeTickEvent("ganon moverse")
			game.removeTickEvent("ganon atacar")
			self.morir()
		}
	}

}

object ganon inherits Personaje(position = game.origin()){
	var ataques = 10
	const property zona_ataque = []
	method atacar()
	{
		//llevo en una lista las zonas del mapa ocupadas por sus ataques
		zona_ataque.forEach{x=>self.removerCubo(x)}
		
		//quiero que atque en x lugares a la vez
		ataques.times{x =>self.crearCubo()}
		
		//despues de avisar la zona de peligro, esta hace daño
		game.schedule(500, {=>self.detonarCubo()})
		
	}
	
	
	method image() = "jefe_1.png"	
	
	
	method crearCubo(){
		//le asigno una posicion aleatoria
		var cubo = new CuboRojo(position=game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0)))
		
		//lo agrego al mapa y a la lista con zonas de peligro
		game.addVisual(cubo)
		zona_ataque.add(cubo)
	}
	
	//metodo combinado que elimina a la zona de peligro del tablero y de la lista
	method removerCubo(cubo){
		game.removeVisual(cubo)
		zona_ataque.remove(cubo)
	}
	
	method detonarCubo(){
		zona_ataque.forEach{x=>x.explotar()}
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
		//en el cambio de fase se cura y se vuelve mas agresivo
		if (vida <= 25){
			self.curarse()
			self.rugir()
			game.removeTickEvent("ganon moverse")
			game.onTick(5000,"ganon moverse rapido",{=>self.moverse()})
			ataques = 20
		}
		
	}
	
	
	
}

object npc inherits Personaje(position = game.origin()){
	method image() = ""
}



//superclase que indica la direccion en la que miró el presonaje por ultima vez
class Direccion{
	method position(){
		return prota.position()
	}
	
	//hacemos daño si esta ganon
	method atacar(){
		game.getObjectsIn(self.position()).forEach{x=>x.recibirDanio(prota.poder())}
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
//		if game.colliders(self).contains(heroe){
//			heroe.recibirDanio(danio)
//		}
		//si recibe contacto recibe mucho daño
		game.onCollideDo(prota, {x=>prota.recibirDanio(1)})
		return image
	}
	
	method recibirDanio(_danio){}
	
	
}
