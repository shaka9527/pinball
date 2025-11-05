extends Control

@onready var start_stop_button = $StartStopButton
@onready var speed_buttons = $SpeedButtons
@onready var half_speed_button = $SpeedButtons/HalfSpeedButton
@onready var full_speed_button = $SpeedButtons/FullSpeedButton

var is_game_running = false
var rocket = null
var default_speed = Vector2(10, 10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Find the rocket node
	rocket = get_tree().get_root().get_node("Node/Ball")
	
	# Connect button signals
	start_stop_button.pressed.connect(_on_start_stop_button_pressed)
	half_speed_button.pressed.connect(_on_half_speed_button_pressed)
	full_speed_button.pressed.connect(_on_full_speed_button_pressed)
	
	# Initialize UI state
	_update_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle spacebar input
	if Input.is_action_just_pressed("ui_accept"):
		_on_start_stop_button_pressed()

func _on_start_stop_button_pressed():
	is_game_running = not is_game_running
	
	if is_game_running:
		start_stop_button.text = "Stop (Space)"
		# Ensure rocket has a velocity
		if rocket.positionMoveValue.length() == 0:
			rocket.positionMoveValue = default_speed
	else:
		start_stop_button.text = "Start (Space)"
		# Stop the rocket
		rocket.positionMoveValue = Vector2.ZERO
	
	_update_ui()

func _on_half_speed_button_pressed():
	default_speed = Vector2(5, 5)
	if rocket:
		rocket.positionMoveValue = default_speed

func _on_full_speed_button_pressed():
	default_speed = Vector2(10, 10)
	if rocket:
		rocket.positionMoveValue = default_speed

func _update_ui():
	# Show speed buttons only when game is stopped
	speed_buttons.visible = not is_game_running
	
	# Update button texts based on current speed
	if default_speed == Vector2(5, 5):
		half_speed_button.text = "Half Speed (Selected)"
		full_speed_button.text = "Full Speed"
	else:
		half_speed_button.text = "Half Speed"
		full_speed_button.text = "Full Speed (Selected)"