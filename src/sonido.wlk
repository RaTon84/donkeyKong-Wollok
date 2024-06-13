import wollok.game.*

object musica{
	method activarMusica(){
		const rain = game.sound("assets/sonidos/background-1.mp3")
		rain.shouldLoop(true)
		game.schedule(500, { rain.play()} )
	}
}



object sonidoMario{
	method deMovimiento(){
		const rain = game.sound("assets/sonidos/spring.wav")
		rain.shouldLoop(true)
		game.schedule(1, { rain.play()} )
		game.schedule(150, { rain.stop()} )	
	}
	method deSalto(){
		const rain = game.sound("assets/sonidos/salto.wav")
		rain.shouldLoop(true)
		game.schedule(1, { rain.play()} )
		game.schedule(1200, { rain.stop()} )
	}
}