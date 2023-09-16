extends StaticBody2D
signal player_exit

export var landingPosition : Vector2
export var velocity : Vector2
export var path_to_find : NodePath
var landing : bool
var landing_state: Node
var extraction_state: Node
var ship_position : Vector2
var ship_destination_position : Vector2
var distance_to_destination : Vector2


func commence_landing():
	$AnimatedSprite.set_animation("flying")
	$AnimatedSprite.set_playing(true)
#	print_debug(velocity)
	velocity.x = landingPosition.x - $".".global_position.x
	velocity.y = landingPosition.y - $".".global_position.y
	if velocity.x != 0:
		if velocity.y != 0:
			self.set_position(Vector2(self.global_position.x +1, self.global_position.y + 1))
		else:
			self.set_position(Vector2(self.global_position.x + 1, self.global_position.y))
	elif velocity.y != 0:
		self.set_position(Vector2(self.global_position.x, self.global_position.y + 1))
	else:
		print("I have landed")
		$AnimatedSprite.set_animation("idle")
		$CountdownTimer.start()
		emit_signal("player_exit")
		landing_state.queue_free()

func commence_extraction():
	ship_position = $".".global_position
	ship_destination_position = Vector2(-50, -1)
	distance_to_destination = ship_position - ship_destination_position
	$AnimatedSprite.set_animation("flying")
	if distance_to_destination.y > 0:
		self.set_position(Vector2(ship_position.x, ship_position.y - 1))
	elif distance_to_destination.x > 0:
		$AnimatedSprite.flip_h = true
		self.set_position(Vector2(ship_position.x - 1, ship_position.y))
	else:
		pass
		
		
		
		
	
	
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	landing_state = Node.new()
	landing_state.set_name("LandingState")
	$State.add_child(landing_state)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $State.has_node("LandingState"):
		commence_landing()
	elif $State.has_node("Extracting"):
		commence_extraction()


func _on_CountdownTimer_timeout():
	extraction_state = Node.new()
	extraction_state.set_name("Extracting")
	$State.add_child(extraction_state)
	
