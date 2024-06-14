import wollok.game.*
import escenarios.*

object barriles {
	method position()=game.at(0,14)
	method image() = "assets/objects/1.png" 
}

class Barril{
	var property position = game.at(3,14)
	var fotograma = 0	
	const property gifBarril = ["assets/objects/82.png","assets/objects/83.png","assets/objects/84.png","assets/objects/85.png"]
	var property image = gifBarril.get(fotograma)
	var direccion = "derecha"
	var property velocidad = 250
	const random = [0,1,2,3]
	var property estoyBajandoEscalera = false
	
	method siguienteFotograma(lista){
		fotograma = (fotograma+1) % lista.size()
		image = lista.get(fotograma)
	}
	
	method animacion(){game.onTick(200, "animacion-tirarBarriles", {self.siguienteFotograma(gifBarril)})}
	
	method rodarDerecha(){position = game.at(position.x()+1,position.y())}
	
	method rodarIzquierda(){position = game.at(position.x()-1,position.y())}
	
	method caer(){position = game.at(position.x(),position.y()-1)}
		
	method cambiarDireccion(){if(direccion=="derecha") direccion="izquierda" else direccion="derecha"}
	
	method hayVigaAbajo(){return stage1.vigas().any({v=>v==game.at(position.x(),position.y()-1)})}
	
	method puedoCaer(){return stage1.caidaBarril().any({v=>v==game.at(position.x(),position.y())})}
	
	method caerSiguienteViga(){if(self.hayVigaAbajo())self.cambiarDireccion() else self.caer()} //falta cambiar animacion a normal
	
	method bajarEscalera(){
		if(self.hayVigaAbajo() && estoyBajandoEscalera){ //falta cambiar animacion a escalera
			self.cambiarDireccion()
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
		if(estoyBajandoEscalera)
			self.bajarEscalera()
		else if(self.puedoCaer())self.dicidir()
		else self.rodarVigas()
	}
	
	method recorrerEscenario(){game.onTick(velocidad, "recorrido-barril", {self.rodar()})}
	
		method esEliminado(){
		
		game.removeVisual(self)
	}
	
	
	
    method colisionadoPor(personaje){
			if(personaje.tieneMazo()){
			personaje.eliminarBarril()
			
			}

			else {
				personaje.esChocadoPor(self)
			
			}
		
			self.esEliminado()
		
		}
	}
