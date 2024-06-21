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

	method inicio(){
		game.addVisual(pantallaInicio)
		game.onTick(700,"cambio imagen",{pantallaInicio.siguienteFotograma()})
		game.width(18)
		game.height(18)
		game.cellSize(50)
		musicaInicial.activarMusicaInicial()
		keyboard.enter().onPressDo{
			self.controles()}}
	
	method controles(){
		var contador = 0
		game.onTick(100,"validacion",{contador = contador + 1})
		game.removeVisual(pantallaInicio)
		game.addVisual(pantallaControles)
		game.onTick(700,"cambio imagen",{pantallaControles.siguienteFotograma()})
		game.width(18)
		game.height(18)
		game.cellSize(50)
		game.schedule(1,{
			keyboard.enter().onPressDo{
			musicaInicial.desactivarMusicaInicial()
			self.configuracion()}})}
	
	method configuracion(){
	game.title("Donkey Kong (wollok Version)")
	game.removeVisual(pantallaControles)
	game.addVisual(stage1)
	game.addVisual(mazo)
	game.addVisual(pauline)
	game.addVisual(mario)
	mario.inicioMario() 
	game.addVisual(kong)
	kong.animacion()
	game.addVisual(barriles)
	game.onTick(4575,"lanzamientoDeBarriles",{self.tirarBarriles()})
	musicaInicioJuego.activarMusicaInicialDelJuego()
	musica1.activarMusica()
	game.width(18)
	game.height(18)
	game.cellSize(50)
	}}