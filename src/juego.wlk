import wollok.game.*
import mario.*
import kong.*
import pauline.*
import escenarios.*
import sonido.*
import objects.*
import pantallas.*

object juego{
	const b1 = new Barril()
	const b2 = new Barril()
	const b3 = new Barril()
	const b4 = new Barril()
	const b5 = new Barril()
	const b6 = new Barril()
	const b7 = new Barril()
	const barriles1 = [b1,b2,b3,b4,b5,b6,b7]
	var nro=0
	var nroBarril = barriles1.first()
	
	method siguienteBarril(){
		nro = (nro+1) % barriles1.size()
		nroBarril = barriles1.get(nro)}
	
	method tirarBarril(){
		try {
			game.addVisual(nroBarril)
			nroBarril.animacion()
			nroBarril.recorrerEscenario()
			game.onCollideDo(mario,{elemento=>elemento.colisionadoPor(mario)})
  			game.onCollideDo(nroBarril,{personaje=>personaje.esChocadoPor(nroBarril)})
		} catch e : Exception {
  			nroBarril.removerBarril()
  			game.addVisual(nroBarril)
			nroBarril.animacion()
			nroBarril.recorrerEscenario()
		}
		//game.addVisual(nroBarril)
		//nroBarril.animacion()
		//nroBarril.recorrerEscenario()
		game.onCollideDo(mario,{elemento=>elemento.colisionadoPor(mario)})
  		game.onCollideDo(nroBarril,{personaje=>personaje.esChocadoPor(nroBarril)})}
	
	method tirarBarriles(){self.tirarBarril() self.siguienteBarril()}
	////metodo viejo
	/*method tirarBarril(barril){							
		game.addVisual(barril)
		barril.animacion()
		barril.recorrerEscenario()
		game.whenCollideDo(mario,{elemento=>elemento.colisionadoPor(mario)})
		game.whenCollideDo(barril,{personaje=>personaje.esChocadoPor(barril)})
	}*/
	
	 
	//---------------------------------------------
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
	game.addVisual(pauline)
	game.addVisual(mario)
	game.addVisual(kong)
	game.addVisual(barriles)
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
		game.onTick(100,"validacion",{contador = contador + 1})
		game.removeVisual(pantallaInicio)
		game.addVisual(pantallaControles)
		self.cambioImage(pantallaControles)
		self.medidas()
		game.schedule(1,{
			keyboard.enter().onPressDo{
			musicaInicial.desactivarMusicaInicial()
			self.inicioStage1()}})}
			
	method inicioStage1(){
			game.removeVisual(pantallaControles)
			game.addVisual(pantallaInicioStage1)
			self.medidas()
		game.schedule(2000,{
			self.configuracionNivel1()})}

	method configuracionNivel1(){
	game.title("Donkey Kong (wollok Version)")
	game.removeVisual(pantallaInicioStage1)
	self.aniadirVisuales(stage1)
	mario.inicioMario() 
	kong.animacion()
	game.onTick(4575,"lanzamientoDeBarriles",{self.tirarBarriles()})
	musicaInicioJuego.activarMusicaInicialDelJuego()
	musica1.activarMusica()
	self.medidas()
	}}
	
	
