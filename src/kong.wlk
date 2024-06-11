import wollok.game.*

object kong{
	var property position = game.at(6,16)
	var property image = "assets/personajes/donkeyKong/14.png"
	method iniciarKong(){
		//keyboard.right().onPressDo{self.image("assets/personajes/donkeyKong/14.png")}
		//keyboard.left().onPressDo{self.image("assets/personajes/donkeyKong/1.png")}
		game.onTick(2200, "movimiento", { self.position(game.at(8,16)) })
		game.onTick(1860, "movimiento", { self.image("assets/personajes/donkeyKong/1.png") })
		game.onTick(2000, "movimiento", { self.position(game.at(6,16)) })
		game.onTick(2200, "movimiento", { self.image("assets/personajes/donkeyKong/8.png") })
		
	}
	
}
	