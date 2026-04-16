extends Node

signal boss_defeated # 定義 boss_defeated 信號

var hp = 200
var max_hp = 200
var attack_power = 90

@onready var animation_sprite: AnimationPlayer = $AnimationPlayer
@onready var health_bar: ProgressBar = $HP 

func _ready():
	if is_instance_valid(health_bar):
		health_bar.max_value = max_hp
		health_bar.value = hp
	play_animation("idle")

func take_damage(damage: int):
	hp -= damage
	if is_instance_valid(health_bar):
		health_bar.value = hp
	print("boss受到", damage, "點傷害,剩餘:", hp)
	if hp <= 0:
		self.visible = false
		emit_signal("boss_defeated") # 可以發出 Boss 被擊敗的信號

func play_animation(animation_name: String):
	if is_instance_valid(animation_sprite):
		animation_sprite.play(animation_name)

func get_attack_power() -> int:
	return attack_power

func is_alive() -> bool:
	return hp > 0

func _on_play_attack_animation():
	play_animation("attack")
