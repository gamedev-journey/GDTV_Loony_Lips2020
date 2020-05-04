extends Control

onready var displayText = get_node("VBoxContainer/DisplayText")
onready var playerText = get_node("VBoxContainer/HBoxContainer/PlayerText")

func _ready():
	var prompts = ["carrot", "sad", "brick", "dusty"]
	var story = "There once was a %s and it was very %s. One day a %s exploded and the world was %s."
	var final = (story % prompts)
	
	displayText.text = final


func _on_PlayerText_text_entered(new_text):
	update_DisplyText(new_text)


func _on_TextureButton_pressed():
	var words = playerText.text
	update_DisplyText(words)
	
	
func update_DisplyText(words):
	playerText.clear()
	displayText.text = words


