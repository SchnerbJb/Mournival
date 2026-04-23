extends CharacterBody2D

@export var hp: int = 10
@export var stamina: int = 10
@export var current_state: PlayerState = PlayerState.IDLE
var run_speed = 350
var animated_sprite: AnimatedSprite2D
@onready var hitbox = $"Hitbox"

enum PlayerDirection {FRONT, BACK, SIDE_LEFT, SIDE_RIGHT, BACK34LEFT, BACK34RIGHT, FRONT34LEFT, FRONT34RIGHT}
enum PlayerState {IDLE, WALK, START_ATTACK, ATTACKING, END_ATTACK, PARRY}

func _ready() -> void:
	animated_sprite = get_node("PlayerSprite")
	

func get_input() -> void:
	if current_state != PlayerState.START_ATTACK \
		and current_state != PlayerState.ATTACKING \
		and current_state != PlayerState.END_ATTACK:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		velocity = input_direction * run_speed

		if velocity != Vector2(0, 0):
			current_state = PlayerState.WALK
		
	if Input.is_action_just_pressed("first_ability"):
		attack_one()

func stop_before_attack():
	velocity = Vector2(0, 0)
	current_state = PlayerState.START_ATTACK


func attack_one() -> void:
	stop_before_attack()
	animated_sprite.play(&"player_animation_b_attack")
	var hit_box = Area2D.new()
	add_child(hit_box)

func attack_two() -> void:
	pass
func attack_three() -> void:
	pass
func parry() -> void:
	pass


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
	if current_state != PlayerState.START_ATTACK \
		and current_state != PlayerState.ATTACKING \
		and current_state != PlayerState.END_ATTACK:
		var animation_direction: PlayerDirection
		if velocity.x > 0:
			if velocity.y > 0:
				animation_direction = PlayerDirection.FRONT34RIGHT
			elif velocity.y < 0:
				animation_direction = PlayerDirection.BACK34RIGHT
			else:
				animation_direction = PlayerDirection.SIDE_RIGHT

		elif velocity.x < 0:
			if velocity.y > 0:
				animation_direction = PlayerDirection.FRONT34LEFT
			elif velocity.y < 0:
				animation_direction = PlayerDirection.BACK34LEFT
			else:
				animation_direction = PlayerDirection.SIDE_LEFT
		
		else:
			if velocity.y > 0:
				animation_direction = PlayerDirection.FRONT
			elif velocity.y < 0:
				animation_direction = PlayerDirection.BACK


		animated_sprite.animation = get_animation_name(animation_direction)
	
	match current_state:
		PlayerState.ATTACKING:
			hitbox.monitoring = true
		PlayerState.END_ATTACK:
			hitbox.monitoring = false


func _on_player_sprite_start_hit_frames() -> void:
	current_state = PlayerState.ATTACKING

func _on_player_sprite_start_recovery_frames() -> void:
	current_state = PlayerState.END_ATTACK


func _on_player_sprite_animation_finished() -> void:
	current_state = PlayerState.IDLE


func _on_hitbox_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Skeleton":
		body.queue_free()
