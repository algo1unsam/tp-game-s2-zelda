import wollok.game.*
import personajes.*

class Escudo {
	var property proteccion = 0
}	

class Espada {
	var property poder = 0
	var property position
	method image() = "espada.png"
	
	method colision(){self.recogerEspada()}
	
	method recogerEspada(){
		prota.inventario().add(self)
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
}

class EscudoEncantado inherits Escudo(proteccion=30) {

	const property encantamiento = true
		
}

const escudoMaestro = new EscudoEncantado()

object espadaMaestra inherits Espada(poder=30,position=game.at(9,6)) {
	const property encantamiento = true	
	
	override method image() = "espada_maestra.png"
	

	
}


object personaje {
	
	var property poder = 10
	var property vida = 100
	var property proteccion = 10
	const elementos = #{}
	//const piezasArco = []
	
	//method armarArco(pieza){
		
	//	piezasArco.add(pieza)
	//	self.terminarArco()
		
	//}
	
	//method terminarArco() {
		
	//	if (piezasArco.size()==3) self.encontrar(arco)
		
	//}
	
	method encontrar(armamento) {
		
		elementos.add(armamento)
		self.cargarPoder(armamento)
		self.cargarProteccion(armamento)
	}
	
	method cargarPoder(armamento) {
		
		poder += armamento.poder()
		
	}
	
	method cargarProteccion(armamento) {
		
		proteccion += armamento.proteccion()
		
		
	}
}