extends Label

@export var scoreType:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for db in ScoreCounter.scoreDB:
		if db.scoreType == scoreType:
			text = String.num_int64(db.scoreValue)
			break
			
	pass
