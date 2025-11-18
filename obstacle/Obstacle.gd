extends Area2D

var life_time = 1.0
var elapsed_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("obstacle")
	# 设置碰撞层和掩码，确保与火箭碰撞
	collision_layer = 1
	collision_mask = 1
	# 连接碰撞信号
	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time >= life_time:
		# 死亡后立即生成新的障碍
		queue_free()

func _on_body_entered(body):
	# 处理与火箭的碰撞，这里我们只需要反弹，所以不需要额外处理
	pass

func _on_area_entered(area):
	# 处理与火箭的碰撞反弹
	if area.is_in_group(Enum.GROUP_NAME_AREA2D_BALL):
		# 简单的反弹实现：反转x和y方向
		area.positionMoveValue = Vector2(-area.positionMoveValue.x, -area.positionMoveValue.y)
