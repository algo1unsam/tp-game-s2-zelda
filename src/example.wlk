class Personaje{
	var vida = 100
	var vivo = true
	
	method morir(){
		vivo = false
	}
}

object wollink inherits Personaje{
	const property inventario = #{}
	//method imagen() = 
	
	method recoleccion(){
		inventario.add()
	}
}

object jefe inherits Personaje{
	//method imagen() = 
	
}

object npc{
	//method imagen()
	method interactuar(){
		return 'Hola'
	}
}