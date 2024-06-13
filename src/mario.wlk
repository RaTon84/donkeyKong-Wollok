
import wollok.game.*
import animacion.*
import escenarios.*
import sonido.*
object mario {
	var vidas=2
	var puntos = 0
	const velocidad=100
	var property position=game.at(1,1)
	method image()= animacionMario.image()
	
	method juegoTerminado()= vidas==0

    method perderVida(){vidas=-1}

    method sumaPuntos(cantidad){puntos+=cantidad}
 
   	method eliminarBarril(){self.sumaPuntos(50)} 
	
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
	

	
	method saltar(){
			self.saltarSiSePuede()																									  
			sonidoMario.deSalto()
			
	
	}

	


	
	//OBTIENE POSITION CON Y +- 1
	
	method obtenerPosicionDeYMenos1()= game.at(position.x(),position.y()-1)
	
	method obtenerPosicionDeYMas1()= game.at(position.x(),position.y()+1)
	
	
	
	//MUEVE DIRECCION SI SE PUEDE
	
	method saltarSiSePuede(){
			if(self.validarSalto()){
			self.moverArribaSinCondicion()
			animacionMario.animarSalto()		 																
			game.schedule(velocidad*3,{self.caidaSalto()})	
		}
	}
		method caidaSalto(){
		// este metodo hace la animacion de caida del salto															
		position = game.at(position.x(),if(position.y()-1>=0)position.y()-1 else position.y())				
		animacionMario.direccion("caidaSalto")
		animacionMario.siguienteFotograma()
	}
		
	
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

		method validarSalto(){
			
		const posicionParaSaltar = [game.at(0,1),game.at(1,1),game.at(2,1), game.at(3,1), game.at(4,1) ,game.at(5,1),game.at(6,1),game.at(7,1),
		game.at(8,1), game.at(9,1) ,game.at(10,1),game.at(11,1),game.at(12,1), game.at(13,1),game.at(14,1), 
		game.at(15,1) ,game.at(16,1),game.at(17,1), game.at(0,4) ,game.at(1,4), game.at(2,4),game.at(3,4), game.at(4,4) , game.at(5,4),game.at(6,4), game.at(7,4)
		, game.at(8,4), game.at(9,4),game.at(10,4), game.at(11,4), game.at(12,4) ,game.at(13,4) , game.at(14,4) 
		,game.at(15,4), game.at(16,4), game.at(1,6), game.at(2,6), game.at(3,6), game.at(4,6) , game.at(5,6), game.at(6,6) ,game.at(7,6)
		,game.at(8,6) , game.at(9,6) , game.at(10,6), game.at(11,6), game.at(12,6), game.at(13,6), game.at(14,6) 
		, game.at(15,6) , game.at(16,6), game.at(17,6), game.at(0,9) , game.at(1,9), game.at(2,9), game.at(3,9) ,game.at(4,9), game.at(5,9) , game.at(6,9), game.at(7,9)
		,game.at(8,9) ,game.at(9,9) ,game.at(10,9) , game.at(11,9),game.at(12,9) , game.at(13,9),game.at(14,9) 
		,game.at(15,9),game.at(16,9) ,game.at(1,12) ,game.at(2,12),game.at(3,12),game.at(4,12) , game.at(5,12) , game.at(6,12), game.at(7,12)
		,game.at(8,12) ,game.at(9,12) , game.at(10,12) , game.at(11,12) ,game.at(12,12) , game.at(13,12), game.at(14,12) 
		,game.at(15,12), game.at(16,12),game.at(17,12), game.at(0,14) , game.at(1,14) , game.at(2,14), game.at(3,14) , game.at(4,14) , game.at(5,14), game.at(6,14), game.at(7,14)
		,game.at(8,14) , game.at(9,14) , game.at(10,14) , game.at(11,14) , game.at(12,14), game.at(13,14) ,game.at(14,14) 
		, game.at(15,14),game.at(16,14) , game.at(10,16) , game.at(7,16) , game.at(8,16) , game.at(9,16)]
		
		return posicionParaSaltar.any{mensaje => mensaje == position}
	
	}
	

//// Mazo de Mario
}

object mazo {
	
	var property position= game.at(2,6)
	
	method image(){
	return  "assets/objects/59.png" }
		
	
		
	method colisionadoPor(personaje){
		personaje.tieneMazo(true)
		// personaje.transformar(mario)
		game.removeVisual(self)
		
					
	}
	
	
	
	
	
}
