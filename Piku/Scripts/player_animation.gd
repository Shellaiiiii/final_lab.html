extends Node2D

@export var player_controller : PlayerController
@export var animSprite : AnimatedSprite2D

func _process(_delta):
	if player_controller.direction == 1  and not player_controller.isAttacking:
		animSprite.flip_h = false
	elif player_controller.direction == -1  and not player_controller.isAttacking:
		animSprite.flip_h = true
		
	if abs(player_controller.velocity.x) > 0.0 and player_controller.is_on_floor() and not player_controller.isAttacking:
		animSprite.play("run1")
	elif player_controller.velocity.x == 0.0 and player_controller.is_on_floor() and not player_controller.isAttacking:
		animSprite.play("idle1")
		
	if player_controller.velocity.y < 0.0 and not player_controller.isAttacking:
		animSprite.play("jump_up")
	elif player_controller.velocity.y > 0.0:
		animSprite.play("jump_down")
		
	#if animSprite.animation_finished and player_controller.isAttacking:
	#		player_controller.isAttacking = false
			
	if player_controller.isAttacking:
		animSprite.play("attack1")
		if animSprite.frame == animSprite.sprite_frames.get_frame_count("attack1") - 1:
			player_controller.isAttacking = false
	
	
		
