import wollok.game.*
import escenarios.*
import mario.*

object barriles {
	method position()=game.at(0,14)
	method image() = "assets/objects/2.png" 
	method esChocadoPor(otro){
		
	}
}

class Barril {
	var property position = game.at(5,14)
	var fotograma = 0	
	const property gifBarril = ["assets/objects/82.png","assets/objects/83.png","assets/objects/84.png","assets/objects/85.png"]	
	var property image = gifBarril.get(fotograma)
	var direccion = "derecha"
	var property velocidad = 250
	const random = [0,1,2,3]
	var property estoyBajandoEscalera = false
	//const property gifDerecha = ["assets/objects/82.png","assets/objects/83.png","assets/objects/84.png","assets/objects/85.png"]
	//const property gifIzquierda = ["assets/objects/85.png","assets/objects/84.png","assets/objects/83.png","assets/objects/82.png"]
	//const property gifEscalera = ["assets/objects/86.png","assets/objects/87.png"]
	//var property image = gifDerecha.get(fotograma)
	
	method siguienteFotograma(lista){
		fotograma = (fotograma+1) % lista.size()
		image = lista.get(fotograma)
	}
	
	method animacion(){game.onTick(200, "animacion-tirarBarriles", {self.siguienteFotograma(gifBarril)})}
	//method animacionDerecha(){game.onTick(200, "animacion-derecha", {self.siguienteFotograma(gifDerecha)})}
	//method animacionIzquierda(){game.onTick(200, "animacion-izquierda", {self.siguienteFotograma(gifIzquierda)})}	
	//method animacionEscalera(){game.onTick(200, "animacion-escalera", {self.siguienteFotograma(gifEscalera)})}
	
	method rodarDerecha(){position = game.at(position.x()+1,position.y())}
	
	method rodarIzquierda(){position = game.at(position.x()-1,position.y())}
	
	method caer(){position = game.at(position.x(),position.y()-1)}
		
	method cambiarDireccion(){if(direccion=="derecha") direccion="izquierda" else direccion="derecha"}
	
	method hayVigaAbajo(){return stage1.vigas().any({v=>v==game.at(position.x(),position.y()-1)})}
	
	method puedoCaer(){return stage1.caidaBarril().any({v=>v==game.at(position.x(),position.y())})}
	
	method caerSiguienteViga(){if(self.hayVigaAbajo())self.cambiarDireccion() else self.caer()} //falta cambiar animacion a normal
	
	method bajarEscalera(){
		if(self.hayVigaAbajo() && estoyBajandoEscalera){ //falta cambiar animacion a escalera
			self.cambiarDireccion() //self.animacionIzquierda() game.removeTickEvent("animacion-derecha") (ver donde ponerlo)
			estoyBajandoEscalera=false
		} else{
				self.caer()
				estoyBajandoEscalera=true
			} 
	}
			
	method rodarVigas(){
		if(direccion=="izquierda" && position.x()!=0)self.rodarIzquierda()
			else if(direccion=="derecha" && position.x()!=17)self.rodarDerecha()
			else self.caerSiguienteViga()
	}
	
	method dicidir(){
		if(random.anyOne()==0){
			self.bajarEscalera()
		}else self.rodarVigas()
	}
	
	
	method rodar(){
		if(position==game.at(0,1)){self.removerBarril()}				
		else if(estoyBajandoEscalera)self.bajarEscalera()
		else if(self.puedoCaer())self.dicidir()
		else self.rodarVigas()
	}
	
	method recorrerEscenario(){game.onTick(velocidad, "recorrido-barril", {self.rodar()})}
	method esChocadoPor(otro){
		
	}
	
	method removerBarril(){
		game.removeVisual(self)
		position = game.at(5,14)
		direccion = "derecha"
		game.removeTickEvent("recorrido-barril")
	}
	
    method colisionadoPor(personaje){
		if(personaje.tieneMazo()){
			game.sound("assets/sonidos/get-item.wav").play()	
			game.say(mario, "¡100 Puntos!")
			personaje.eliminarBarril()
		}
		else {
			personaje.esChocadoPor(self)
		}		
		self.removerBarril()
		}
}