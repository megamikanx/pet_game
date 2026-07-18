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


static var ITEM: Dictionary[ITEM_TYPE, Dictionary] = {
	ITEM_TYPE.Bath : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/bath.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Beer : {
		PRIORITY 	= 1,
		SPRITE 		= load("res://sprites/item_sprites/beer.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Burger : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/burger.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.DeadCarcass : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/carcass.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Chocolate : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/yakult.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.EnergyDrink : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/energy_drink.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Flower : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/flower.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Money : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/money.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Plushie : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/plushie.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.ProteinBar : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/protein_bar.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.BucketOfSlop : {
		PRIORITY 	= 2,
		SPRITE 		= load("res://sprites/item_sprites/bucketslop.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Speaker : {
		PRIORITY 	= 1,
		SPRITE 		= load("res://sprites/item_sprites/speaker.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Squishy : {
		PRIORITY 	= 3,
		SPRITE 		= load("res://sprites/item_sprites/squishy.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.TopHat : {
		PRIORITY 	= 0,
		SPRITE 		= load("res://sprites/item_sprites/tophat.png"),
		RAIDUS		= 150
	},
	ITEM_TYPE.Water : {
		PRIORITY 	= 1,
		SPRITE 		= load("res://sprites/item_sprites/water.png"),
		RAIDUS		= 150
	}
}


static var ADD_SPRITES : Dictionary[ITEM_TYPE, Dictionary] = {
	ITEM_TYPE.Beer : {
		SPRITE 		= preload("res://sprites/item_sprites/item_addition/sweat.png"),
		DIM 		= Vector3(5, -100, 2)
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
