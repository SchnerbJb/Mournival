extends AnimatedSprite2D

signal start_hit_frames
signal start_recovery_frames

func _process(_delta: float) -> void:
    if frame == 6:
        start_hit_frames.emit()
    if frame == 9:
        start_recovery_frames.emit()