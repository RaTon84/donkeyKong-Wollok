import wollok.game.*

object barriles {
	method position()=game.at(0,14)
	method image() = "assets/objects/1.png" 
}

class Barril{
	var property position = game.at(3,14)
	var fotograma = 0	
	const property barriles = [
		"assets/objects/82.png",
		"assets/objects/83.png",
		"assets/objects/84.png",
		"assets/objects/85.png"]
	var property image = barriles.get(fotograma)
	
	method siguienteFotograma(lista){
		fotograma = (fotograma+1) % lista.size()
		image = lista.get(fotograma)
	}
	method animacion(lista){
		game.onTick(500, "animacion-tirarBarriles", {
			self.siguienteFotograma(barriles)
		})
	}	
}