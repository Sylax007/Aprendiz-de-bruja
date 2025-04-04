extends Control

var task_status = "not_started"  # "not_started", "in_progress", "completed"
var has_audio_finished = true
var is_writing
var is_clicked
var popup

@onready var characters = [$character1,$character2]
@onready var label_box = $Panel/label_container/Label
@onready var text_box = $Panel/text_container/RichTextLabel
@onready var audio = $AudioStreamPlayer
@onready var timer = $Timer
@onready var dialogue_timer: Timer
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#while true:
		#show_dialogue("Hello adventurer! This is the second sound!!", 0.9)
		#await get_tree().create_timer(5).timeout

func show_dialogue(text, pitch = 1, time = 0.01, follow_next = false):
	write_dialogue(text,pitch,time,follow_next)
	dialogue_timer.start()
	

func write_dialogue(text,pitch = 1,time = 0.01, follow_next = false):
	if not follow_next:
		text_box.text = ""
	elif is_clicked and follow_next:
		text_box.text += " " + text
	is_clicked = false
	#audio.play(randf()*8)
	for letter in text:
		await get_tree().create_timer(time).timeout
		text_box.text += letter
		if has_audio_finished:
			has_audio_finished = false
			audio.pitch_scale = randf() * 0.02 + pitch
			#audio.play(randf() * (0.2)+0.35)
			if not letter in ",.!:;<>? ":
				audio.play(randf() * (0.03)+0.02)
				#audio.play(randf() * (0.07)+0.06)
			timer.start()
		if is_clicked:
			is_writing = false
			text_box.text = text
			break
	await get_tree().create_timer(time*4).timeout
	audio.stop()
	timer.one_shot = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("click"):
		is_clicked = true
