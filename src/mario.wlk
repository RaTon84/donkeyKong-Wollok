import wollok.game.*
import animacion.*
import escenarios.*
import sonido.*

object mario {
	const velocidad=200
	var property position=game.at(0,1)
	method image()= animacionMario.image()
	
		//KEYBOARD
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
		keyboard.space().onPressDo{
			self.saltar()
		}
}		
		//MOVIMIENTO
	method moverDerecha(){
		self.moverDerechaSiSePuede()
		sonidoMario.deMovimiento()
		animacionMario.animarDerecha()
	}

	method moverIzquierda(){
		self.moverIzquierdaSiSePuede()
		sonidoMario.deMovimiento()
		animacionMario.animarIzquierda()
	}
	
	method moverArriba(){
		self.moverArribaSiSePuede()
		animacionMario.animarArriba()
	}

	method moverAbajo(){
		self.moverAbajoSiSePuede()
		animacionMario.animarAbajo()
	}
	
	method caidaSalto(){
		// este metodo hace la animacion del salto															//hay que ordenar 
		position = game.at(position.x(),if(position.y()-1>=0)position.y()-1 else position.y())				//A revisar:tiene saltos infinitos
		animacionMario.direccion("caidaSalto")
		animacionMario.siguienteFotograma()
	}	
	
	method saltar(){
		self.moverArribaSinCondicion()																		//hay que ordenar
		game.schedule(velocidad*3,{self.caidaSalto()})														//A revisar:tiene saltos infinitos
		animacionMario.direccion("salto")
		animacionMario.siguienteFotograma()																	  
		sonidoMario.deSalto()
	}
	


	
	//OBTIENE POSITION CON Y +- 1
	
	method obtenerPosicionDeYMenos1()= game.at(position.x(),position.y()-1)
	
	method obtenerPosicionDeYMas1()= game.at(position.x(),position.y()+1)
	
	
	
	//MUEVE DIRECCION SI SE PUEDE
	
	method moverArribaSiSePuede(){
		const alto = game.height()
		position = game.at(position.x(),if(position.y()+1<alto and stage1.hayEscaleraArriba())position.y()+1 else position.y())
	}
	
	method moverArribaSinCondicion(){
		const alto = game.height()
		position = game.at(position.x(),if(position.y()+1<alto)position.y()+1 else position.y())
	}
	
	method moverAbajoSiSePuede(){
		position = game.at(position.x(),if(position.y()-1>=0 and not stage1.hayVigaDebajo())position.y()-1 else position.y())
	}
	
	method moverDerechaSiSePuede(){
		const ancho = game.width()
		position = game.at(if(position.x()+1<ancho)position.x()+1 else position.x() ,position.y())
	}
	
	method moverIzquierdaSiSePuede(){
		position = game.at(if(position.x()-1>=0)position.x()-1 else position.x() ,position.y())
	}
	



}



