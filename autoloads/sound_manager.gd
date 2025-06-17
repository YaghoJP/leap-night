extends Node

const FRUIT = preload("res://Assets/Sound/fruit.ogg")
const HIT = preload("res://Assets/Sound/hit.ogg")
const JUMPING_SFX = preload("res://Assets/Sound/jumping sfx.mp3")

@onready var sfx_streams: Node = $SFXStreams

func play_jump() -> void:
	play_audio(JUMPING_SFX)

func play_hiy() -> void:
	play_audio(HIT)

func play_fruit() -> void:
	play_audio(FRUIT)

func play_audio(audio: AudioStream) -> void:
	var audio_stream := get_free_audio_stream()
	audio_stream.stream = audio
	audio_stream.play()
	
func get_free_audio_stream() -> AudioStreamPlayer:
	for audio: AudioStreamPlayer in sfx_streams.get_children():
		if not audio.playing:
			return audio
			
	return null
