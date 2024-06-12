import wollok.game.*

object pauline {

	var property position = game.at(7,16)
	var fotograma = 0
	const property animacionPauline = [
	
		"assets/personajes/pauline/0.png",
		"assets/personajes/pauline/1.png",
		"assets/personajes/pauline/2.png",
		"assets/personajes/pauline/3.png"
		
		]
	var property image = animacionPauline.get(fotograma)	
		
	method siguienteFotograma(lista){
		fotograma = (fotograma+1) % lista.size()
		image = lista.get(fotograma)
	}
	method animacion(){
		game.onTick(750, "animacion-pauline", {
			self.siguienteFotograma(animacionPauline)
			self.siguientePosicion()
		})
	}
	method siguientePosicion(){
		if(position == game.at(7,16)){
			position = game.at(8,16)
		}
		else if(position == game.at(8,16)){
			position = game.at(9,16)
		}
		else if (position == game.at(9,16)){
			position = game.at(8.1,16)
		}
		else if (position == game.at(8.1,16)){
			position = game.at(7,16)
		}
		
	}

}

