extends Node

var hp = 175
var max_hp = 175
var attack_power = 60
var critical_chance = 40 #爆擊率40%
var critical_multiplier = 2 #爆擊倍率

@onready var animation_sprite: AnimationPlayer = $AnimationPlayer 
@onready var health_bar: ProgressBar = $HP 

func _ready():
	randomize() #為了讓克勞德有爆擊率
	if is_instance_valid(health_bar):
		health_bar.max_value = max_hp
		health_bar.value = hp
	play_animation("idle") # 初始播放 idle 動畫

func take_damage(damage: int):
	hp -= damage
	if is_instance_valid(health_bar):
		health_bar.value = hp
	print("Cloud受到", damage, "點傷害，剩餘:",hp)
	if hp <= 0:
		self.visible = false
		emit_signal("character_defeated", self) 

func play_animation(animation_name: String):
	if is_instance_valid(animation_sprite):
		animation_sprite.play(animation_name)

func get_attack_power() -> int:
	var final_damage = attack_power
	var roll = randi() % 100 + 1 #隨機生成1~100
	if roll <= critical_chance:
		final_damage = attack_power * critical_multiplier
		print("克勞德 !爆擊！ 造成 ", final_damage, " 點傷害。")
	else:
		print("克勞德 造成 ", final_damage, " 點傷害。")
	return final_damage

func is_alive() -> bool:
	return hp > 0
	
# 這個函數將由 BattleScene 調用
func do_attack_animation_and_get_damage() -> int:
	var final_damage = attack_power
	var roll = randi() % 100 + 1 # 隨機生成1~100

	if roll <= critical_chance:
		final_damage = int(attack_power * critical_multiplier) # 確保是整數傷害
		play_animation("attack") # 爆擊動畫
		#爆擊!!!!!
	else:
		play_animation("attack3") # 普通攻擊動畫
		#print(name, ": 普通攻擊，播放 'attack' 動畫，造成 ", final_damage, " 點傷害。")
		
	return final_damage

# 接收來自 Player 腳本的動畫播放指令 (當技能被選中時)
func _on_play_attack_animation():
	play_animation("attack")
	
