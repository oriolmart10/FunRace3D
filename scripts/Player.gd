extends PathFollow

const DeathEffect = preload("res://prefabs/DeathEffect.tscn")

export(float) var velocity = 0.0
var current_state = RUN
var shoted = false

onready var animationPlayer = $Player/AnimationPlayer

enum {RUN, IDLE}

func _physics_process(delta):
	if Input.is_action_pressed("ui_walk"):
		current_state = RUN
		offset = offset + velocity
		if current_state == RUN:
			animationPlayer.play("Run")
		if offset >= 5 and !shoted:
			$Player.visible = false
			var deathEffect = DeathEffect.instance()
			add_child(deathEffect)
			deathEffect.scale = Vector3(0.6,0.6,0.6)
			deathEffect.global_transform = $DeathEffectSpawnPoint.global_transform
			shoted = true
			offset = 5
	else:
		current_state = IDLE
		animationPlayer.play("Idle")

func make_invisible():
	$Player.visible = false
