extends Node

@onready var bgm_player: AudioStreamPlayer = $BGM
@onready var sfx_player: AudioStreamPlayer = $SFX

func _ready() -> void:
	play_bgm()

func play_bgm() -> void:
	if bgm_player.playing:
		return
	bgm_player.play()

func play_sfx(stream: AudioStream) -> void:
	if stream == null:
		return
	sfx_player.stream = stream
	sfx_player.play()
