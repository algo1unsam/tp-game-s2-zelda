import wollok.game.*
import personajes.*


object escudo{
	const proteccion = 30
	const property position = game.at(9,9)
	method colision(){}
	method image() {
		return "escudo.png"
	}
	method comprueboPosicionWollink(){
		return self.position() == prota.position()
	}
	method aparecer(){
		game.addVisual(self)
		game.onTick(150, "escudo", { if (escudo.comprueboPosicionWollink()) escudo.agarrarEscudo()})
	}
	method agarrarEscudo(){
		game.removeVisual(self)
		game.removeTickEvent("escudo")
		prota.inventario().add(self)// Llamar acá al método para que Wollink tenga el escudo
		prota.vida(prota.vida()+proteccion)
	}
}

class Espada {
	var property poder = 10
	var property position
	method image() = "espada.png"
	
	method colision(){self.recogerEspada()}
	
	method recogerEspada(){
		prota.inventario().add(self)
		prota.poder(prota.poder()+poder)
		game.removeVisual(self)
	}
	
	method aparecer(){
		if(not prota.inventario().contains(self))
		game.addVisual(self)
	}
	
	method desaparecer(){
		if (game.allVisuals().contains(self)){
			game.removeVisual(self)
		}
	}
	
	method recibirDanio(danio){}
}


object espadaMaestra inherits Espada(poder=10,position=game.at(9,6)) {
	
	override method image() = "espada_maestra.png"
	
}

