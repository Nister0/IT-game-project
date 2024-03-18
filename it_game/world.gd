extends Node2D
@onready var mob
@export var Enemy: PackedScene
@export var Player: PackedScene
var score
var game_time

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$MobTimer.stop()
	$HUD.show_game_over()
	$ScoreTimer.stop()
	#$Enemy.delete()
	
func new_game():
	score = 0
	game_time = 0
	$MobTimer.start()
	$HUD.update_score(score)
	$ScoreTimer.start()
	

func _on_mob_timer_timeout():
	var mob = Enemy.instantiate()

	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	if score > 10:
		var mob1 = Enemy.instantiate()
		mob_spawn_location.progress_ratio = randf()
		mob1.position = mob_spawn_location.position
		add_child(mob1)
	if score > 20:
		var mob2 = Enemy.instantiate()
		mob_spawn_location.progress_ratio = randf()
		mob2.position = mob_spawn_location.position
		add_child(mob2)
	if score > 30:
		var mob3 = Enemy.instantiate()
		mob_spawn_location.progress_ratio = randf()
		mob3.position = mob_spawn_location.position
		add_child(mob3)

func _on_score_timer_timeout():
	score += 1
	print(score)
	$HUD.update_score(score)

func _on_start_timer_timeout():
	pass # Replace with function body.
