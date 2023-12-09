extends Node2D

var backgrounds = [
	preload("res://Assets/MainMenu.png"),
	preload("res://Assets/MainMenuDark.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.darkMode:
		$MainMenu.texture = backgrounds[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("play")
	
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_button_2_pressed():
	print("music")
	
	if MainMusic.playing:
		MainMusic.stop()
		$Music.text = "Music off"
	else:
		MainMusic.play()
		$Music.text = "Music on"


func _on_button_3_pressed():
	print("sfx")
	
	if Global.sfxOn:
		Global.sfxOn = false
		$SFX.text = "SFX off"
	else:
		Global.sfxOn = true
		$SFX.text = "SFX on"


func _on_button_4_pressed():
	print("dark")
	
	if Global.darkMode:
		Global.darkMode = false
		$Dark.text = "Light Mode"
		$MainMenu.texture = backgrounds[0]
	else:
		Global.darkMode = true
		$Dark.text = "Dark Mode"
		$MainMenu.texture = backgrounds[1]
