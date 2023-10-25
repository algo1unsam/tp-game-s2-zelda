import wollok.game.*
import zelda.*
import utiles.*

class Personaje{
	var property position = new Position()
	var property vida = 100
	var vivo = true
	var property poder = 100
	
	//inicia el personaje en el juego
	method iniciar(){ game.addVisual(self) }
	
	//validacion de si el personaje esta muerto
	method checkMuerto(){
		if (vida <= 0){self.morir()}
	}
	
	//la idea es usarlo para terminar el juego		
	method morir(){	vivo = false}
}

//El personaje que va a mover el jugador
object prota inherits Personaje(position = game.at(3,6)){
	var property inventario = #{}
	var property image =  "pj_abajo.png"
	var property dir = new Derecha()
	override method position() = position
	
	method mover(newPosition){self.position(newPosition)}
	
	//metodo para cambiar la direccion en la que apunta el personaje
	method mirar(direccion) {
		const prefijo = 'pj_'
		const sufijo = '.png'
		image = prefijo + direccion + sufijo	
	}
		
	//agarra el arma del piso y la suma a su inventario
	method encontrar(armas){
		game.whenCollideDo(armas,inventario.add(armas))
		game.removeVisual(armas)
	}
	
	method cambiarPosicion(x, y){position = game.at(x, y)}
	
	method recibirDanio(danio){
		vida-=danio
		console.println("wollink:"+vida.toString()) //Debug de la vida del personaje
		self.checkMuerto()
	}
	
	method atacar(){
		dir.atacar(poder)
		//agregamos el sprite del ataque al tablero
		game.addVisual(dir)
			//necesito una variable temporal que me almacene el visual del ataque, pq sino esta puede cambiar y romperme el codigo
		var temp = dir 
			//eliminamos el sprite del ataque
		game.schedule(50,{game.removeVisual(temp)})
	}
	
	override method morir(){
		super()
		muerte.morir("bromita.jpg") //recibe como parametro la imagen de "Game Over")
	}
}

//enemigo del combate final
object ganon inherits Personaje(position = game.origin()){
	var ataques = 10
	const property zona_ataque = [] //lsita con las posiciones donde va a atacar
	var fase_2 = true
	method atacar(){
		//llevo en una lista las zonas del mapa ocupadas por sus ataques
		zona_ataque.forEach{x=>self.removerCubo(x)}
		
		//quiero que atque en x lugares a la vez
		ataques.times{x =>self.crearCubo()}
		
		//despues de avisar la zona de peligro, esta hace daño
		game.schedule(800, {=>self.detonarCubo()})
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
	
	//el cubo luego de un rato le ahce daño al jugador
	method detonarCubo(){
		zona_ataque.forEach{x=>x.explotar()}
	}
	
	//desplazamiento del enemigo
	method moverse(){position=game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0))}
	
	//a mitad de vida va a asubir su ataque en un 30%
	method rugir(){poder += poder *0.30}
	
	// se cura una vez nada mas, 50%
	method curarse(){vida+=vida*0.5}
	
	//recibir daño me va  aservir para checkear la vida y fijarme que el cambio de fase
	method recibirDanio(danio){
		vida -= danio
		console.println("ganon:"+vida.toString()) //Debug para ver la vida
		self.moverse()
		self.checkMuerto()
		//en el cambio de fase se cura y se vuelve mas agresivo
		if (vida <= 45 and fase_2){self.cambioFase()}
	}
	
	//metodo que se activa en el cambio de fase
	method cambioFase(){
		self.curarse()
		self.rugir()
		//vamoas a incrementar la dificultad
		game.removeTickEvent("ganon moverse")
		game.onTick(3000,"ganon moverse rapido",{=>self.moverse()})
		ataques = 25
		fase_2=false
	}
	
	override method morir(){
		super()
		muerte.morir("bromita2.jpg")//Pasar la iamgen de "Ganaste!"
	}
}

object npc inherits Personaje(position = game.origin()){
	method image() = ""
}




