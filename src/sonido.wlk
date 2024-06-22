import wollok.game.*

	
object musicaInicioJuego {
	const rain = game.sound("assets/sonidos/start-board.wav")
	
	method activarMusicaInicialDelJuego() {
		rain.shouldLoop(true)
		game.schedule(500, { rain.play()} )
		game.schedule(3400, { rain.stop()})}
}


object musicaInicial {
	const rain = game.sound("assets/sonidos/sonidoInicial.mp3")

	method activarMusicaInicial(){
		game.schedule(500,{rain.play()})}
		
	method desactivarMusicaInicial(){
		rain.stop()}
}		
	

object sonidoMario{
	method deMovimiento(){
		const rain = game.sound("assets/sonidos/spring.wav")
		rain.volume(0.5)
		game.schedule(10, { rain.play()})
		game.schedule(150, { rain.stop()})}
	
	method deSalto(){
		const rain = game.sound("assets/sonidos/jump.wav")
		rain.shouldLoop(true)
		keyboard.space().onPressDo({rain.volume(0.5)})
		game.schedule(1,{rain.play()})
		game.schedule(800,{rain.stop()})}
		
		method deObjeto(){
		
		const rain = game.sound("assets/sonidos/smash.wav")
		rain.play()}
	
	method pierdeVida(){
		const rain = game.sound("assets/sonidos/pierdeVida.wav")
		rain.volume(0.5)
		game.schedule(10, { rain.play()})
		game.schedule(900, { rain.stop()})}
}