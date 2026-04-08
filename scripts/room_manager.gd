extends Node2D

const WIDTH_LEVEL = 600
const HEIGHT_LEVEL = 600
@export var number_subdivision = 4
@export_range(0.0, 1.0, 0.01) var min_range = 0.45
@export_range(0.0, 1.0, 0.01) var max_range = 0.55
var room_scene = preload("res://scenes/room.tscn")

var rng = RandomNumberGenerator.new()
var Rooms: Array[Room]
var sections: Array[Rect2] = []
var level: Node2D

func generate_subsections() -> Array[Rect2]:
	var subsections: Array[Rect2] = [Rect2(0, 0, WIDTH_LEVEL, HEIGHT_LEVEL)]
	for i in range(number_subdivision):
		var new_subsection: Array[Rect2] = []
		for subsection in subsections:
			var split_percent: float = rng.randf_range(min_range, max_range)
			var x_or_y_split: int = rng.randi() % 2

			if (x_or_y_split == 0):
				if (split_percent * subsection.size.x < .1 * WIDTH_LEVEL):
					x_or_y_split = 1
			if (x_or_y_split == 1):
				if (split_percent * subsection.size.y < .1 * HEIGHT_LEVEL):
					x_or_y_split = 0

			if (x_or_y_split == 0):
				var firstsub: Rect2 = Rect2(subsection.position.x, subsection.position.y,
					subsection.size.x * split_percent, subsection.size.y)
				var secondsub: Rect2 = Rect2(subsection.position.x + subsection.size.x * split_percent, subsection.position.y,
					subsection.size.x * (1 - split_percent), subsection.size.y)

				new_subsection.append(firstsub)
				new_subsection.append(secondsub)
			else:
				var firstsub: Rect2 = Rect2(subsection.position.x, subsection.position.y,
					subsection.size.x, subsection.size.y * split_percent)
				var secondsub: Rect2 = Rect2(subsection.position.x, subsection.position.y + subsection.size.y * split_percent,
					subsection.size.x, subsection.size.y * (1 - split_percent))

				new_subsection.append(firstsub)
				new_subsection.append(secondsub)
		subsections = new_subsection
	return subsections

func _ready() -> void:
	rng.randomize()


func generate_dungeon() -> void:
	sections = generate_subsections()
	for section in sections:
		var room = room_scene.instantiate()
		add_child(room)
		room.position = section.position
		room.set_dimensions(section.size)
		room.generate()

func _draw():
	for i in sections:
		print(i)
		draw_rect(Rect2(int(i.position.x), int(i.position.y),
			int(i.size.x), int(i.size.y)), Color.GREEN, false, 1.0)


func _on_button_pressed() -> void:
	for child in get_children():
		child.queue_free()
	generate_dungeon()
	queue_redraw()
