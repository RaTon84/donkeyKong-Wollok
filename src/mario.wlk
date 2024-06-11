import wollok.game.*
import juego.*
const velocidad = 50
object mario {
	var vivo = true
	var property position=game.at(0,1)
	method image()="assets/personajes/mario/21.png"
		
	method iniciarMario(){
		keyboard.space().onPressDo{self.saltar()}
		//keyboard.down().onPressDo{self.bajar()}
		keyboard.right().onPressDo{self.moverALaDerecha()}
		keyboard.left().onPressDo{self.moverALaIzquierda()}
	}
	
	method subir() {
    	position = position.up(1) 
  	}
	  method bajar(){
	  	position = position.down(1) 
	 }
	  method moverALaDerecha(){
	  	position = position.right(1) 
	  }
	  method moverALaIzquierda(){
	  	position = position.left(1) 
	  }
	  method saltar(){
			self.subir()
			game.schedule(velocidad*2,{self.bajar()})
		}
	}

	
	
	
	  
