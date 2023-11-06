import wollok.game.*


const musicaBatalla = game.sound("enemigo.mp3")

const juegoGanado = game.sound("juegoGanado.wav")

const pasos = game.sound("footstep2.wav")

const coleccionarAlgo = game.sound("collect3.wav")


object sonidos {
	var property sound = "inicio.wav"

	method sound(nombre) {sound = nombre}

	method play(){
			game.sound(sound).play()
	}

	method loop() {sound.shouldLoop(true)}

	
}