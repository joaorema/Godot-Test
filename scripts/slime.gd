extends Node2D

const speed = 60
var direction = 1

@onready var raycast_left: RayCast2D = $"Raycast Left"
@onready var raycast_right: RayCast2D = $"Raycast Right"


func _process(delta):
	if raycast_right.is_colliding():
		direction = -1
	if raycast_left.is_colliding():
		direction = 1
	position.x += direction * speed * delta
	
	
