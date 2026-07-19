extends Node

enum ITEM_TYPE {
	Bath,
	Beer,
	Burger,
	DeadCarcass,
	Chocolate,
	EnergyDrink,
	Flower,
	Money,
	Plushie,
	ProteinBar,
	BucketOfSlop,
	Speaker,
	Squishy,
	TopHat,
	Water
}

#chance out of ten
static var ITEM: Dictionary[ITEM_TYPE, Dictionary] = {
	ITEM_TYPE.Bath : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/bath.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Beer : {
		PRIORITY 	= 1,
		SPRITE 		= load("res://sprites/item_sprites/beer.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Burger : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/burger.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.DeadCarcass : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/carcass.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Chocolate : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/yakult.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.EnergyDrink : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/energy_drink.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Flower : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/flower.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Money : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/money.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Plushie : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/plushie.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.ProteinBar : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/protein_bar.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.BucketOfSlop : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/bucketslop.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Speaker : {
		PRIORITY 	= 1,
		SPRITE 		= load("res://sprites/item_sprites/speaker.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Squishy : {
		PRIORITY 	= 3,
		SPRITE 		= load("res://sprites/item_sprites/squishy.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.TopHat : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/tophat.png"),
		RADIUS		= 150,
		CHANCE		= 3
	},
	ITEM_TYPE.Water : {
		PRIORITY 	= 1,
		SPRITE 		= load("res://sprites/item_sprites/water.png"),
		RADIUS		= 150,
		CHANCE		= 3
	}
}


static var ADD_SPRITES : Dictionary[ITEM_TYPE, Dictionary] = {
	ITEM_TYPE.Beer : {
		SPRITE 		= preload("res://sprites/item_sprites/item_addition/blood.png"),
		DIM 		= Vector3(-35, -65, 2)
	},
	ITEM_TYPE.Money : {
		SPRITE 		= preload("res://sprites/item_sprites/money.png"),
		DIM 		= Vector3(-40, 0, 2)
	},
	ITEM_TYPE.TopHat : {
		SPRITE 		= preload("res://sprites/item_sprites/tophat.png"),
		DIM 		= Vector3(5, -100, 2)
	},
	ITEM_TYPE.Water : {
		SPRITE 		= preload("res://sprites/item_sprites/item_addition/sweat.png"),
		DIM 		= Vector3(40, -70, 2)
	}
}
