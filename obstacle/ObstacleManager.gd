extends Node

# 障碍管理器，负责生成和管理障碍

@export var obstacle_scene: PackedScene
@export var max_obstacles = 4
@export var obstacle_lifetime = 1.0

var obstacles = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 初始化随机数生成器
	randomize()
	# 立即生成初始障碍
	spawn_initial_obstacles()

# 生成初始障碍
func spawn_initial_obstacles():
	for i in range(max_obstacles):
		spawn_obstacle()

# 生成单个障碍
func spawn_obstacle():
	if not obstacle_scene:
		return
	
	var obstacle = obstacle_scene.instantiate()
	
	# 随机选择玩家区域
	var player_area = "player1" if randf() < 0.5 else "player2"
	
	# 在玩家区域内随机生成障碍位置
	var position = Vector2()
	if player_area == "player1":
		# 玩家1区域：左侧到中间
		position.x = 50 + randf() * (Enum.SCENE_WIDE / 2 - 100)
	else:
		# 玩家2区域：中间到右侧
		position.x = Enum.SCENE_WIDE / 2 + 50 + randf() * (Enum.SCENE_WIDE / 2 - 100)
	
	position.y = 50 + randf() * (Enum.SCENE_HEIGHT - 100)
	
	obstacle.position = position
	obstacle.life_time = obstacle_lifetime
	
	# 监听障碍销毁信号，以便重新生成
	obstacle.tree_exited.connect(func(): 
		if obstacles.has(obstacle):
			obstacles.erase(obstacle)
		spawn_obstacle()
	)
	
	add_child(obstacle)
	obstacles.append(obstacle)

# 清理所有障碍
func cleanup():
	for obstacle in obstacles:
		if obstacle:
			obstacle.queue_free()
	obstacles.clear()