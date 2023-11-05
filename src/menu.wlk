import wollok.game.*
import personajes.*
import sounds.*


object menu{
	method iniciar(){
		game.onTick(400, "animacion", {menuAnimacion.pasarFrame()})
		game.onTick(2450, "musicaInicio", {sonidos.play()})
		keyboard.enter().onPressDo{menuAnimacion.enter()}
		game.addVisual(menuAnimacion)

	}
}
object menuAnimacion{
	var property position = game.origin()
	var property frame = 1
	method pasarFrame (){frame = ((frame+1) % 3)+1}
	method image() = "menu_" + frame.toString() + ".png"
	method enter(){
		game.removeTickEvent("animacion")
		game.removeVisual(self)
		game.removeTickEvent("musicaInicio")
		princesa.evento()
	}
	
}