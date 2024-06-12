import wollok.game.*

object kong{	
	var property position = game.at(1,14)
	var fotograma = 0
	const property tirarBarriles = [
		"assets/personajes/donkeyKong/0.png",
		"assets/personajes/donkeyKong/6.png",
		"assets/personajes/donkeyKong/9.png",
		"assets/personajes/donkeyKong/7.png",
		"assets/personajes/donkeyKong/0.png",
		"assets/personajes/donkeyKong/14.png"
		]
	var property image = tirarBarriles.get(fotograma)	
		
	method siguienteFotograma(lista){
		fotograma = (fotograma+1) % lista.size()
		image = lista.get(fotograma)
	}
	method animacion(lista){
		game.onTick(750, "animacion-tirarBarriles", {
			self.siguienteFotograma(tirarBarriles)
		})
	}	
}