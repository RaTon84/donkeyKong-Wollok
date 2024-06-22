import wollok.game.*
import juego.*

class Pantalla{
	var fotogramaActual=0
	
	method position(){
		return game.at(0,0)}
	
	method siguienteFotograma(){		
			if(fotogramaActual == 1)
				fotogramaActual = fotogramaActual - 1
			else 
				fotogramaActual = fotogramaActual + 1}
	method image()		
}

object pantallaInicio inherits Pantalla{
	override method image()= "assets/pantallaInicio/pantallaInicio"+"-"+fotogramaActual.toString()+".png"
}

object pantallaControles inherits Pantalla{
	override method image()= "assets/pantallaInicio/controles"+"-"+fotogramaActual.toString()+".png"
}

object pantallaGameOver inherits Pantalla{
	override method image()="assets/pantallaInicio/gameOver"+"-"+fotogramaActual.toString()+".png"
}

object pantallaInicioStage1 inherits Pantalla{
	override method image()="assets/pantallaInicio/inicioStage1.png"
}

object pantallaInicioStage2 inherits Pantalla{
	override method image()="assets/pantallaInicio/inicioStage2.png"
}

object pantallaYouWin inherits Pantalla{
	override method image()="assets/pantallaInicio/youWin.png"
}


object gameOver {
	method marioPierde(){
		game.clear()
		game.sound("assets/sonidos/muerte.wav").play()
		game.addVisual(pantallaGameOver)
		game.onTick(1000,"cambio imagen muerte",{pantallaGameOver.siguienteFotograma()})
		keyboard.r().onPressDo{
			game.clear()
			juego.inicio()}}
}

object youWin {
	method marioGana(){
		game.clear()
		//game.sound("assets/sonidos/").play()        //AGREGAR SONIDO VICTORIA
		game.addVisual(pantallaYouWin)
		game.schedule(6000,{
			game.stop()})
	}
}

