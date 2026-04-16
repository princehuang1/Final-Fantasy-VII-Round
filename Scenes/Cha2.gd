extends Node

var hp = 160
var max_hp = 160
var attack_power = 80

@onready var animation_sprite: AnimationPlayer = $AnimationPlayer
@onready var health_bar: ProgressBar = $HP # 假設有 HealthBar 子節點

func _ready():
	if is_instance_valid(health_bar):
		health_bar.max_value = max_hp
		health_bar.value = hp
	play_animation("idle") # 初始播放 idle 動畫

func take_damage(damage: int):
	hp -= damage
	if is_instance_valid(health_bar):
		health_bar.value = hp
	print("蒂法受到", damage, "點傷害，剩餘:",hp)
	if hp <= 0:
		self.visible = false
		emit_signal("character_defeated", self) # 如果需要在 Player 腳本中監聽死亡，可以發出信號

func play_animation(animation_name: String):
	if is_instance_valid(animation_sprite):
		animation_sprite.play(animation_name)

func get_attack_power() -> int:
	return attack_power

func is_alive() -> bool:
	return hp > 0

# 接收來自 Player 腳本的動畫播放指令 (當技能被選中時)
func _on_play_attack_animation():
	play_animation("attack")
	# 在這裡可以添加攻擊動畫播放完成後的處理邏輯
	# 例如，發出一個信號通知 Player 或 BattleScene 進行後續操作
