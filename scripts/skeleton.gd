extends Monster


func _ready() -> void:
	health = 10
	speed = 10.0
	current_state = Behaviour.IDLE
