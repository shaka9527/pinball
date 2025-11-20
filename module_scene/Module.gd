extends Area2D

var life_time = 5.0
var elapsed_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("module")
	# 设置模块颜色为红色
	if has_node("Sprite2D"):
		var sprite = $Sprite2D
		sprite.modulate = Color(1, 0, 0, 1)  # 纯红色
	# 连接碰撞信号
	connect("area_entered", _on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time >= life_time:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	# 当与小球碰撞时
	if area.is_in_group(Enum.GROUP_NAME_AREA2D_BALL):
		# 发送信号通知小球分裂
		area.emit_signal("hit_module")
		# 模块消失
		queue_free()
