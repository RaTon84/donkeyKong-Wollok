import wollok.game.*
object barril {
	method position()=game.at(5,16)
	method image() = "assets/objects/1.png" 
}
/*object barrilEnMovimiento{
	var property position = game.at(5,16)
  	method image() = "assets/objects/86.png"
  	method movete() {
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)
    position = game.at(x,y) 
    game.onTick(2000, "movimiento", { self.movete() })	
  }
  } */


 
  

