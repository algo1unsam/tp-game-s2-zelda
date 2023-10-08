import wollok.game.*

object wollink{
	var vida = 100
	var vivo = true
	var inventario = #{}
	//lo que estaba como objeto prota ahora esta aca
	var property position = game.at(3,6)
		
	method iniciar(){
		game.addVisual(self)
	}
	
	method mover(newPosition){
		self.position(newPosition)
	}
	
	method recolectar(){
		
	}
	
	method morir(){
		vivo = false
	}
	method image() = "pj_abajo.png"
	
}