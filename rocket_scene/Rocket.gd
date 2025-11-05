extends Area2D

var defaultPosition:Vector2 = Vector2(0, 0)

var positionMoveValue = Vector2(10, 10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(Enum.GROUP_NAME_AREA2D_BALL)
	
	defaultPosition = position
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += positionMoveValue
	
	if isTargetObjOutBoundary(position):
		resetPosition()
	pass
	
func isTargetObjOutBoundary(position :Vector2) -> bool:
	if position.x > (Enum.SCENE_ORIGIN_POSITION.x + Enum.SCENE_WIDE):
		return true
	if position.x < Enum.SCENE_ORIGIN_POSITION.x:
		return true
	return false
	
func setPosition(targetPosition:Vector2):
	self.position = targetPosition
	pass

func resetPosition():
	setPosition(defaultPosition)
	
	if positionMoveValue.x < 0 :
		ScoreCounter.scoreUp(ScoreCounter.SCORE_TYPE.RIGHT
		,ScoreCounter.SCORE_LEVE.LEVEL1)
	elif positionMoveValue.x > 0 :
		ScoreCounter.scoreUp(ScoreCounter.SCORE_TYPE.LEFT
		,ScoreCounter.SCORE_LEVE.LEVEL1)
		
	pass
	
