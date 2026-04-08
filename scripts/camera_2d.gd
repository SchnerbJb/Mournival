extends Camera2D

var player: Node2D

func _ready() -> void:
	player = get_node("/root/World/Player")

func _process(_delta: float) -> void:
	pass
