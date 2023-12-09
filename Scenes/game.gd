extends Node2D

var upNext = 1
var score = 0
var topScore = 5000.0

var gameEnd = false
var useMouse = false

@onready var upNextView = $UpNext
@onready var display = $Display
@onready var bounds = $OutofBounds

@onready var label = $Label
@onready var barBlind = $BarBlind

var upNextTiles = [
	preload("res://Assets/Upnext/DaveGrist.png"),
	preload("res://Assets/Upnext/DaveGrist.png"),
	preload("res://Assets/Upnext/RoseGrist.png"),
	preload("res://Assets/Upnext/JadeGrist.png"),
	preload("res://Assets/Upnext/JuneGrist.png"),
]

var backgrounds = [
	preload("res://Assets/Suika Background.png"),
	preload("res://Assets/Suika Background Dark.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.darkMode:
		$SuikaBackground.texture = backgrounds[1]

func get_up_next():
	
	var upNow = upNext
	upNext = randi() % 4 + 1
	
	upNextView.texture = upNextTiles[upNext]
	
	return upNow

func set_score(size):
	
	if gameEnd: return
	
	score += size * size
	
	barBlind.scale.x = max((1 / topScore) * (topScore - score), 0)
	
	$Display.text = str(score)

func end_game():
	
	gameEnd = true
	label.text = "Grist Cache Overflow\nGame over!"
	
	if Global.sfxOn:
		$Out.play()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_mouse_mouse_entered():
	useMouse = true


func _on_mouse_mouse_exited():
	useMouse = false
