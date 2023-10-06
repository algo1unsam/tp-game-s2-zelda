import wollok.game.*
object juego{
	method iniciar(){
		 game.onTick(250, "boton1", { if (boton1.estaApretado()) boton1.apretarBoton()})
		 game.onTick(250, "boton2", { if (boton2.estaApretado()) boton2.apretarBoton()})
		 game.onTick(250, "boton3", { if (boton3.estaApretado()) boton3.apretarBoton()})
	}
}
object wollink{
	var property position = game.origin()
	method image() = "pj_abajo.png"
	
}

class Botones{
	var property position
	var apretado = false
	method estaApretado(){
		return self.position() == wollink.position()
	}
	method soltarBoton() {apretado = false}
	method image(){
		return if (apretado or self.position() == wollink.position())
		{
			"boton_apretado.png"
		}
		else "boton.png"
	}
//Valido cada posición de la lista
	method primerBoton(){
		return self == cofre.orden().first()
	}
	method segundoBoton(){
		return self == cofre.orden().get(1)
	}
	method tercerBoton(){
		return self == cofre.orden().get(2)
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
		if (cofre.apretados().size() == 1) {return self.primerBoton()}
		else if (cofre.apretados().size() == 2) {return self.segundoBoton()}
		else {return self.tercerBoton()}
	} 	
}

object cofre{
	const property position = game.at (4,4)
//Lista del orden correcto
	const property orden = [boton1, boton2, boton3]
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

const boton1 = new Botones(position = game.at(2,2))
const boton2 = new Botones(position = game.at(4,2))
const boton3 = new Botones(position = game.at(6,2))
