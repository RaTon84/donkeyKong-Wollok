import wollok.game.*
import mario.*
import kong.*
import pauline.*
import escenarios.*
import sonido.*
import objects.*
import pantallas.*
import score.*


object juego{
	var property musicaFondo = game.sound("assets/sonidos/background-1.mp3")
	method iniciarJuego(){
		self.inicio()
		game.start()}												
	
	method medidas(){
		game.width(18)
		game.height(18)
		game.cellSize(50)
	}
	
	method cambioImage(unaPantalla){
		game.onTick(700,"cambio imagen",{unaPantalla.siguienteFotograma()})
	}
	
	method aniadirVisuales(unStage){
	game.addVisual(unStage)
	game.addVisual(mazo)
	game.addVisual(mario)
	game.addVisual(kong)
	game.addVisual(barriles)
	game.addVisual(unidadTablero)
	game.addVisual(decenaTablero)
	game.addVisual(centenaTablero)
	game.addVisual(milTablero)
	if (unStage==stage1)
		game.addVisual(pauline)
	if (unStage==stage2){
		game.addVisual(palanca1)
		game.addVisual(palanca2)
		game.addVisual(palanca3)
		game.addVisual(palanca4)}
	}
	
	
	method inicio(){
		game.addVisual(pantallaInicio)
		self.cambioImage(pantallaInicio)
		self.medidas()
		musicaInicial.activarMusicaInicial()
		keyboard.enter().onPressDo{
			self.controles()}}
	
	method controles(){
		var contador = 0
		var validacion = true
		game.onTick(100,"validacion",{contador = contador + 1})
		game.removeVisual(pantallaInicio)
		game.addVisual(pantallaControles)
		self.cambioImage(pantallaControles)
		self.medidas()
		game.schedule(1,{
			keyboard.enter().onPressDo{
			musicaInicial.desactivarMusicaInicial()
			self.inicioStage1()
			if(validacion){
			self.musicaFondo().play()
			musicaFondo.shouldLoop(true)
			self.musicaFondo().pause()
			validacion = false
		}

		}
			})}
			
	method inicioStage1(){
			game.removeVisual(pantallaControles)
			game.addVisual(pantallaInicioStage1)
			self.medidas()
		game.schedule(2000,{
			self.configuracionNivel1()})}
		
	method pasarNivel(){
		self.musicaFondo().pause()
		game.sound("assets/sonidos/finish-board.wav").play()
		game.clear()
		game.addVisual(pantallaInicioStage2)
		self.medidas()
		game.schedule(2000,{
			self.configuracionNivel2()})}  
	
	
	//CONFIGURACION DE NIVELES
	
	method configuracion(unNivel){
		if (unNivel==1)
			game.removeVisual(pantallaInicioStage1)
		else
			game.removeVisual(pantallaInicioStage2)	
		if (unNivel==1)
			self.aniadirVisuales(stage1)
		else
			self.aniadirVisuales(stage2)
		mario.inicioMario() 		
		self.medidas()
	}
	
	method configuracionNivel1(){
		game.title("Donkey Kong (wollok Version)")
		self.configuracion(1)
		//musicaInicioJuego.activarMusicaInicialDelJuego()
		self.musicaFondo().resume()
		kong.animacion()
		game.onTick(5550,"lanzamientoDeBarriles",{prograBarril.tirarBarriles()})		
		game.addVisual(barrilAzul)
		game.addVisual(fuegoBarril)
		game.schedule(7000,{prograFueguito.aniadirFueguito()})
		fuegoBarril.animacion()
	}
	        

	method configuracionNivel2(){
		kong.positionSegundoNivel()
		barriles.positionSegundoNivel()
		self.configuracion(2)}
}