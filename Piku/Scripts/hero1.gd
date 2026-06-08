extends CharacterBody2D

# class_name PlayerController

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

var direction = 0
var isAttacking : bool = false
var stillAlive : bool = true

@export var animSprite : AnimatedSprite2D

#@onready var animated_sprite = $AnimatedSprite2D
@onready var coin_text : Label = $Camera2D/CanvasLayer/Label
@onready var GOcontrol : Control = $Camera2D/CanvasLayer/Control
@onready var RSbutton : Button = $Camera2D/CanvasLayer/Control/Button

var coin_amount : int = 0
	
func _process(_delta):
	if direction == 1  and not isAttacking and stillAlive:
		animSprite.flip_h = false
	elif direction == -1  and not isAttacking and stillAlive:
		animSprite.flip_h = true
		
	if abs(velocity.x) > 0.0 and is_on_floor() and not isAttacking and stillAlive:
		animSprite.play("run1")
	elif velocity.x == 0.0 and is_on_floor() and not isAttacking and stillAlive:
		animSprite.play("idle1")
		
	if velocity.y < 0.0 and not isAttacking and stillAlive:
		animSprite.play("jump_up")
	elif velocity.y > 0.0 and stillAlive:
		animSprite.play("jump_down")
		
	if isAttacking and stillAlive:
		animSprite.play("attack1")
		if animSprite.frame == animSprite.sprite_frames.get_frame_count("attack1") - 1:
			isAttacking = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and stillAlive:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not isAttacking and stillAlive:
		velocity.y = JUMP_VELOCITY
	# Handle attack
	if Input.is_action_just_pressed("attack1") and is_on_floor() and stillAlive:
		isAttacking = true
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction and not isAttacking and stillAlive:
		velocity.x = direction * SPEED
	
	elif direction == 0.0 and not isAttacking and stillAlive:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _ready():
	RSbutton.pressed.connect(_button_pressed)
	#add_child(RSbutton)
	
func _button_pressed():
	get_tree().reload_current_scene()
	# if RSbutton.pressed:
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		set_coin(coin_amount + 1)
		coin_text.text = "Coins: " + str(coin_amount)
		print(coin_amount)
	if area.is_in_group("torn"):
		stillAlive = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animSprite.pause()
		print("dead")
		GOcontrol.visible = true


	
	
func set_coin(new_coin_count : int) -> void:
	coin_amount = new_coin_count 

	


#func _on_torn_area_entered(area: Area2D) -> void:
#	pass # Replace with function body.
