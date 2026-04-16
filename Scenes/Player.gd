# Player的腳本
extends Node

signal character_defeated(character_node)

@onready var cha1 = $Cha1
@onready var cha2 = $Cha2
@onready var cha3 = $Cha3

var characters = []

func _ready():
	characters = [cha1, cha2, cha3]
	for character in characters: # <-- 這裡有問題，應該是 'character' 而不是 'char'
		if is_instance_valid(character): # <-- 這裡有問題，應該是 'character' 而不是 'char'
			character.play_animation("idle")
			character.connect("character_defeated", _on_character_defeated) # Connect the signal

func _on_skill_selected(skill_index: int):
	if skill_index == 0 and is_instance_valid(cha1):
		cha1._on_play_attack_animation()
		# 在 Cha1 的動畫播放完畢後，通知 BattleScene 進行後續處理
	elif skill_index == 1 and is_instance_valid(cha2):
		cha2._on_play_attack_animation()
		# 在 Cha2 的動畫播放完畢後，通知 BattleScene 進行後續處理
	elif skill_index == 2 and is_instance_valid(cha3):
		cha3._on_play_attack_animation()
		# 在 Cha3 的動畫播放完畢後，通知 BattleScene 進行後續處理

func get_all_alive_characters() -> Array:
	var alive = []
	for character in characters:
		if is_instance_valid(character) and character.is_alive():
			alive.append(character)
	return alive

func _on_character_defeated(character_node):
	print("Character defeated:", character_node.name) # For debugging
	# BattleScene 已經處理了隱藏和檢查戰鬥結束，這裡可以只做額外處理
	# 例如，從內部列表中移除角色，如果 Player 腳本有維護這樣的列表
	pass # 這裡不需要額外操作，因為 BattleScene 會處理

# 新增這個函數：治療所有存活的玩家角色
func heal_all_characters(amount: int):
	var all_characters = [cha1, cha2, cha3] # 包含所有角色的陣列

	for char_node in all_characters:
		if is_instance_valid(char_node) and char_node.is_alive():
			var new_hp = min(char_node.hp + amount, char_node.max_hp) # 不超過最大生命值
			char_node.hp = new_hp
			if is_instance_valid(char_node.health_bar):
				char_node.health_bar.value = char_node.hp
			print(char_node.name, " 回復了 ", amount, " 點 HP, 目前 HP: ", char_node.hp)

# 新增這個函數：重置所有玩家角色的狀態
func reset_characters():
	if is_instance_valid(cha1):
		cha1.hp = cha1.max_hp # 重置生命值
		if is_instance_valid(cha1.health_bar): # 確保血條也有效
			cha1.health_bar.value = cha1.hp # 更新血條
		cha1.show() # 顯示角色
		cha1.play_animation("idle") # 回到閒置動畫
	if is_instance_valid(cha2):
		cha2.hp = cha2.max_hp
		if is_instance_valid(cha2.health_bar):
			cha2.health_bar.value = cha2.hp
		cha2.show()
		cha2.play_animation("idle")
	if is_instance_valid(cha3):
		cha3.hp = cha3.max_hp
		if is_instance_valid(cha3.health_bar):
			cha3.health_bar.value = cha3.hp
		cha3.show()
		cha3.play_animation("idle")
