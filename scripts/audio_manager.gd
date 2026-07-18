extends Node

@onready var bgm_player: AudioStreamPlayer = $BGM
@onready var sfx_player: AudioStreamPlayer = $SFX

var click_sfx: AudioStream = preload("res://music/mouse_click.ogg")
var boop_sfx: AudioStream = preload("res://music/boop.ogg")

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
	
func play_click() -> void:
	play_sfx(click_sfx)
	
func play_boop() -> void:
	play_sfx(boop_sfx)
