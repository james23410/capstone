extends CharacterBody2D

var elapsed_time = 0.0
signal time_updated(elapsed_time: float)

@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 200

var dead = false 
func _process(delta):
	if Input.is_action_just_pressed('exit'):
		get_tree().quit()
	if Input.is_action_just_pressed('restart'):
		restart()
	if dead:
		return
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2
	if Input.is_action_just_pressed('shoot'):
		shoot()
	elapsed_time += delta
	emit_signal('time_updated', elapsed_time)

func _physics_process(delta):
	if dead:
		return
	var move_dir = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	velocity = move_dir * move_speed
	move_and_slide()
	 


func kill():
	if  dead:
		return
	dead = true
	$graphics/dead.show()
	$graphics/alive.hide()
	$CanvasLayer/death_screen.show()
	z_index = -1
func restart():
	get_tree().reload_current_scene()

func shoot():
	$muzzle_flash.show()
	$muzzle_flash/Timer.start()
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider().has_method('kill'):
		ray_cast_2d.get_collider().kill()
		
		
		
		


func update_timer_display() -> void:
	var timer_label = $game_time/TimerLabel
	if timer_label:
		var minutes = int(elapsed_time / 60)
		var seconds = int(elapsed_time) % 60
		var milliseconds = int((elapsed_time - int(elapsed_time)) * 1000)
		timer_label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2) + ":" + str(milliseconds).pad_zeros(3)

