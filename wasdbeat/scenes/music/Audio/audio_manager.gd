extends Node
class_name AudioManager

func play_bgm(bgm_to_play, fade_in_duration: float = 0.0) -> void:
	$BGMPlayer.stream = bgm_to_play
	$BGMPlayer.play()
	
	if fade_in_duration > 0.0:
		create_tween().tween_property($BGMPlayer, "volume_db", 0, fade_in_duration)
	else:
		$BGMPlayer.volume_db = 0

func stop_bgm(fade_out_duration: float = 0.0) -> void:
	if fade_out_duration > 0.0:
		await create_tween().tween_property($BGMPlayer, "volume_db", -80, fade_out_duration).finished
	
	$BGMPlayer.stop()
