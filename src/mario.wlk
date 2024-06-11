import wollok.game.*

object mario {
	var property position=game.at(0,1)
	
	method image(){
		return "assets/personajes/mario/21.png"}
	
	
	method inicioMario(){
		
		
		keyboard.right().onPressDo{
			self.moverDerecha()
		}
		keyboard.left().onPressDo{
			self.moverIzquierda()		
		}
		keyboard.up().onPressDo{
			self.moverArriba()
		}
		keyboard.down().onPressDo{
			self.moverAbajo()
		}
}
	method moverDerecha(){
		const ancho = game.width()
		position = game.at(if(position.x()+1<ancho)position.x()+1 else position.x() ,position.y())
	
	}

	method moverIzquierda(){
		position = game.at(if(position.x()-1>=0)position.x()-1 else position.x() ,position.y())
	}
	
	method moverArriba(){
		const alto = game.height()
		position = game.at(position.x(),if(position.y()+1<alto)position.y()+1 else position.y())
	}

	method moverAbajo(){
		position = game.at(position.x(),if(position.y()-1>=0)position.y()-1 else position.y())
	}

	

}







