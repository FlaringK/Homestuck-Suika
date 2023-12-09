extends RigidBody2D

@export var size = 0

@onready var sprite = $Sprite2D
@onready var audio = $AudioStreamPlayer
@onready var dropper = get_parent().get_child(3)
@onready var bounds = get_parent().get_child(2)

var scaling = 0.25
var hasDropped = false

@onready var boxes = [
	$Circle,
	$Drop,
	$Gusher,
	$Cube,
	$Zill,
	$Artifact,
	$Diamond
]

var grist = Global.grist

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if size == 0:
		size = randi() % 4 + 1
	
	set_furit_scale()
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		
		if !hasDropped:
			dropper.canDrop = true
			hasDropped = true
		
		if body is RigidBody2D:
			
			# If same size
			if body.size == size:
				
				# If moving, destory self, else grow
				if linear_velocity.length() > body.linear_velocity.length():
					body.size += 1
					body.set_furit_scale()
					body.audio.play()
					
					get_parent().set_score(size)
					
					queue_free()
		
		# If out of bounds
		if body == bounds:
			
			get_parent().end_game()
			queue_free()
		
		pass
	
	pass

func set_furit_scale():
	
	var sizeFactor = scaling * (size + 1)
	
	# Enable Correct Child
	for child in get_children():
		if child is CollisionPolygon2D:
			child.disabled = true
			child.scale = Vector2.ONE * sizeFactor
	
	var gristType = grist[size]
	
	var boxShape = boxes[gristType[1]]
	boxShape.disabled = false
	
	sprite.texture = gristType[0]
	sprite.scale = Vector2.ONE / 2 * sizeFactor
	
	audio.pitch_scale = 0.5 + 0.25 * size
	
	pass






