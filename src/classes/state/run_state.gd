class_name RunState

extends State

func idle() -> void:
	pass

func move_left() -> void:
	move.x = -specs["speed"]
	move.y = specs["gravity"]

func move_right() -> void:
	move.x = +specs["speed"]
	move.y = specs["gravity"]

func jump() -> void:
	pass
