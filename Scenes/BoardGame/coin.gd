extends Node2D

@onready var CoinSprite := $CoinSprite

#Set the texture of the coin based on the player turn or the coin ability
func set_texture(coin_texture)-> void:
	CoinSprite.texture = coin_texture;
