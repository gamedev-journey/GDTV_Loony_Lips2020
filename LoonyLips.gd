extends Control

onready var displayText = get_node("VBoxContainer/DisplayText")
onready var playerText = get_node("VBoxContainer/HBoxContainer/PlayerText")
onready var buttonText = get_node("VBoxContainer/HBoxContainer/Label")

var player_words = []

var current_story = {}


func _ready():
	pick_current_story()
	displayText.text = current_story.intro
	check_player_words_length()
	playerText.grab_focus()


func get_from_json(filename):
	var filepath = "res://" + filename
	var file = File.new()
	file.open(filepath, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data


func _on_PlayerText_text_entered(new_text):
	add_to_player_words()
	


func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()


func add_to_player_words():
	player_words.append(playerText.text)
	displayText.text = ""
	playerText.clear()
	check_player_words_length()


func is_story_done():
	return player_words.size() == current_story.prompts.size()
	

func check_player_words_length():
	if is_story_done():
		tell_story()
	else:
		prompt_player()


func tell_story():
	displayText.text = current_story.story % player_words
	end_game()


func prompt_player():
	displayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"


func end_game():
	playerText.queue_free()
	buttonText.text = "Play again?"
	
func pick_current_story():
	var stories = get_from_json("stories.json")
	randomize()
	current_story = stories[randi() % stories.size()]

