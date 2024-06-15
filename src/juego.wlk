import wollok.game.*
import mario.*
import kong.*
import pauline.*
import escenarios.*
import sonido.*
import barriles.*

object juego{
	const b1 = new Barril()
	const b2 = new Barril()
	const b3 = new Barril()
	const b4 = new Barril()
	const b5 = new Barril()
	const b6 = new Barril()
	const b7 = new Barril()
	const barriles1 = [b1,b2,b3,b4,b5,b6,b7]
	var nro=0
	var nroBarril = barriles1.first()
	
	method siguienteBarril(){
		nro = (nro+1) % barriles1.size()
		nroBarril = barriles1.get(nro)
	}
	
	method tirarBarril(){
		try {
			game.addVisual(nroBarril)
			nroBarril.animacion()
			nroBarril.recorrerEscenario()
			game.whenCollideDo(mario,{elemento=>elemento.colisionadoPor(mario)})
			//game.whenCollideDo(nroBarril,{personaje=>personaje.esChocadoPor(nroBarril)})
		} catch e : Exception {
  			nroBarril.removerBarril()
  			game.addVisual(nroBarril)
			nroBarril.animacion()
			nroBarril.recorrerEscenario()
		}
		//game.addVisual(nroBarril)
		//nroBarril.animacion()
		//nroBarril.recorrerEscenario()
		//game.whenCollideDo(mario,{elemento=>elemento.colisionadoPor(mario)})
		//game.whenCollideDo(nroBarril,{personaje=>personaje.esChocadoPor(nroBarril)})
	}
	
	method tirarBarriles(){self.tirarBarril() self.siguienteBarril()}
	////metodo viejo
	/*method tirarBarril(barril){							
		game.addVisual(barril)
		barril.animacion()
		barril.recorrerEscenario()
		game.whenCollideDo(mario,{elemento=>elemento.colisionadoPor(mario)})
		game.whenCollideDo(barril,{personaje=>personaje.esChocadoPor(barril)})
	}*/
	
	 
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
	//pauline.animacion()
	game.onTick(4575,"lanzamientoDeBarriles",{self.tirarBarriles()})
	musica.activarMusicaInicial()
	musica.activarMusica()
	game.width(18)
	game.height(18)
	game.cellSize(50)

	game.start()
	}
}



