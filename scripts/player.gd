extends CharacterBody2D

var run_speed = 350
var animation: AnimatedSprite2D

func _ready() -> void:
	animation = get_node("AnimatedSprite2D")
	animation.visible = false

func get_input() -> void:
	look_at(get_global_mouse_position())
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * run_speed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack()

func attack() -> void:
	animation.visible = true
	animation.play()

func _physics_process(_delta) -> void:
	get_input()
	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	animation.visible = false
