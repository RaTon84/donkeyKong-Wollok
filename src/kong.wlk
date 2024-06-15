import wollok.game.*

object kong{	
	var property position = game.at(2,14)
	var fotograma = 0
	const property gifKong = [
		"assets/personajes/donkeyKong/0.png",
		"assets/personajes/donkeyKong/14.png",
		"assets/personajes/donkeyKong/0.png",
		"assets/personajes/donkeyKong/6.png",
		"assets/personajes/donkeyKong/9.png",
		"assets/personajes/donkeyKong/7.png"
		]
	var property image = gifKong.get(fotograma)	
		
	method siguienteFotograma(lista){
		fotograma = (fotograma+1) % lista.size()
		image = lista.get(fotograma)
	}
	
	method animacion(){
		game.onTick(750, "animacion-tirarBarriles", {
			self.siguienteFotograma(gifKong)
		})
	}
	method esChocadoPor(otro){
		
	}	
}