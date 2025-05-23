extends KinematicBody2D

var move_velocity = Vector2()
var max_speed = 100
var velocity = Vector2()
var impulse = Vector2()
var team = 1

func _ready():
	GC.PLAYER = self
	GC.CAMERA = $Camera2D
	$healthComponent.connect("dead",self,"on_dead")
	$healthComponent.dont_free_on_dead = true

func _process(delta):
	var move = Vector2()
	if Input.is_action_pressed("ui_left"): move.x = -1 
	if Input.is_action_pressed("ui_right"): move.x = 1 
	if Input.is_action_pressed("ui_up"): move.y = -1 
	if Input.is_action_pressed("ui_down"): move.y = 1 
	move_velocity += move.normalized()*5
	$AnimatedSprite.flip_h = (move_velocity.x<0)
	if(move_velocity.length()>max_speed):
		move_velocity = move_velocity.normalized()*max_speed
	velocity = move_and_slide(move_velocity+impulse,Vector2.UP)
	impulse *= 0.95
	move_velocity *= 0.92
	
	if(move_velocity.length()>5): $AnimatedSprite.play("walk")
	else: $AnimatedSprite.play("idle")
	GC.set_z_index_to(self)
	
	$TextureRect.visible = Input.is_action_pressed("tab")

func on_dead(hc):
	GC.end_game(false)
