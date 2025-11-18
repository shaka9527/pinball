extends Area2D

signal hit_module  # 碰撞模块的信号

var defaultPosition:Vector2 = Vector2(0, 0)

var positionMoveValue = Vector2(10, 10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(Enum.GROUP_NAME_AREA2D_BALL)
	
	defaultPosition = position
	# 连接碰撞模块信号
	hit_module.connect(_on_hit_module)
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

# 碰撞模块时的处理函数
func _on_hit_module() -> void:
	# 检查当前场上小球数量是否小于4个
	var current_balls = get_tree().get_nodes_in_group(Enum.GROUP_NAME_AREA2D_BALL)
	if current_balls.size() >= 4:
		return
	
	# 获取主场景节点
	var main_scene = get_parent()
	if main_scene == null:
		return
	
	# 生成两个新的小球
	for i in range(2):
		# 加载小球场景
		var ball_scene = preload("res://rocket_scene/area_2d.tscn")
		var new_ball = ball_scene.instantiate()
		
		# 设置新小球的位置为碰撞位置，确保继承父节点位置
		new_ball.position = self.global_position
		# Sprite2D现在直接作为Area2D的子节点，位置会相对于Area2D节点
		# 无需额外调整Sprite2D位置，保持默认即可
		
		# 计算新小球的运动方向
		# 原小球运动方向的垂直向右方向
		# 例如：原方向是(10,5)，垂直向右方向是(-5,10)
		var new_dir = Vector2(-positionMoveValue.y, positionMoveValue.x)
		# 随机决定新方向的正负，增加游戏的变化性
		if i == 1:
			new_dir = -new_dir
		
		# 设置新小球的运动速度
		new_ball.positionMoveValue = new_dir.normalized() * positionMoveValue.length()
		
		# 将新小球添加到主场景
		main_scene.add_child(new_ball)
	
