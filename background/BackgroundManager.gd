extends Node

var module_scene = preload("res://module_scene/module.tscn")
var module_timer = Timer.new()
var max_modules = 4
var module_interval = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 设置定时器
	module_timer.wait_time = module_interval
	module_timer.autostart = true
	module_timer.timeout.connect(_on_module_timer_timeout)
	add_child(module_timer)

func _on_module_timer_timeout() -> void:
	# 检查当前模块数量是否小于最大值
	var current_modules = get_tree().get_nodes_in_group("module")
	if current_modules.size() < max_modules:
		# 在场景中随机位置生成模块
		var module = module_scene.instantiate()
		var random_x = randf_range(100, 1820)  # 避免太靠近边界
		var random_y = randf_range(50, 1030)
		module.position = Vector2(random_x, random_y)
		get_parent().add_child(module)

# 随机数生成辅助函数
func randf_range(min_val: float, max_val: float) -> float:
	return randf() * (max_val - min_val) + min_val
