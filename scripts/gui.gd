extends Node

@onready var player = $"/root/World/Player"
@onready var stamina_bar = $"StaminaBar"

func _ready() -> void:
	stamina_bar.value = player.stamina

func _on_player_stamina_change() -> void:
	stamina_bar.value = player.stamina
