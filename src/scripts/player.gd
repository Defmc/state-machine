class_name Player

extends KinematicBody2D

enum States{
	STOPED,
	WALKING,
	JUMPING
}

export(int) var speed = 400
export(int) var jump_force = 600

var state_factory : StateFactory
var move : Vector2 = Vector2.ZERO

func _ready():
	state_factory = StateFactory.new(self, $AnimationTree.get("parameters/playback"))
	state_factory.add_states(
		[
			"idle_state",
			"run_state"
		],
		[
			IdleState,
			RunState
		])
	state_factory.specs = {
		"speed" : 100,
		"gravity" : 98
	}

func _physics_process(_delta):
	move.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if move.x != 0:
		state_factory.change_state("run_state")
		if move.x > 0:
			state_factory.actual_state.move_right()
		elif move.x < 0:
			state_factory.actual_state.move_left()
	else:
		state_factory.change_state("idle_state")
		state_factory.actual_state.idle()
