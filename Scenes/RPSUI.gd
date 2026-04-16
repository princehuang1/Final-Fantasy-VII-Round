extends Control

signal player_choice(choice_index)

#func _ready():
	#var scissors_button = get_node_or_null("HBoxContainer/Scissors")
	#var rock_button = get_node_or_null("HBoxContainer/Rock")
	#var paper_button = get_node_or_null("HBoxContainer/Paper")
	
	#if is_instance_valid(scissors_button):
		#scissors_button.connect("pressed", _on_Scissors_pressed)
	#if is_instance_valid(rock_button):
		#rock_button.connect("pressed", _on_Rock_pressed)
	#if is_instance_valid(paper_button):
		#paper_button.connect("pressed", _on_Paper_pressed)	
		
func _on_Scissors_pressed():
	emit_signal("player_choice", 0)

func _on_Rock_pressed():
	emit_signal("player_choice", 1)

func _on_Paper_pressed():
	emit_signal("player_choice", 2)
