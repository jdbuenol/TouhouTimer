extends Control

var textures : Array = [preload("res://images/chibi reimu.png"), preload("res://images/cirno.png"),
preload("res://images/remilia_sakuya.jpg")]

var hours : int = 0
var minutes : int = 0
var seconds : int = 0

var counting : bool = false

# Executes at the start of the scene
func _ready():
	OS.set_icon(load("res://images/icon.jpeg"))
	randomize()
	$ColorRect/Sprite.texture = textures[randi() % textures.size()]
	if $ColorRect/Sprite.texture == textures[1]:
		$ColorRect/Sprite.scale *= 0.6
	elif $ColorRect/Sprite.texture == textures[0]:
		$ColorRect/Sprite.scale *= 0.9

# Up in one the hours counter
func _on_UpHour_pressed():
	if ! counting:
		hours += 1
		if hours >= 100:
			hours = 0
		$ColorRect/Hours/ColorRect/Label.text = str(hours)

# Down in one the hours counter
func _on_DownHour_pressed():
	if ! counting:
		hours -= 1
		if hours < 0:
			hours = 99
		$ColorRect/Hours/ColorRect/Label.text = str(hours)

# Up in one the minutes counter
func _on_UpMinute_pressed():
	if ! counting:
		minutes += 1
		if minutes >= 60:
			minutes = 0
		$ColorRect/Minutes/ColorRect/Label.text = str(minutes)

# Down in one the minutes counter
func _on_DownMinute_pressed():
	if ! counting:
		minutes -= 1
		if minutes < 0:
			minutes = 59
		$ColorRect/Minutes/ColorRect/Label.text = str(minutes)

# Up in one the seconds counter
func _on_UpSecond_pressed():
	if ! counting:
		seconds += 1
		if seconds >= 60:
			seconds = 0
		$ColorRect/Seconds/ColorRect/Label.text = str(seconds)

# Down in one the seconds counter
func _on_DownSecond_pressed():
	if ! counting:
		seconds -= 1
		if seconds < 0:
			seconds = 59
		$ColorRect/Seconds/ColorRect/Label.text = str(seconds)

# Start the timer
func _on_START_pressed():
	if seconds != 0 or minutes != 0 or hours != 0:
		counting = true
		$Timer.start()

# Counts one second
func _on_Timer_timeout():
	seconds -= 1
	if seconds < 0:
		seconds = 59
		minutes -= 1
		if minutes < 0:
			minutes = 59
			hours -= 1
	$ColorRect/Hours/ColorRect/Label.text = str(hours)
	$ColorRect/Minutes/ColorRect/Label.text = str(minutes)
	$ColorRect/Seconds/ColorRect/Label.text = str(seconds)
	if seconds == 0 and minutes == 0 and hours == 0:
		$AudioStreamPlayer.play()
		OS.set_window_always_on_top(true)
		$Timer.stop()
		counting = false
		$ColorRect/Button.visible = true

# Stops the timer
func _on_STOP_pressed():
	$Timer.stop()
	counting = false

# Stops the music
func _on_Button_pressed():
	$AudioStreamPlayer.stop()
	$ColorRect/Button.visible = false
	OS.set_window_always_on_top(false)
