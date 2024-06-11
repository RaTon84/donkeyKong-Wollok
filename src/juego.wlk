import wollok.game.*
import mario.*
import kong.*
import pauline.*
import escenarios.*

object juego{
	method iniciar(){
	game.title("Donkey Kong (wollok Version)")
	game.addVisual(stage1)
	game.addVisual(kong)
	game.addVisual(pauline)
	game.addVisual(mario)

	game.width(18)
	game.height(18)
	game.cellSize(50)

	mario.inicioMario()
	game.start()
	}
}




