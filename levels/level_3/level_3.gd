extends Node2D

const Blocks = preload("res://entities/blocks/blocks.tscn")
const Portals = preload("res://levels/common/summon_portal.tscn")
export (String) var scene_name
export var player_name = "wizard"
var tile_size
var prev_column = -1

signal scene_changed(new_scene)

func _ready():
	tile_size = Globals.tile_size
	add_to_group("map")
	$Player.player_name = player_name
	$Player/PlayerModel.play(player_name + "_idle_right")

func handle_block_spawn(column):
	var portal = Portals.instance()
	var block = Blocks.instance()
	var all_blocks = get_tree().get_nodes_in_group("block")
	portal.position = (Vector2((column + 1.5) * tile_size, 2.5 * tile_size))
	block.position = (Vector2((column + 1.5) * tile_size, tile_size + tile_size/2))
	for b in all_blocks:
		if block.position == b.position:
			return
	block.select_block_type()
	block.hide()
	add_child(portal)
	add_child(block)

func _on_BlockSpawnTimer_timeout():
	randomize()
	var column = randi() % 14
	while column == prev_column:
		column = randi() % 14
	prev_column = column
	handle_block_spawn(column)

func _on_BlockFallTimer_timeout():
	get_tree().call_group("block", "handle_block_fall")

func _on_MoveTimer_timeout():
	get_tree().call_group("cat", "handle_movement")
	
func _on_Player_trapped():
	emit_signal("scene_changed", "defeat")

func _on_Player_bonus_time():
	randomize()
	ScoreTracker.handle_multiplier_change(5)
	$BonusTimer.start(30)
	$PlayerHUD.activate_special_icons("bonus")
	
func _on_BonusTimer_timeout():
	ScoreTracker.handle_multiplier_change(1)
	$PlayerHUD.deactivate_special_icons("bonus")

func _on_Player_timestopped():
	$BlockFallTimer.paused = true
	$BlockSpawnTimer.paused = true
	$MoveTimer.paused = true
	$PauseTimer.start(15)
	$Decorations.start_stunned_timer()
	$PlayerHUD.activate_special_icons("time")

func _on_PauseTimer_timeout():
	$BlockFallTimer.paused = false
	$BlockSpawnTimer.paused = false
	$MoveTimer.paused = false
	$PlayerHUD.deactivate_special_icons("time")

func _on_Player_buffed(buff):
	$PlayerHUD.activate_buff_icon(buff)

func _on_Player_unbuffed():
	$PlayerHUD.deactivate_buff_icons()
