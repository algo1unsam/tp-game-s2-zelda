import wollok.game.*
import zelda.*
import utiles.*
import objetos.*
import sonidos.*

class Personaje{
	var property position = new Position()
	var property vida 
	var vivo = true
	var property poder 
	
	//inicia el personaje en el juego
	method iniciar(){ game.addVisual(self) }
	
	//validacion de si el personaje esta muerto
	method checkMuerto(){
		if (vida <= 0){self.morir()
		}
	}
	
	//la idea es usarlo para terminar el juego		
	method morir(){	vivo = false}
}

//El personaje que va a mover el jugador
object prota inherits Personaje(position = game.at(6,6), vida=20, poder=5){
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
			
	method cambiarPosicion(x, y){position = game.at(x, y)}
	
	method recibirDanio(danio){
		vida-=danio
		console.println("wollink:"+vida.toString()) //Debug de la vida del personaje
		self.checkMuerto()
		Corazoncitos.chequeoVida(vida)
		sonidos.sound("danioZelda.wav")
		sonidos.play()
	}
	
	method atacar(){
		sonidos.sound("espada.wav")
		sonidos.play()
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
		sonidos.sound("death.wav")
		sonidos.play()
		muerte.morir("perdiste.png") //recibe como parametro la imagen de "Game Over")
	}
}

//enemigo del combate final
object ganon inherits Personaje(position = game.origin(), vida=120, poder=5){
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
	
	method image() = "ganon.png"	
	
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
	method curarse(){vida+=vida*0.6}
	
	//recibir daño me va  aservir para checkear la vida y fijarme que el cambio de fase
	method recibirDanio(danio){
		vida -= danio
		console.println("ganon:"+vida.toString()) //Debug para ver la vida
		self.moverse()
		self.checkMuerto()
		sonidos.sound("danioGanon.wav")
		sonidos.play()
		//en el cambio de fase se cura y se vuelve mas agresivo
		if (vida <= 50 and fase_2){self.cambioFase()}
	}
	
	//metodo que se activa en el cambio de fase
	method cambioFase(){
		self.curarse()
		self.rugir()
		sonidos.sound("rugido.mp3")
		sonidos.play()
		//vamoas a incrementar la dificultad
		game.removeTickEvent("ganon moverse")
		game.onTick(3000,"ganon moverse rapido",{=>self.moverse()})
		ataques = 25
		fase_2=false
	}
	
	override method morir(){
		super()
		juegoGanado.play()
		muerte.morir("ganaste.png")//Pasar la iamgen de "Ganaste!"
	}
	
	method colision(){
		prota.recibirDanio(poder)
		self.moverse()
	}
}

//la princesa aparece al principio pidiendo que la rescatemos
object princesa inherits Personaje(position = game.at(17,7), vida=1, poder=1){
	method image() = "zelda_2.png"
	
	//evento de aparcion de la princesa (me da la espada de madera)
	method evento(){
		game.addVisual(self)
		game.schedule(1000,{game.say(self,"Wollink! estoy atrapada en el castillo!")})
		game.schedule(2000,{game.say(self,"Necesito que me salves!")})
		game.schedule(3000,{game.say(self,"Vas a necesitar equipo")})
		game.schedule(4000,{game.say(self,"Tomá esta espada...")})
		game.schedule(50000,{game.say(self,"Y vení a salvarme!")})
		game.schedule(10000,{self.remover()})		
	}
	
	//la princesa desaparece pero queda la espada
	method remover(){
		game.removeVisual(self)
		var espada = (new Espada(position=self.position()))
		espada.aparecer()
	}
	method colision(){}
	method recibirDanio(danio){}
}




