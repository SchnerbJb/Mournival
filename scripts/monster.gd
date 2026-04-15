extends RigidBody2D
class_name Monster

enum Behaviour {THINK, IDLE, CHASE, ATTACK, FLEE}

@export var health: int = 10
@export var speed: float = 10.0
@export var current_state: Behaviour = Behaviour.IDLE
