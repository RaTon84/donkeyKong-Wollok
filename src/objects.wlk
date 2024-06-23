import wollok.game.*
import escenarios.*
import mario.*
import animacion.*
import sonido.*
import juego.*

//BARRILES

object barriles {
	var property position=game.at(0,14)	
	method image() = "assets/objects/2.png"
	method positionSegundoNivel(){
		self.position(game.at(6,14))
	}
}

class Barril {
	var property position = game.at(5,14)
	var fotograma = 0
	var direccion = "derecha"
	var property velocidad = 150
	const random = [0,1,2,3,4,5]
	var property estoyBajandoEscalera = false
	const property gifDerecha = ["assets/objects/82.png","assets/objects/83.png","assets/objects/84.png","assets/objects/85.png"]
	const property gifIzquierda = ["assets/objects/85.png","assets/objects/84.png","assets/objects/83.png","assets/objects/82.png"]
	var gifActual = gifDerecha
	var property image = gifDerecha.get(fotograma)
	//const property gifEscalera = ["assets/objects/86.png","assets/objects/87.png"]
	//var property image = gifDerecha.get(fotograma)
	
	method siguienteFotograma(lista) {
		fotograma = (fotograma + 1) % lista.size()
		image = lista.get(fotograma)
	}
	
	method animacion() {
		game.onTick(velocidad, "animacion-Barril", { self.siguienteFotograma(gifActual)})
	}

	method rodarDerecha() {
		position = game.at(position.x() + 1, position.y())
	}

	method rodarIzquierda() {
		position = game.at(position.x() - 1, position.y())
	}

	method caer() {
		position = game.at(position.x(), position.y() - 1)
	}
		
	method cambiarDireccion() {
		if (direccion == "derecha") {
			direccion = "izquierda"
			gifActual = gifIzquierda
			game.removeTickEvent("animacion-Barril")
			self.animacion()
		} else {
			direccion = "derecha"
			gifActual = gifDerecha
			game.removeTickEvent("animacion-Barril")
			self.animacion()
		}
	}
	method hayVigaAbajo(){return stage1.vigas().any({v=>v==game.at(position.x(),position.y()-1)})}
	
	method puedoCaer(){return stage1.caidaBarril().any({v=>v==game.at(position.x(),position.y())})}
	
	method caerSiguienteViga(){
		if(self.hayVigaAbajo())
			self.cambiarDireccion() 
		else 
			self.caer()
	} //cambia animacion a normal
	
	method bajarEscalera(){
		if(self.hayVigaAbajo() && estoyBajandoEscalera){ //cambia animacion a escalera
			self.cambiarDireccion() 
			estoyBajandoEscalera=false} 
		else{
			self.caer()
			estoyBajandoEscalera=true}}
			
	method rodarVigas(){
		if(direccion=="izquierda" && position.x()!=0)self.rodarIzquierda()
			else if(direccion=="derecha" && position.x()!=17)self.rodarDerecha()
			else self.caerSiguienteViga()}

	method dicidir(){
		if(random.anyOne()==3) self.bajarEscalera()
		else self.rodarVigas()
	}
	
	method rodar(){
		if(position==game.at(0,1)){self.removerBarril()}				
		else if(estoyBajandoEscalera)self.bajarEscalera()
		else if(self.puedoCaer())self.dicidir()
		else self.rodarVigas()}
	
	method recorrerEscenario(){
		game.onTick(velocidad, "recorrido-barril", {self.rodar()})
	}
		
	method removerBarril(){
		game.removeVisual(self)
		position = game.at(5,14)
		direccion = "derecha"
		game.removeTickEvent("animacion-Barril")
		game.removeTickEvent("recorrido-barril")		
	}
	
    method colisionadoPor(personaje){
		if(personaje.tieneMazo()){
			game.sound("assets/sonidos/get-item.wav").play()	
			game.say(mario, "¡100 Puntos!")
			personaje.eliminarBarril()
		}
		else 
			personaje.esChocadoPor(self)		
		self.removerBarril()
	}
}

object prograBarril {
	const b1 = new Barril()
	const b2 = new Barril()
	const b3 = new Barril()
	const b4 = new Barril()
	const b5 = new Barril()
	const barriles = [ b1 , b2, b3, b4, b5 ]
	var posicion = 0
	var nroBarril = barriles.first()

	method siguienteBarril() {
		posicion = (posicion + 1) % barriles.size()
		nroBarril = barriles.get(posicion)
	}

	method tirarBarril() {
		try {
			game.addVisual(nroBarril)
			nroBarril.animacion()
			nroBarril.recorrerEscenario()
		} catch e : Exception {
			nroBarril.removerBarril()
			game.addVisual(nroBarril)
			nroBarril.animacion()
			nroBarril.recorrerEscenario()
		}
		game.onCollideDo(mario, { elemento => elemento.colisionadoPor(mario)})
	}

	method tirarBarriles() {
		self.tirarBarril()
		self.siguienteBarril()
	}
}

class Fueguito{
	var property position = game.at(2,1)
	var fotograma = 0
	const property gifFantasmaDerecha = ["assets/objects/50.png","assets/objects/51.png"]
	const property gifFantasmaIzquierda = ["assets/objects/48.png","assets/objects/49.png"]
	var gifActual = gifFantasmaDerecha
	var property image = gifFantasmaDerecha.get(fotograma)
	var direccion = "derecha"
	var property velocidad = 700
	const random = [0,1,2,3,4,5,6,7,8,9]
	
	method siguienteFotograma(){
		fotograma = (fotograma+1) % gifActual.size()
		image = gifActual.get(fotograma)
	}
	
	method animacion(){
		game.onTick(250, "animacion-fueguito", {self.siguienteFotograma()})
	}
	
	method moverDerecha() {
		position = game.at(position.x() + 1, position.y())
	}
	
	method moverIzquierda() {
		position = game.at(position.x() - 1, position.y())
	}
	
	method moverAriiba() {
		position = game.at(position.x(), position.y() + 1)
	}
	
	method moverAbajo() {
		position = game.at(position.x(), position.y() - 1)
	}
	
	method caer() {
		position = game.at(position.x(), position.y() - 1)
	}
		
	method cambiarDireccion() {
		if (direccion == "derecha"){
			direccion = "izquierda"
			gifActual = gifFantasmaIzquierda
			game.removeTickEvent("animacion-fueguito")
			self.animacion()
		} else{
			direccion = "derecha"
			gifActual = gifFantasmaDerecha
			game.removeTickEvent("animacion-fueguito")
			self.animacion()
		}
	}
	
	method hayVigaAbajo() {
		return stage1.vigas().any({ v => v == game.at(position.x(), position.y() - 1) })
	}
	
	method hayVigaIzquierda() {
		return stage1.vigas().any({ v => v == game.at(position.x() - 1, position.y() - 1) })
	}
	
	method hayVigaDerecha() {
		return stage1.vigas().any({ v => v == game.at(position.x() + 1, position.y() - 1) })
	}
	
	method hayEscalera() {
		return stage1.caidaBarril().any({ v => v == game.at(position.x(), position.y()) })
	}
	

	method recorrerVigas() {
		if (random.anyOne() == 3){
			self.cambiarDireccion()	
		}
		else if (direccion == "derecha" && self.hayVigaDerecha()) {
			self.moverDerecha()
		} else if (direccion == "izquierda" && self.hayVigaIzquierda()) {
			self.moverIzquierda()
			
		} else if (!self.hayVigaDerecha()) {
			self.cambiarDireccion()	
		} else {
			self.cambiarDireccion()	
		}
	}
	
	method moverse(){
		self.recorrerVigas()
	}
	
	method recorrerEscenario(){
		game.onTick(velocidad, "recorrido-fueguito", {self.moverse()})
	}
	
	method removerFueguito(){
		game.removeVisual(self)
		direccion = "derecha"
		game.removeTickEvent("recorrido-fueguito")
		game.removeTickEvent("animacion-fueguito")
	}
	
	 method colisionadoPor(personaje){
		if(personaje.tieneMazo()){
			game.sound("assets/sonidos/get-item.wav").play()	
			game.say(mario, "¡100 Puntos!")
			personaje.eliminarBarril()}
		else 
			//personaje.esChocadoPor(self) ////añadir a mario
		self.removerFueguito()
	}
}

object prograFueguito {
	const fueguito = new Fueguito()

	method aniadirFueguito() {
		fueguito.position(game.at(4,1))
		game.addVisual(fueguito)
		fueguito.animacion()
		fueguito.recorrerEscenario()
		game.onCollideDo(mario, { elemento => elemento.colisionadoPor(mario)})
		//game.onCollideDo(fueguito, { personaje => personaje.esChocadoPor(fueguito)})
	}

/*method aniadirFantasmas() {
 * 	self.aniadirFantasma()
 * 	self.siguienteFantasma()
 }*/
}

object barrilAzul{
	var property image = "assets/objects/88.png"
	var property position = game.at(1,1)
	
	method colisionadoPor(personaje){}
}

object fuegoBarril{
	var property position = game.at(1,2)
	var fotograma = 0
	const property gifFuegoBarril = ["assets/objects/57.png","assets/objects/58.png"]
	var property image = gifFuegoBarril.get(fotograma)
	
	method siguienteFotograma(){
		fotograma = (fotograma+1) % gifFuegoBarril.size()
		image = gifFuegoBarril.get(fotograma)
	}
		
	method animacion(){
		game.onTick(200, "animacion-fuegoBarril", {self.siguienteFotograma()})
	}
	method colisionadoPor(personaje){}
}

class Fantasma {
	var property position = game.at(3,1)
	var fotograma = 0
	const property gifFantasmaDerecha = ["assets/objects/72.png","assets/objects/73.png"]
	const property gifFantasmaIzquierda = ["assets/objects/70.png","assets/objects/71.png"]
	var gifActual = gifFantasmaDerecha
	var property image = gifFantasmaDerecha.get(fotograma)
	var direccion = "derecha"
	var property velocidad = 700
	const random = [0,1,2,3,4,5]
	//const dicidirDireccion = ["izquierda","derecha"]
	
	method siguienteFotograma(){
		fotograma = (fotograma+1) % gifActual.size()
		image = gifActual.get(fotograma)
	}
	
	method animacion(){
		game.onTick(250, "animacion-fantasma", {self.siguienteFotograma()})
	}
	
	method moverDerecha() {
		position = game.at(position.x() + 1, position.y())
	}
	
	method moverIzquierda() {
		position = game.at(position.x() - 1, position.y())
	}
	
	method moverAriiba() {
		position = game.at(position.x(), position.y() + 1)
	}
	
	method moverAbajo() {
		position = game.at(position.x(), position.y() - 1)
	}
	
	method caer() {
		position = game.at(position.x(), position.y() - 1)
	}
		
	method cambiarDireccion() {
		if (direccion == "derecha"){
			direccion = "izquierda"
			gifActual = gifFantasmaIzquierda
			game.removeTickEvent("animacion-fantasma")
			self.animacion()
		} else{
			direccion = "derecha"
			gifActual = gifFantasmaDerecha
			game.removeTickEvent("animacion-fantasma")
			self.animacion()
		}
	}
	
	method hayVigaAbajo() {
		return stage1.vigas().any({ v => v == game.at(position.x(), position.y() - 1) })
	}
	
	method hayVigaIzquierda() {
		return stage1.vigas().any({ v => v == game.at(position.x() - 1, position.y() - 1) })
	}
	
	method hayVigaDerecha() {
		return stage1.vigas().any({ v => v == game.at(position.x() + 1, position.y() - 1) })
	}
	
	method hayEscalera() {
		return stage1.caidaBarril().any({ v => v == game.at(position.x(), position.y()) })
	}
	

	method recorrerVigas() {
		if (random.anyOne() == 3){
			self.cambiarDireccion()	
		}
		else if (direccion == "derecha" && self.hayVigaDerecha()) {
			gifActual = gifFantasmaDerecha
			game.removeTickEvent("animacion-fantasma")
			self.animacion()
			self.moverDerecha()
		} else if (direccion == "izquierda" && self.hayVigaIzquierda()) {
			gifActual = gifFantasmaIzquierda
			game.removeTickEvent("animacion-fantasma")
			self.animacion()
			self.moverIzquierda()///a cada rato cambia la animacion
			
		} else if (!self.hayVigaDerecha()) {
			self.cambiarDireccion()	
		} else {
			self.cambiarDireccion()	
		}
	// else if(direccion=="derecha" && self.hayVigaDerecha())self.moverDerecha()
	// else if(direccion=="izquierda" && self.hayVigaIzquierda())self.moverIzquierda()
	// else self.moverDerecha()
	}

	/*method dicidir(){
		if(random.anyOne()==3) self.bajarEscalera()
		else self.recorrerVigas()
	}*/	
	method moverse(){
		//if(estoyBajandoEscalera)self.bajarEscalera()
		//else if(self.hayEscalera())self.dicidir()
		//else 
		self.recorrerVigas()
	}
	
	method recorrerEscenario(){
		game.onTick(velocidad, "recorrido-fantasma", {self.moverse()})
	}
		/*method caerSiguienteViga(){
		if(self.hayVigaAbajo())
			self.cambiarDireccion() 
		else 
			self.caer()
	} //cambia animacion a normal*/
	
	/*method bajarEscalera(){
		if(self.hayVigaAbajo() && estoyBajandoEscalera){ //cambia animacion a escalera
			self.cambiarDireccion() //self.animacionIzquierda() game.removeTickEvent("animacion-derecha")
			estoyBajandoEscalera=false} 
		else{
			self.caer()
			estoyBajandoEscalera=true}}*/
			
	/*method subirEscalera(){
		if(self.hayVigaAbajo() && estoyBajandoEscalera){ //cambia animacion a escalera
			self.cambiarDireccion() //self.animacionIzquierda() game.removeTickEvent("animacion-derecha")
			estoyBajandoEscalera=false} 
		else{
			self.caer()
			estoyBajandoEscalera=true}}*/
			
	
	/*method esChocadoPor(otro){}
	
	method removerBarril(){
		game.removeVisual(self)
		position = game.at(5,14)
		direccion = "derecha"
		game.removeTickEvent("recorrido-barril")
		game.removeTickEvent("animacion-Barril")}
	
    method colisionadoPor(personaje){
		if(personaje.tieneMazo()){
			game.sound("assets/sonidos/get-item.wav").play()	
			game.say(mario, "¡100 Puntos!")
			personaje.eliminarBarril()}
		else 
			personaje.esChocadoPor(self)		
		self.removerBarril()}	*/
}

object prograFantasma {
	const f1 = new Fantasma()
	const f2 = new Fantasma()
	const f3 = new Fantasma()
	const f4 = new Fantasma()
	const f5 = new Fantasma()
	const fantasmas = [ f1, f2, f3, f4, f5 ]
	var posicion = 0
	var nroFantasma = fantasmas.first()

	method siguienteFantasma() {
		posicion = (posicion + 1) % fantasmas.size()
		nroFantasma = fantasmas.get(posicion)
	}

	method aniadirFantasma() {
		try {
			self.siguienteFantasma()
			game.addVisual(nroFantasma)
			nroFantasma.animacion()
			nroFantasma.recorrerEscenario()
			//game.onCollideDo(mario, { elemento => elemento.colisionadoPor(mario)})
			//game.onCollideDo(nroBarril, { personaje => personaje.esChocadoPor(nroFantasma)})
		} catch e : Exception {
			//nroFantasma.removerBarril()
			game.addVisual(nroFantasma)
			nroFantasma.animacion()
			nroFantasma.recorrerEscenario()
		}
		//game.onCollideDo(mario, { elemento => elemento.colisionadoPor(mario)})
		//game.onCollideDo(nroFantasma, { personaje => personaje.esChocadoPor(nroFantasma)})
	}

	/*method aniadirFantasmas() {
		self.aniadirFantasma()
		self.siguienteFantasma()
	}*/
}

//MAZO

object mazo {
	var property position= game.at(2,7)
	const stageEnQueSeMueveMario= mario.stageEnQueMeMuevo()

	method image(){
		return  "assets/objects/59.png"}
	
	method colisionadoPor(personaje){
		personaje.tieneMazo(true)
		game.removeVisual(self)
		self.activarMazo()}
	
	method moverDerechaConMazo(){
		mario.moverDerechaSiSePuede()
		mario.animarDerechaSiSePuede()
		if (stageEnQueSeMueveMario.hayCaidaDebajo()) mario.caer()}
	
	method moverIzquierdaConMazo(){
		mario.moverIzquierdaSiSePuede()
		mario.verificarVigaGanadora()
		mario.animarIzquierdaSiSePuede()
		if (stageEnQueSeMueveMario.hayCaidaDebajo()) mario.caer()}
	
	method activarMazo(){
		const rain = game.sound("assets/sonidos/background-3.mp3")	
		juego.musicaFondo().pause()
		sonidoMario.deObjeto()
		rain.play()
		rain.shouldLoop(true)
	 	game.onTick(8000, "movimiento",{ 
	 	mario.tieneMazo(false)
		rain.shouldLoop(false)
		juego.musicaFondo().resume()})}
}

class Palanca{
	const property position
	
	method image (){
		return "assets/objects/palanca.png"}		
		
	method consecuencias(){
		game.removeVisual(self)
		stage2.activarEscaleraNvl2()}}

const palanca1= new Palanca(position=game.at(13,1))
const palanca2= new Palanca(position=game.at(3,4))
const palanca3= new Palanca(position=game.at(9,7))
const palanca4= new Palanca(position=game.at(15,11))


class CosoAmarillo inherits Palanca{
	
	override method image(){
		return "assets/objects/90.png"}
	
	override method consecuencias(){
		game.removeVisual(self)}}

const coso1= new CosoAmarillo(position=game.at(5,4))
const coso2= new CosoAmarillo(position=game.at(14,4))
const coso3= new CosoAmarillo(position=game.at(1,7))
const coso4= new CosoAmarillo(position=game.at(12,7))	
const coso5= new CosoAmarillo(position=game.at(12,11))
const coso6= new CosoAmarillo(position=game.at(2,11))
const coso7= new CosoAmarillo(position=game.at(3,14))
const coso8= new CosoAmarillo(position=game.at(14,14))	