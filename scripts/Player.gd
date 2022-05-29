extends PathFollow

onready var animationPlayer = $Player/AnimationPlayer
onready var animationCamera = $AnimationCamera

export(float) var velocity = 0.0
export(bool) var left_player = true


var current_state = IDLE
var respawn_point = 0
var key_to_press = ""
var invincible_mode = false
var move_mode = 0;

enum {RUN, IDLE, DEATH, VICTORY, DEFEAT, CRAWL, CLIMB}

func _ready():
	if left_player:
		key_to_press = "ui_run_left_player"
	else:
		key_to_press = "ui_run_right_player"

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_invincible"):
		change_invicnible_mode()
	
	if current_state != DEATH and current_state != VICTORY:
		if Input.is_action_pressed(key_to_press):
			offset = offset + velocity
			if (move_mode == 0):
				current_state = RUN
			elif (move_mode == 1):
				current_state = CRAWL
			elif (move_mode == 2):
				current_state = CLIMB
			print(current_state)
			play_avance_anim()
		else:
			current_state = IDLE
			animationPlayer.play("Idle")
	
	print(unit_offset)
	if unit_offset == 1:
		current_state = VICTORY
		animationPlayer.play("Victory")


func reset_position_to_spawPoint():
	offset = respawn_point
	$Player.visible = true
	current_state = IDLE
	move_mode = 0
	animationCamera.play("ResetCamera")
	$Player.set_collision_layer_bit(0, true)
	$Player.set_collision_mask_bit(0, true)
	
func set_respawn_point():
	respawn_point = offset
	print("Respawn point set at: " + String(offset))

func set_death_state():
	current_state = DEATH

func crawl():
	move_mode = 1
	print("Crawl mode")
	

func run():
	move_mode = 0
	print("Run mode")
	
func climb():
	move_mode = 2

func sideCamera():
	animationCamera.play("SideCamera")

func backCamera():
	animationCamera.play("BackCamera")

func change_invicnible_mode():
	if invincible_mode:
		$Player.set_collision_layer_bit(0, true)
		$Player.set_collision_mask_bit(0, true)
		invincible_mode = false
	else:
		$Player.set_collision_layer_bit(0, false)
		$Player.set_collision_mask_bit(0, false)
		invincible_mode = true

func play_avance_anim():
	if current_state == RUN:
		animationPlayer.play("Run")
	elif current_state == CRAWL:
		animationPlayer.play("Crawl")
