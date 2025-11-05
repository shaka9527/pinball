extends Node

class Score : 
	var scoreType:int
	var scoreValue:int
	
	func _init(scoreType:int, scoreValue:int) -> void:
		self.scoreType = scoreType
		self.scoreValue = scoreValue
 
enum SCORE_TYPE {LEFT = 1, RIGHT = 2}
enum SCORE_LEVE {LEVEL1 = 1, LEVEL2 = 2}

var scoreDB :Array[Score] = [Score.new(SCORE_TYPE.LEFT, 0), Score.new(SCORE_TYPE.RIGHT, 0)]

func scoreUp(scoreType :int, scoreLevel :int):
	for db in scoreDB :
		if db.scoreType == scoreType:
			db.scoreValue += scoreLevel
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
