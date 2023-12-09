extends Node2D

@onready var sprite = $Sprite2D

func _ready():
	pass # Replace with function body.

var speed = 2.5
var leftRange = 480
var rightRange = 800

var upNow = 3
var canDrop = true

const fruit = preload("res://Objects/fruit.tscn")

func _process(delta):
	
	if get_parent().gameEnd:
		return
	
	# Movement
	var move = 0
	
	if Input.is_action_pressed("ui_left"):
		move = -speed
	
	if Input.is_action_pressed("ui_right"):
		move = speed
	
	position.x = clamp(position.x + move, leftRange, rightRange)
	
	if Input.is_action_just_pressed("ui_left") and position.x == leftRange:
		position.x = rightRange
	
	if Input.is_action_just_pressed("ui_right") and position.x == rightRange:
		position.x = leftRange
	
	if get_parent().useMouse:
		position.x = clamp(get_global_mouse_position().x, leftRange, rightRange)
	
	
	# Dropping
	if (Input.is_action_just_pressed("game_drop") or (Input.is_action_just_pressed("game_mouse_drop") and get_parent().useMouse)) and canDrop:
		var newFruit = fruit.instantiate()
		newFruit.position.x = position.x
		newFruit.position.y = position.y
		newFruit.size = upNow
		upNow = get_parent().get_up_next()
		sprite.texture = Global.grist[upNow][0]
		
		sprite.scale = Vector2.ONE / 2 * newFruit.scaling * (upNow + 1)
		
		get_parent().add_child(newFruit)
		canDrop = false
	
	pass
