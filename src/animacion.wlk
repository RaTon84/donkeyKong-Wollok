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
}
	

