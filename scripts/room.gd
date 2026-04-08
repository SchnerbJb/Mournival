class_name Room
extends Node2D

var width: int = 1
var height: int = 1
var block_scene = preload("res://scenes/block.tscn")
var blocks: Array[Block] = []

func set_dimensions(dimensions: Vector2) -> void:
	width = int(dimensions.x)
	height = int(dimensions.y)

func generate() -> void:
	for i in (width / 10.0) - 5:
		for j in (height / 10.0) - 5:
			var block = block_scene.instantiate()
			block.position = Vector2(10 * i + 20, 10 * j + 20)
			add_child(block)
