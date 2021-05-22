#01. tool
#02. class_name
#03. extends
#04. # docstring
#
#05. signals
#06. enums
#07. constants
#08. exported variables
#09. public variables
#10. private variables
#11. onready variables
#
#12. optional built-in virtual _init method
#13. built-in virtual _ready method
#14. remaining built-in virtual methods
#15. public methods
#16. private methods

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
