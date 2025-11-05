extends Area2D
@export var direction = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
	
func resetBallVec(ballArea2D:Area2D):
	var rawValueX = abs(ballArea2D[Enum.POSITION_MOVE_VALUE].x)
	var rawValueY = abs(ballArea2D[Enum.POSITION_MOVE_VALUE].y)
	
	if	direction == Enum.BOUNDARY_DIRECTION_BOTTOM :
		ballArea2D[Enum.POSITION_MOVE_VALUE].y = -rawValueY
	elif direction == Enum.BOUNDARY_DIRECTION_TOP :
		ballArea2D[Enum.POSITION_MOVE_VALUE].y = rawValueY
	elif direction == Enum.BOUNDARY_DIRECTION_RIGHT :
		ballArea2D[Enum.POSITION_MOVE_VALUE].x = -rawValueX
	elif direction == Enum.BOUNDARY_DIRECTION_LEFT :
		ballArea2D[Enum.POSITION_MOVE_VALUE].x = rawValueX
	pass
	
func _physics_process(delta: float) -> void:
	for i in get_overlapping_areas():
		if i.is_in_group(Enum.GROUP_NAME_AREA2D_BALL) :
			resetBallVec(i)
			pass
	pass
