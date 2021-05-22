class_name StateFactory

extends Node

export(NodePath) var state_machine_node

onready var state_machine : AnimationNodeStateMachine = null

var states : Dictionary = {}
var specs : Dictionary = {}
var entity : KinematicBody2D = null

var actual_state : State = null
var actual_state_name : String = ""

func _init(entity : KinematicBody2D, state_machine : AnimationNodeStateMachine):
	self.entity = entity
	self.state_machine = state_machine

func add_state(state_name : String,
			   state_class) -> void:
	states[state_name] = state_class
	
func add_states(state_names : PoolStringArray,
				state_classes) -> void:
	for i in state_names.size():
		add_state(state_names[i], state_classes[i])

func change_state(state_name : String) -> void:
	if state_name == actual_state_name:
		return
	
	if actual_state != null:
		actual_state.queue_free()
	
	if states.has(state_name):
		actual_state = states[state_name].new()
		actual_state._setup(entity)
		if state_machine != null:
			state_machine.travel("state_name")
		actual_state_name = state_name
		actual_state.specs = specs
		entity.add_child(actual_state)
	else:
		printerr("Error in StateFactory: " + state_name + " isn't declared in 'states'. Consider add the state before call 'change_state'")
