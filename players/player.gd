extends Boundary

@export var playerName:String = ""

const ACTION_NAME_UP:String = "Up"

const ACTION_NAME_DOWN:String = "Down"

var playerMoveSpeedParam:float = 11.2

func _physics_process(delta: float) -> void:
	for i in get_overlapping_areas():
		if i.is_in_group(Enum.GROUP_NAME_AREA2D_BALL) :
			var audio:AudioStreamPlayer = get_parent().get_node(Enum.SOUND_NAME_HIT)
			audio.play()
			resetBallVec(i)
			pass
	
	positonControll()
	pass
	
func positonControll():
	var upValue = Input.get_action_strength(playerName + ACTION_NAME_UP)
	var downValue = Input.get_action_strength(playerName + ACTION_NAME_DOWN)
	
	position.y = position.y + (downValue - upValue)*playerMoveSpeedParam
	
	pass
