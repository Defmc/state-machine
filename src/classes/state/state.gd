class_name State

extends Node

var entity : KinematicBody2D = null
var move : Vector2 = Vector2.ZERO
var specs : Dictionary = {}

func _setup(entity : KinematicBody2D) -> void:
	self.entity = entity
	
func _physics_process(delta):
	entity.move_and_slide(move, Vector2.UP)

func idle() -> void:
	pass

func move_left() -> void:
	pass

func move_right() -> void:
	pass

func jump() -> void:
	pass
