import wollok.game.*
import escenarios.*
import mario.*
import animacion.*
import sonido.*
import juego.*
//BARRILES

object barriles {
	var property position=game.at(0,14)
	method image() = "assets/objects/2.png" 
	method esChocadoPor(otro){}
	method positionSegundoNivel(){
		self.position(game.at(6,14))
	}
}

class Barril {
	var property position = game.at(5,14)
	var fotograma = 0	
	const property gifBarril = ["assets/objects/82.png","assets/objects/83.png","assets/objects/84.png","assets/objects/85.png"]	
	var property image = gifBarril.get(fotograma)
	var direccion = "derecha"
	var property velocidad = 150
	const random = [0,1,2,3,4,5]
	var property estoyBajandoEscalera = false
	//const property gifDerecha = ["assets/objects/82.png","assets/objects/83.png","assets/objects/84.png","assets/objects/85.png"]
	//const property gifIzquierda = ["assets/objects/85.png","assets/objects/84.png","assets/objects/83.png","assets/objects/82.png"]
	//const property gifEscalera = ["assets/objects/86.png","assets/objects/87.png"]
	//var property image = gifDerecha.get(fotograma)
	
	method siguienteFotograma(lista){
		fotograma = (fotograma+1) % lista.size()
		image = lista.get(fotograma)}
	
	method animacion(){game.onTick(200, "animacion-Barril", {self.siguienteFotograma(gifBarril)})}
	//method animacionDerecha(){game.onTick(200, "animacion-derecha", {self.siguienteFotograma(gifDerecha)})}
	//method animacionIzquierda(){game.onTick(200, "animacion-izquierda", {self.siguienteFotograma(gifIzquierda)})}	
	//method animacionEscalera(){game.onTick(200, "animacion-escalera", {self.siguienteFotograma(gifEscalera)})}
	
	method rodarDerecha(){position = game.at(position.x()+1,position.y())}
	
	method rodarIzquierda(){position = game.at(position.x()-1,position.y())}
	
	method caer(){position = game.at(position.x(),position.y()-1)}
		
	method cambiarDireccion(){
		if(direccion=="derecha") 
			direccion="izquierda" 
		else 
			direccion="derecha"}
	
	method hayVigaAbajo(){return stage1.vigas().any({v=>v==game.at(position.x(),position.y()-1)})}
	
	method puedoCaer(){return stage1.caidaBarril().any({v=>v==game.at(position.x(),position.y())})}
	
	method caerSiguienteViga(){
		if(self.hayVigaAbajo())
			self.cambiarDireccion() 
		else 
			self.caer()
	} //cambia animacion a normal
	
	method bajarEscalera(){
		if(self.hayVigaAbajo() && estoyBajandoEscalera){ //cambia animacion a escalera
			self.cambiarDireccion() //self.animacionIzquierda() game.removeTickEvent("animacion-derecha")
			estoyBajandoEscalera=false} 
		else{
			self.caer()
			estoyBajandoEscalera=true}}
			
	method rodarVigas(){
		if(direccion=="izquierda" && position.x()!=0)self.rodarIzquierda()
			else if(direccion=="derecha" && position.x()!=17)self.rodarDerecha()
			else self.caerSiguienteViga()}

	method dicidir(){
		if(random.anyOne()==3) self.bajarEscalera()
		else self.rodarVigas()
	}
	
	method rodar(){
		if(position==game.at(0,1)){self.removerBarril()}				
		else if(estoyBajandoEscalera)self.bajarEscalera()
		else if(self.puedoCaer())self.dicidir()
		else self.rodarVigas()}
	
	method recorrerEscenario(){
		game.onTick(velocidad, "recorrido-barril", {self.rodar()})
	}
	
	method esChocadoPor(otro){}
	
	method removerBarril(){
		game.removeVisual(self)
		position = game.at(5,14)
		direccion = "derecha"
		game.removeTickEvent("recorrido-barril")
		game.removeTickEvent("animacion-Barril")}
	
    method colisionadoPor(personaje){
		if(personaje.tieneMazo()){
			game.sound("assets/sonidos/get-item.wav").play()	
			game.say(mario, "¡100 Puntos!")
			personaje.eliminarBarril()}
		else 
			personaje.esChocadoPor(self)		
		self.removerBarril()}

}

object prograBarril{

	const b1 = new Barril()
		const b2 = new Barril()
		const b3 = new Barril()
		const b4 = new Barril()
		const b5 = new Barril()
		const barriles = [b1,b2,b3,b4,b5]
		var posicion=0
		var nroBarril = barriles.first()
		
		method siguienteBarril(){
			posicion = (posicion+1) % barriles.size()
			nroBarril = barriles.get(posicion)}
		
		method tirarBarril(){
			try {
				game.addVisual(nroBarril)
				nroBarril.animacion()
				nroBarril.recorrerEscenario()
				game.onCollideDo(mario,{elemento=>elemento.colisionadoPor(mario)})
	  			game.onCollideDo(nroBarril,{personaje=>personaje.esChocadoPor(nroBarril)})
			} catch e : Exception {
	  			nroBarril.removerBarril()
	  			game.addVisual(nroBarril)
				nroBarril.animacion()
				nroBarril.recorrerEscenario()
			}			
			game.onCollideDo(mario,{elemento=>elemento.colisionadoPor(mario)})
	  		game.onCollideDo(nroBarril,{personaje=>personaje.esChocadoPor(nroBarril)})}
		
		method tirarBarriles(){
			self.tirarBarril() 
			self.siguienteBarril()
		}		

}



//MAZO

object mazo {
	var property position= game.at(2,7)
	const stageEnQueSeMueveMario= mario.stageEnQueMeMuevo()

	method image(){
		return  "assets/objects/59.png"}
	
	method colisionadoPor(personaje){
		personaje.tieneMazo(true)
		game.removeVisual(self)
		self.activarMazo()}
	
	method moverDerechaConMazo(){
		mario.moverDerechaSiSePuede()
		sonidoMario.deMovimiento()
		animacionMario.animarDerechaConMazo()
		if (stageEnQueSeMueveMario.hayCaidaDebajo()) mario.caer()}
	
	method moverIzquierdaConMazo(){
		mario.moverIzquierdaSiSePuede()
		mario.verificarVigaGanadora()
		sonidoMario.deMovimiento()
		animacionMario.animarIzquierdaConMazo()
		if (stageEnQueSeMueveMario.hayCaidaDebajo()) mario.caer()}
	
	method activarMazo(){
		const rain = game.sound("assets/sonidos/background-3.mp3")	
		juego.musicaFondo().pause()
		sonidoMario.deObjeto()
		rain.play()
		rain.shouldLoop(true)
	 	game.onTick(8000, "movimiento",{ 
	 	mario.tieneMazo(false)
		rain.shouldLoop(false)
		juego.musicaFondo().resume()})}
}

class Palanca{
	const property position
	
	
	method image (){
		return "assets/objects/90.png"}		
		
	method consecuencias(){
		game.removeVisual(self)
		stage2.activarEscaleraNvl2()}
	}


const palanca1= new Palanca(position=game.at(13,1))
const palanca2= new Palanca(position=game.at(3,4))
const palanca3= new Palanca(position=game.at(9,7))
const palanca4= new Palanca(position=game.at(15,11))