extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Vector2) var gravity_direction = Vector2(0, 1)
export(float) var gravity_magnitude = 350

export(float) var speed = 250

var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func jump():
	$AnimationPlayer.play("Jump")

func _physics_process(_delta):
	velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		$Sprite.flip_h = true
		$AnimationPlayer.play("Running")
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		$AnimationPlayer.play("Running")
		if $Sprite.flip_h:
			$Sprite.flip_h = false
	if Input.is_action_pressed("jump"):
		jump()
		
	if not is_on_floor() and not is_on_wall():
		$AnimationPlayer.play("Falling")
	else:
		if not velocity:
			$AnimationPlayer.play("Stance")
	
	move_and_slide(velocity + gravity_direction * gravity_magnitude)
