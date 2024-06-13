import wollok.game.*
import mario.*
import kong.*
import pauline.*
import escenarios.*
import sonido.*
import barriles.*

object juego{
	// solo pruebo los barriles-----------------------
	method tirarBarril(){
		const barril1 = new Barril()
		game.addVisual(barril1)
		barril1.animacion()
		barril1.recorrerEscenario()
	}
	//---------------------------------------------
	method iniciar(){
	game.title("Donkey Kong (wollok Version)")
	game.addVisual(stage1)
	game.addVisual(elementoStage)
	game.addVisual(mazo)
	game.addVisual(pauline)
	game.addVisual(mario)
	mario.inicioMario() 
	game.addVisual(kong)
	kong.animacion()
	game.addVisual(barriles)
	pauline.animacion()
	game.schedule(2500,{self.tirarBarril()})
	
	musica.activarMusica()

	game.width(18)
	game.height(18)
	game.cellSize(50)

	game.start()
	}
}



