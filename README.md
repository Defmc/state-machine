# State Machine class for Godot 3

A simple and efficient class for Godot aimed at the expansion of states based on the inheritance of the `State` class and machine management by `StateFactory`.

## How to use

### Declaring methods

At end of `State.gd`, place yours common functions:

```gdscript
...

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
```

### Inheritance of `State`

After inheriting from `State`, just replace the common functions:

```gdscript
class_name IdleState

extends State

func idle() -> void:
	move.y += specs["gravity"]

func move_left() -> void:
	pass

func move_right() -> void:
	pass

func jump() -> void:
	pass
```

### Adding states to the `StateFactory`'s object

To define your states, just go to the `StateFactory` instantiation and use the` add_state` method to add a state followed by your class. Now, to add a group of states, use `add_states` instead of` add_state` passing 2 arrays, the first for the state names and the second for the state classes:

```gdscript
func _ready() -> void:
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
```

### Adding attributes to the `StateFactory`'s object

Just define the `specs` value of the` StateFactory` object as a dictionary declaration (key - value):

```gdscript
	state_factory.specs = {
		"speed" : 100,
		"gravity" : 98
	}
```