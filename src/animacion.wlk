import mario.*
import escenarios.*

object animacionMario {
	
	var direccion="derecha"
	var fotogramaActual=0
	
	method direccion(nuevaDireccion){
		direccion=nuevaDireccion
	}
	
	method siguienteFotograma(){
		if (direccion=="derecha" or direccion=="izquierda") fotogramaActual=(fotogramaActual+1)%4 else fotogramaActual=(fotogramaActual+1)%2
	}
	
	method image(){
		return "assets/personajes/mario/"+direccion+"-"+fotogramaActual.toString()+".png"
	}	
	
	
	//ANIMAR DIRECCION SI SE PUEDE
	
	method animarAbajo(){
		self.direccion("abajo")
		self.siguienteFotograma()
	}

	method animarArriba(){
		self.direccion("arriba")
		self.siguienteFotograma()
	}

	method animarIzquierda(){
		self.direccion("izquierda")
		self.siguienteFotograma()
	}
	
	method animarDerecha(){
		self.direccion("derecha")
		self.siguienteFotograma()
	}
	
	method animarSalto(){
		self.direccion("salto")
		self.siguienteFotograma()
	}
	

}
	
