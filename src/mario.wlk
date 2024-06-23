import juego.*
import wollok.game.*
import animacion.*
import escenarios.*
import sonido.*
import objects.*
import pantallas.*
import pauline.*
import score.*


object mario {
	var vidas=0
	var puntos = 0
	
 	//method puntaje()
	//method sumaPuntos()
	var property tieneMazo=false
	const velocidad=100
	var property position=game.at(1,1)
	var property stageEnQueMeMuevo= stage1
	var property palancasQueEncontrar=[palanca1,palanca2,palanca3,palanca4]
	
	method image()= animacionMario.image()
	
	method configuracionInicioMario(){		
		position=game.at(1,1)
		vidas=2
	    puntos = 0
	    tieneMazo=false
		animacionMario.animarDerecha()}
		
		//KEYBOARD
	method inicioMario(){
		self.configuracionInicioMario()
		
		keyboard.m().onPressDo{
			tieneMazo=true
		}                                     ////prueba hasta que se arregle las vidas
		keyboard.n().onPressDo{
			tieneMazo=false
		}
		
		keyboard.d().onPressDo{
		if(tieneMazo)
			mazo.moverDerechaConMazo()}
			
		keyboard.a().onPressDo{
		if(tieneMazo)
			mazo.moverIzquierdaConMazo()}
	
		keyboard.d().onPressDo{
		if(not tieneMazo)
			self.moverDerecha()}
			
		keyboard.a().onPressDo{
		if(not tieneMazo)
			self.moverIzquierda()}
			
		keyboard.w().onPressDo{
			self.moverArriba()}
			
		keyboard.s().onPressDo{
			self.moverAbajo()}
			
		keyboard.space().onPressDo{
			self.saltar()}	
}
	
	method juegoTerminado()= vidas==0
    
    method sumaPuntos(cantidad){puntos+=cantidad}
 
   	method eliminarBarril(){puntaje.sumaPuntos(100)} 
	
 	method esColisionadoPor(){}
   		
 	method esChocadoPor(otro){
 	
   		if(self.tieneMazo())
   			otro.removerBarril()
   		else {
   			animacionMario.pierdeVida()
   			sonidoMario.pierdeVida()
   			game.say(self, "¡Auch!")
   			vidas= vidas - 1
   			if(self.juegoTerminado()){
   				juego.musicaFondo().pause()
   				gameOver.marioPierde()}}}
   	
		
		//MOVIMIENTO
	method moverDerecha(){
		self.moverDerechaSiSePuede()
		self.verificarPalanca()
		sonidoMario.deMovimiento()
		animacionMario.animarDerecha()
		if (stageEnQueMeMuevo.hayCaidaDebajo()) self.caer()
	}

	method moverIzquierda(){
		self.moverIzquierdaSiSePuede()
		self.verificarVigaGanadora()
		self.verificarPalanca()
		sonidoMario.deMovimiento()
		animacionMario.animarIzquierda()
		if (stageEnQueMeMuevo.hayCaidaDebajo()) self.caer()
	}
	
	method moverArriba(){
		self.moverArribaSiSePuede()
		self.animarArribaSiSePuede()
	}

	method moverAbajo(){
		self.moverAbajoSiSePuede()
		self.animarAbajoSiSePuede()
	}
	
	method saltar(){
			self.saltarSiSePuede()																									  
			sonidoMario.deSalto()
	}
	
	method caer(){
		position= if (stageEnQueMeMuevo==stage1)
					game.at(position.x(),position.y() - if (position.y()==4 or position.y()== 9 or position.y()==12) 3 else 2)
				  else 
				  	game.at(position.x(),position.y() - if (position.y()==4) 3 else if (position.y()==7) 6 else if (position.y()==11 and not stage2.hayCaidaMenorDebajo())10 else if(position.y()==11 and stage2.hayCaidaMenorDebajo())4  else 13)
		
		
		animacionMario.animarCaida()}
	
	//OBTIENE POSITION VIGA Y ESCALERA
	
	method obtenerPosicionAbajo()= game.at(position.x(),position.y()-1)
	
	method obtenerPosicionArriba()= game.at(position.x(),position.y()+1)
	
	method obtenerPosicionIzquierda()= game.at(position.x()-1,position.y()+1)
	

	//MUEVE DIRECCION SI SE PUEDE
	
	method saltarSiSePuede(){
			if(self.validarSalto()){
			self.moverArribaSinCondicion()
			animacionMario.animarSalto()											
			game.schedule(velocidad*3,{self.caidaSalto()})}}
	
	method caidaSalto(){														
		position = game.at(position.x(),if(position.y()-1>=0)position.y()-1 else position.y())				
		animacionMario.animarSaltoCaida()}
		
	method moverArribaSiSePuede(){
		const alto = game.height()
		position = game.at(position.x(),if(position.y()+1<alto and stageEnQueMeMuevo.hayEscaleraArriba())position.y()+1 else position.y())
		//if (stageEnQueMeMuevo.puedoPasarAlSiguienteNivel())
		}
	method moverArribaSinCondicion(){
		const alto = game.height()
		position = game.at(position.x(),if(position.y()+1<alto)position.y()+1 else position.y())}
	
	method moverAbajoSiSePuede(){
		if (stageEnQueMeMuevo.hayEscaleraDebajo())
		position = game.at(position.x(),if(position.y()-1>=0)position.y()-1 else position.y())}
		
	method moverDerechaSiSePuede(){
		if (stageEnQueMeMuevo.hayVigaDebajo()){
		const ancho = game.width()
		position = game.at(if(position.x()+1<ancho)position.x()+1 else position.x() ,position.y())}}
	
	method moverIzquierdaSiSePuede(){
		if (stageEnQueMeMuevo.hayVigaDebajo())
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
		
		return posicionParaSaltar.any{mensaje => mensaje == position}}
	
	// ANIMAR SI SE PUEDE
	
	method animarArribaSiSePuede(){
		if (stageEnQueMeMuevo.hayEscaleraArriba())
		animacionMario.animarArriba()}
	
	method animarAbajoSiSePuede(){
		if (not stageEnQueMeMuevo.hayVigaDebajo())
		animacionMario.animarArriba()}
	

	method verificarVigaGanadora(){
		if (position==stageEnQueMeMuevo.vigaGanadora()){
			juego.pasarNivel()
			stageEnQueMeMuevo=stage2}}
	
	method verificarPalanca(){
		if (stageEnQueMeMuevo==stage2 and palancasQueEncontrar.any{p=>p.position()==position}){
			palancasQueEncontrar.first().consecuencias()
			self.eliminarPalanca()}
	}
	
	method eliminarPalanca(){
		palancasQueEncontrar.remove(palancasQueEncontrar.first())
	}
}

	


