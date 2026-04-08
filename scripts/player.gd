extends CharacterBody2D

var run_speed = 350
var animated_sprite: AnimatedSprite2D

enum PlayerDirection {FRONT, BACK, SIDE_LEFT, SIDE_RIGHT, BACK34LEFT, BACK34RIGHT, FRONT34LEFT, FRONT34RIGHT}

func _ready() -> void:
	animated_sprite = get_node("PlayerSprite")


func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * run_speed
	var animation_direction: PlayerDirection
	if input_direction.x > 0:
		if input_direction.y > 0:
			animation_direction = PlayerDirection.FRONT34RIGHT
		elif input_direction.y < 0:
			animation_direction = PlayerDirection.BACK34RIGHT
		else:
			animation_direction = PlayerDirection.SIDE_RIGHT

	elif input_direction.x < 0:
		if input_direction.y > 0:
			animation_direction = PlayerDirection.FRONT34LEFT
		elif input_direction.y < 0:
			animation_direction = PlayerDirection.BACK34LEFT
		else:
			animation_direction = PlayerDirection.SIDE_LEFT
	
	else:
		if input_direction.y > 0:
			animation_direction = PlayerDirection.FRONT
		elif input_direction.y > 0:
			animation_direction = PlayerDirection.BACK


	animated_sprite.animation = get_animation_name(animation_direction)


func get_animation_name(direction: PlayerDirection) -> StringName:
	match (direction):
		PlayerDirection.BACK:
			return &"player_animation_b"
		PlayerDirection.FRONT:
			return &"player_animation_f"
		PlayerDirection.BACK34LEFT:
			return &"player_animation_b34l"
		PlayerDirection.BACK34RIGHT:
			return &"player_animation_b34r"
		PlayerDirection.FRONT34LEFT:
			return &"player_animation_f34l"
		PlayerDirection.FRONT34RIGHT:
			return &"player_animation_f34r"
		PlayerDirection.SIDE_LEFT:
			return &"player_animation_sl"
		PlayerDirection.SIDE_RIGHT:
			return &"player_animation_sr"
		_:
			return &"player_animation_f"


func _physics_process(_delta) -> void:
	get_input()
	move_and_slide()

func _process(_delta: float) -> void:
	pass
