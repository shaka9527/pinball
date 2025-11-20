extends Boundary

@export var playerName:String = ""
@export var playerType:int # 1 for left, 2 for right

const ACTION_NAME_UP:String = "Up"
const ACTION_NAME_DOWN:String = "Down"

var playerMoveSpeedParam:float = 11.2
var initial_panel_height:float = 0.0 # 初始面板高度
var consecutive_wins: int = 0
var score_multiplier: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 保存初始面板高度
	var color_rect = $ColorRect
	var collision_shape = $CollisionShape2D
	
	if color_rect:
		initial_panel_height = color_rect.size.y
	elif collision_shape and collision_shape.shape:
		initial_panel_height = collision_shape.shape.size.y
	
	# 确保初始面板高度不为零
	if initial_panel_height <= 0:
		initial_panel_height = 200.0 # 默认高度
	pass

# 设置面板高度
func set_panel_height(height: float):
	var color_rect = $ColorRect
	var collision_shape = $CollisionShape2D
	
	if color_rect:
		color_rect.size.y = height
	
	if collision_shape and collision_shape.shape:
		collision_shape.shape.size.y = height
	pass

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
