import wollok.game.*
import zelda.*
import objetos.*

class Batalla{
	const _heroe = prota
	const enemigo = ganon
	
	method iniciar(){
		//seteo el campo de batalla
		
		
		//posiciono a los personajes
		_heroe.position(_heroe.position().left(1))
		enemigo.position(enemigo.position().right(3))
		
		//los agrego a mi tablero
		game.addVisual(_heroe)
		game.addVisual(enemigo)
		
		//activo onticks
		game.onTick(8000,"ganon moverse",{=>ganon.moverse()})
		game.onTick(2000,"ganon atacar",{=>ganon.atacar()})		
	}
}





//Para debugear mi codigo necesito dos personajes genericos
object heroe{
	var property position = game.center()
	var property vida = 100
	
	method image() = "pj_derecha.png"
	
	
	method recibirDanio(danio){
		vida-=danio
		console.println(vida)
		game.say(self, "auchis")
		self.checkMuerto()
	}
	
	//checkeo si la vida es menor o igual a 0
	method checkMuerto(){
		if (vida <= 0){
			self.gameOver()
		}
	}
	
	//pantalla de game over
	method gameOver(){
		game.clear()
		game.removeTickEvent("ganon moverse")
		game.removeTickEvent("ganon atacar")

		
	}
	
	
}



object ganon{
	var property position = game.center()
	var property poder = 5
	var property vida
	var ataques = 20
	const property zona_ataque = []
	
	method image() = "jefe_1.png"
	
	
	//el ataque de ganon va a ser cuadrados alaeatorios en el mapa que despues de un tiempo hacen daño
	method atacar()
	{
		//llevo en una lista las zonas del mapa ocupadas por sus ataques
		zona_ataque.forEach{x=>self.removerCubo(x)}
		
		//quiero que atque en x lugares a la vez
		ataques.times{x =>self.crearCubo()}
		
		//despues de avisar la zona de peligro, esta hace daño
		game.schedule(500, {=>self.detonarCubo()})
		
	}
	
	//creo una zona de peligro en el mapa
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


//zonas rojas de peligro en el piso
class CuboRojo{
	var property position = 0
	var danio = ganon.poder()
	
	var property image = "rojo.jpg" //aca va la imagen de un cubo rojo
	
	
	//la imagen cambia y la zona esa ahora hace daño si tiene al heroe encima
	method explotar(){
		image="explosion.png" //aca va la imagen de una explosion/fuego
		if game.colliders(self).contains(heroe){
			heroe.recibirDanio(danio)
		}
		//si recibe contacto recibe mucho daño
		game.onCollideDo(heroe, {x=>heroe.recibirDanio(1)})
		return image
	}
	
	
}






