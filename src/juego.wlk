import wollok.game.*
import mario.*
import kong.*
import pauline.*
import escenarios.*
import sonido.*
import barriles.*

object juego{
	// solo pruebo los barriles-----------------------
	const b1 = new Barril()
	const b2 = new Barril()
	const b3 = new Barril()
	const b4 = new Barril()
	const b5 = new Barril()
	const b6 = new Barril()
	
	method tirarBarril(barril){		
		game.addVisual(barril)
		barril.animacion()
		barril.recorrerEscenario()
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
	game.schedule(2500,{self.tirarBarril(b1)})	
	game.schedule(7000,{self.tirarBarril(b2)})
	game.schedule(11500,{self.tirarBarril(b3)})
	game.schedule(16000,{self.tirarBarril(b4)})	
	game.schedule(20500,{self.tirarBarril(b5)})
	game.schedule(25000,{self.tirarBarril(b6)})
	musica.activarMusica()

	game.width(18)
	game.height(18)
	game.cellSize(50)

	game.start()
	}
}



