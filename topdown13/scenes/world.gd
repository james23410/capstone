extends Node2D
var score = 0
var elapsed_time = 0.0
signal time_updated(elapsed_time: float)



func spawn_mob():
	var new_mob = preload("res://scenes/zombie.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	


func _on_timer_timeout():
	spawn_mob()



func _process(delta: float) -> void:
	elapsed_time += delta
	emit_signal('time_updated', elapsed_time)

func update_timer_display() -> void:
	var timer_label = $game_time/TimerLabel
	if timer_label:
		var minutes = int(elapsed_time / 60)
		var seconds = int(elapsed_time) % 60
		var milliseconds = int((elapsed_time - int(elapsed_time)) * 1000)
		timer_label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2) + ":" + str(milliseconds).pad_zeros(3)
	
