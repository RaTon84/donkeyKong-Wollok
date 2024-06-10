import wollok.game.*
import juego.*

object mario {
	var property position=game.at(0,1)
	method image(){
		return "assets/personajes/mario/21.png"}
		
	keyboard.right().onPressDo({pacman.moverDerecha()})
}
