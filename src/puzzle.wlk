import wollok.game.*
import zelda.*
import personajes.*
object puzzle{
	method iniciar(){
		game.removeVisual(prota)
		game.addVisual(boton1)
  		game.addVisual(boton2)
  		game.addVisual(boton3)
  		game.addVisual(boton4)
 		game.addVisual(cofre)
		game.addVisual(prota)

		game.onTick(150, "boton1", { if (boton1.estaApretado()) boton1.apretarBoton()})
		game.onTick(150, "boton2", { if (boton2.estaApretado()) boton2.apretarBoton()})
		game.onTick(150, "boton3", { if (boton3.estaApretado()) boton3.apretarBoton()})
		game.onTick(150, "boton4", { if (boton4.estaApretado()) boton4.apretarBoton()})
	}
}
//object prota{
//	var property position = game.origin()
//	method image() = "pj_abajo.png"
	
//}

class Botones{
	var property position
	var apretado = false
	method estaApretado(){
		return self.position() == prota.position()
	}
	method soltarBoton() {apretado = false}
	method image(){
		return if (apretado or self.position() == prota.position())
		{
			"boton_apretado.png"
		}
		else "boton.png"
	}


//Agrega el boton que aprieto a la lista (sólo si no esta apretado)
//Si es el correcto, cambia el estado a "apretado".
//Si es incorrecto, borro la lista de botones apretados para que todos se puedan apretar de vuelta	
	method apretarBoton(){
		if (not apretado){	
			cofre.agregarBoton(self)
			if (self.validarOrden())
				{apretado = true}
			else {cofre.borrarBotones()}
		}
		
	}
	
	
//Devuelve verdadero si el boton que estoy apretando es el correcto
	method validarOrden(){
		if (cofre.orden() == cofre.apretados()){
			mapa.resolverPuzzle()
			game.removeTickEvent("boton1")
			game.removeTickEvent("boton2")
			game.removeTickEvent("boton3")
			game.removeTickEvent("boton4")
		}
		return self == cofre.orden().get(cofre.apretados().size()-1)
	} 	
}

object cofre{
	const property position = game.at (9,8)
//Lista del orden correcto
	const property orden = [boton1, boton2, boton3,boton4]
//Lista a la que se agregan los botones que voy apretando
	const property apretados = []
	var abierto = false
	method image(){
		return if (self.orden() == self.apretados())
		{
			"cofre_abierto.png"
		}
		else "cofre.png"
	}
	method agregarBoton (boton){
		apretados.add(boton)
	}
	method borrarBotones()
	{	
		apretados.clear()
		orden.forEach{boton => boton.soltarBoton()}
	}
	
}


object mapaPuzzle {
//eliminar botones y cofre
	method eliminarVisualesMontania(){
		game.removeVisual(boton1)
		game.removeVisual(boton2)
		game.removeVisual(boton3)
		game.removeVisual(boton4)
		game.removeVisual(cofre)
	}
}
const boton3 = new Botones(position = game.at(6,6))
const boton1 = new Botones(position = game.at(12,6))
const boton2 = new Botones(position = game.at(6,9))
const boton4 = new Botones(position = game.at(12,9))
