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
	var property velocidad = 150
	method siguienteFotograma(lista){
		fotograma = (fotograma+1) % lista.size()
		image = lista.get(fotograma)
	}
	
	method animacion(){
		game.onTick(200, "animacion-tirarBarriles", {self.siguienteFotograma(gifBarril)})
	}
	
	method rodarDerecha(){position = game.at(position.x()+1,position.y())}
	
	method rodarIzquierda(){position = game.at(position.x()-1,position.y())}
	
	method caer(){position = game.at(position.x(),position.y()-1)}
	
	//method bajarEscalera()
	
	method cambiarDireccion(){if(direccion=="derecha") direccion="izquierda" else direccion="derecha"}
	
	method hayVigaAbajo(){return stage1.vigas().any({v=>v==game.at(position.x(),position.y()-1)})}
	
	//method hayEscaleraAbajo()
	
	method caerSiguienteViga(){if(self.hayVigaAbajo()){self.cambiarDireccion()}else self.caer()}
	
	method rodar(){
		if(direccion=="derecha" && position.x()!=17)self.rodarDerecha()
			else if(direccion=="izquierda" && position.x()!=0)self.rodarIzquierda()
			else self.caerSiguienteViga()
	}
	
	method recorrerEscenario(){game.onTick(velocidad, "recorrido-barril", {self.rodar()})
	}
}