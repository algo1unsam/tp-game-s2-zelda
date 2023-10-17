import wollok.game.*

class Escudo {
	var property proteccion = 0
}

class Espada {
	var property poder = 0
}

const escudo = new Escudo(proteccion=10)

const espada = new Espada(poder=10)

class EscudoEncantado inherits Escudo(proteccion=30) {

	const property encantamiento = true
		
}

const escudoMaestro = new EscudoEncantado()

class EspadaMaestra inherits Espada(poder=30) {
	const property encantamiento = true	
}

const espadaMaestra = new EspadaMaestra()

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