extends Control

signal skill_selected(skill_index) #自訂發射信號skill_selected,夾帶index

func _ready():
	#var skill1_button = get_node_or_null("Skill1Button")
	#var skill2_button = get_node_or_null("Skill2Button")
	#var skill3_button = get_node_or_null("Skill3Button")
	
	#檢查物件(按鈕)是否有效
	#if is_instance_valid(skill1_button):
		#skill1_button.connect("pressed", _on_Skill1Button_pressed)
	#if is_instance_valid(skill2_button):
		#skill2_button.connect("pressed", _on_Skill2Button_pressed)
	#if is_instance_valid(skill3_button):
		#skill3_button.connect("pressed", _on_Skill3Button_pressed)
	pass
	#這邊搞了我超久，手動連signal上面就不需要了
	
func _on_Skill1Button_pressed():
	emit_signal("skill_selected", 0) # 發射信號，Skill1 對應 index 0

func _on_Skill2Button_pressed():
	emit_signal("skill_selected", 1) 

func _on_Skill3Button_pressed():
	emit_signal("skill_selected", 2) 
