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
	
	var winner_type:int
	var loser_type:int
	
	if positionMoveValue.x < 0 :
		# 球从左边界飞出，右侧玩家得分
		winner_type = ScoreCounter.SCORE_TYPE.RIGHT
		loser_type = ScoreCounter.SCORE_TYPE.LEFT
	elif positionMoveValue.x > 0 :
		# 球从右边界飞出，左侧玩家得分
		winner_type = ScoreCounter.SCORE_TYPE.LEFT
		loser_type = ScoreCounter.SCORE_TYPE.RIGHT
	
	# 更新得分和连胜
	update_score_and_consecutive_wins(winner_type, loser_type)
	pass

func update_score_and_consecutive_wins(winner_type:int, loser_type:int):
	# 获取赢家和输家的分数数据
	var winner_score = ScoreCounter.scoreDB[winner_type - 1]
	var loser_score = ScoreCounter.scoreDB[loser_type - 1]
	
	# 计算加分前的乘数和连胜，用于后续可能的扣除
	var old_winner_multiplier = winner_score.scoreMultiplier
	
	# 增加赢家的连胜次数
	winner_score.consecutiveWins += 1
	
	# 计算得分乘数
	var multiplier = 1
	if winner_score.consecutiveWins >= 6:
		multiplier = 2  # 连续击败6次，得分能力变为初始的二倍
	elif winner_score.consecutiveWins >= 3:
		multiplier = 1  # 连续击败3次，得分能力变为初始的一倍
	
	# 更新得分乘数
	winner_score.scoreMultiplier = multiplier
	
	# 增加得分
	winner_score.scoreValue += multiplier
	
	# 重置输家的连胜和得分乘数
	var old_loser_multiplier = loser_score.scoreMultiplier
	loser_score.consecutiveWins = 0
	loser_score.scoreMultiplier = 1
	
	# 计算输家需要扣除的额外得分
	if old_loser_multiplier > 1:
		# 输家之前有额外得分，需要扣除
		var extra_points = old_loser_multiplier - 1
		loser_score.scoreValue -= extra_points
		# 确保分数不低于0
		if loser_score.scoreValue < 0:
			loser_score.scoreValue = 0
	
	# 更新玩家面板大小
	update_player_panel_size()
	pass

func update_player_panel_size():
	# 获取场景中的玩家节点
	var left_player = get_tree().get_root().get_node("Node/PlayerScene/player1")  # 根据实际场景结构修改
	var right_player = get_tree().get_root().get_node("Node/PlayerScene/player2")  # 根据实际场景结构修改
	
	# 更新左侧玩家面板
	if left_player:
		var left_score = ScoreCounter.scoreDB[ScoreCounter.SCORE_TYPE.LEFT - 1]
		var new_height = left_player.initial_panel_height
		
		if left_score.consecutiveWins >= 6:
			new_height = left_player.initial_panel_height * (1/3)  # 缩短为初始的1/3
		elif left_score.consecutiveWins >= 3:
			new_height = left_player.initial_panel_height * (2/3)  # 缩短为初始的2/3
		
		left_player.set_panel_height(new_height)
	
	# 更新右侧玩家面板
	if right_player:
		var right_score = ScoreCounter.scoreDB[ScoreCounter.SCORE_TYPE.RIGHT - 1]
		var new_height = right_player.initial_panel_height
		
		if right_score.consecutiveWins >= 6:
			new_height = right_player.initial_panel_height * (1/3)  # 缩短为初始的1/3
		elif right_score.consecutiveWins >= 3:
			new_height = right_player.initial_panel_height * (2/3)  # 缩短为初始的2/3
		
		right_player.set_panel_height(new_height)
	pass
	
