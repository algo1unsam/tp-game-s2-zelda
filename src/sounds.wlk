import wollok.game.*

object sonidos {
	
	var property sound = "inicio.wav"
	
	method sound(nombre) {sound = nombre
		game.sound(nombre).play()
	}
	
	method play(){
			game.sound(sound).play()
	}
	
	method pause(){
			game.sound(sound).pause()
		
		
	}
}


