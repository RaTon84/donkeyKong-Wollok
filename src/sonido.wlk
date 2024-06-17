import wollok.game.*

class Musica{
	const rain = game.sound("assets/sonidos/background-1.mp3")

	method activarMusica(){
		rain.shouldLoop(true)
		game.schedule(500, { rain.play()} )
		
	}
	method desactivarMusica(){
		 rain.shouldLoop(false)
	}


}
	
object musicaInicial {
	const rain = game.sound("assets/sonidos/start-board.wav")

	method activarMusicaInicial() {
		rain.shouldLoop(true)
		game.schedule(500, { rain.play()} )
		game.schedule(3400, { rain.stop()})
	}
}		
	


object sonidoMario{
	method deMovimiento(){
		/*const rain = game.sound("assets/sonidos/spring.wav")
		rain.volume(0.5)
		rain.shouldLoop(true)
		game.schedule(10, { rain.play()} )
		game.schedule(150, { rain.stop()} )	*/
		
	}
	method deSalto(){
		const rain = game.sound("assets/sonidos/jump.wav")
		rain.shouldLoop(true)
		keyboard.space().onPressDo({rain.volume(0.5)})
		game.schedule(1, { rain.play()} )
		game.schedule(800, { rain.stop()} )
	}
		method deObjeto(){
		const rain = game.sound("assets/sonidos/smash.wav")
		rain.play()
		
	}
}