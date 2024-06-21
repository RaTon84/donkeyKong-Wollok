import wollok.game.*
import mario.*
import juego.*


class Stage{
	const property vigas=[]
	const property escaleras=[]
	const property caidaBarril=[]
	const property caidas=[]
	const property image=null
	
	
	method hayVigaDebajo()= vigas.any{v=>v==mario.obtenerPosicionAbajo()}
	
	method hayCaidaDebajo()=caidas.any{c=>c==mario.obtenerPosicionAbajo()}
	
	method hayEscaleraArriba()= escaleras.any{v=>v==mario.obtenerPosicionArriba()}
	
	method hayEscaleraDebajo()= escaleras.any{v=>v==mario.position()}
	
	method position(){
		return game.at(0,0)}
}


const stage1= new Stage(vigas=[game.at(0,0),game.at(1,0),game.at(2,0),game.at(3,0),game.at(4,0),game.at(5,0),game.at(6,0),game.at(7,0),game.at(8,0),game.at(9,0),game.at(10,0),game.at(11,0),game.at(12,0),game.at(13,0),game.at(14,0),game.at(15,0),game.at(16,0),game.at(17,0),
				game.at(0,3),game.at(1,3),game.at(2,3),game.at(3,3),game.at(4,3),game.at(5,3),game.at(6,3),game.at(7,3),game.at(8,3),game.at(9,3),game.at(10,3),game.at(11,3),game.at(12,3),game.at(13,3),game.at(14,3),game.at(15,3),game.at(16,3),
				game.at(1,5),game.at(2,5),game.at(3,5),game.at(4,5),game.at(5,5),game.at(6,5),game.at(7,5),game.at(8,5),game.at(9,5),game.at(10,5),game.at(11,5),game.at(12,5),game.at(13,5),game.at(14,5),game.at(15,5),game.at(16,5),game.at(17,5),
				game.at(0,8),game.at(1,8),game.at(2,8),game.at(3,8),game.at(4,8),game.at(5,8),game.at(6,8),game.at(7,8),game.at(8,8),game.at(9,8),game.at(10,8),game.at(11,8),game.at(12,8),game.at(13,8),game.at(14,8),game.at(15,8),game.at(16,8),
				game.at(17,11),game.at(1,11),game.at(2,11),game.at(3,11),game.at(4,11),game.at(5,11),game.at(6,11),game.at(7,11),game.at(8,11),game.at(9,11),game.at(10,11),game.at(11,11),game.at(12,11),game.at(13,11),game.at(14,11),game.at(15,11),game.at(16,11),
				game.at(1,13),game.at(2,13),game.at(3,13),game.at(4,13),game.at(5,13),game.at(6,13),game.at(7,13),game.at(8,13),game.at(9,13),game.at(10,13),game.at(11,13),game.at(12,13),game.at(13,13),game.at(14,13),game.at(15,13),game.at(16,13),game.at(0,13),
				game.at(7,15),game.at(8,15),game.at(9,15)],
				
				escaleras=[game.at(15,4),game.at(15,2),game.at(15,3),game.at(2,6),game.at(2,5),game.at(8,6),game.at(8,5),game.at(9,9),game.at(9,7),game.at(9,8),game.at(15,9),
				game.at(15,7),game.at(15,8),game.at(2,12),game.at(2,10),game.at(2,11),game.at(5,12),game.at(5,10),game.at(5,11), game.at(15,14),game.at(15,13),game.at(5,118),
				game.at(5,15),game.at(5,16),game.at(5,17),game.at(6,18),game.at(6,15),game.at(6,16),game.at(6,17),game.at(10,16),game.at(10,15)],
				
				caidaBarril=[game.at(5,4),game.at(15,4),game.at(2,6),game.at(8,6),game.at(9,9),game.at(15,8),game.at(2,12),game.at(5,12),game.at(12,11),game.at(8,14),game.at(15,14)],//(da problemas al barril ,game.at(5,9))
				
				caidas=[game.at(17,3),game.at(0,5),game.at(17,8),game.at(0,11),game.at(17,13),game.at(11,15)],
				
				image="assets/fondo/fondoNvl1.png"
				)
				

const stage2= new Stage(vigas=[game.at(0,0),game.at(1,0),game.at(2,0),game.at(3,0),game.at(4,0),game.at(5,0),game.at(6,0),game.at(7,0),game.at(8,0),game.at(9,0),game.at(10,0),game.at(11,0),game.at(12,0),game.at(13,0),game.at(14,0),game.at(15,0),game.at(16,0),game.at(17,0),
				game.at(1,3),game.at(2,3),game.at(3,3),game.at(5,3),game.at(6,3),game.at(7,3),game.at(8,3),game.at(9,3),game.at(10,3),game.at(11,3),game.at(12,3),game.at(14,3),game.at(15,3),game.at(16,3),
				game.at(1,6),game.at(2,6),game.at(3,6),game.at(5,6),game.at(6,6),game.at(7,6),game.at(8,6),game.at(9,6),game.at(10,6),game.at(11,6),game.at(12,6),game.at(14,6),game.at(15,6),game.at(16,6),
				game.at(2,10),game.at(3,10),game.at(5,10),game.at(6,10),game.at(7,10),game.at(8,10),game.at(9,10),game.at(10,10),game.at(11,10),game.at(12,10),game.at(14,10),game.at(15,10),
				game.at(3,13),game.at(5,13),game.at(6,13),game.at(7,13),game.at(8,13),game.at(9,13),game.at(10,13),game.at(11,13),game.at(12,13),game.at(14,13),
				game.at(5,16),game.at(6,16),game.at(7,16),game.at(8,16),game.at(9,16),game.at(10,16),game.at(11,16),game.at(12,16)],
				
				escaleras=[game.at(1,1),game.at(1,2),game.at(1,3),game.at(9,1),game.at(9,2),game.at(9,3),game.at(16,1),game.at(16,2),game.at(16,3),
				game.at(2,4),game.at(2,5),game.at(2,6),game.at(7,4),game.at(7,5),game.at(7,6),game.at(11,4),game.at(11,5),game.at(11,6),game.at(15,4),game.at(15,5),game.at(15,6),
				game.at(3,7),game.at(3,8),game.at(3,9),game.at(3,10),game.at(14,7),game.at(14,8),game.at(14,9),game.at(14,10),
				game.at(9,11),game.at(9,12),game.at(9,13)],
				
				caidaBarril=[/*hernan lo tiene que rellenar */],
				
				caidas=[game.at(0,3),game.at(4,3),game.at(13,3),game.at(17,3),
				game.at(0,6),game.at(4,6),game.at(13,6),game.at(17,6),
				game.at(1,10),game.at(4,10),game.at(13,10),game.at(16,10),
				game.at(2,13),game.at(4,13),game.at(13,13),game.at(15,13)],
				
				image="assets/fondo/fondoNv2-0.png"
				)
				






