extends Control

var task_status = "not_started"  # "not_started", "in_progress", "completed"
var has_audio_finished = true
var popup

@onready var label_box = $Panel/label_container/Label
@onready var text_box = $Panel/text_container/RichTextLabel
@onready var audio = $AudioStreamPlayer
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#while true:
		#show_npc_dialogue("Hello adventurer of good heart! May I ask, for your name?",3)
		#await get_tree().create_timer(5).timeout

func show_npc_dialogue(text, pitch = 1,time = 0.01, follow_next = false):
	if not follow_next:
		text_box.text = ""
	for letter in text:
		await get_tree().create_timer(time).timeout
		text_box.text += letter
		if has_audio_finished:
			has_audio_finished = false
			audio.pitch_scale = randf() * 0.06 + pitch
			audio.play(randf() * (0.2)+0.35)
			timer.start()
	await get_tree().create_timer(time*4).timeout
	audio.stop()
	timer.one_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
