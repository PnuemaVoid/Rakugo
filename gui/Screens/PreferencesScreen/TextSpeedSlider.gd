extends Slider

func _on_value_changed(value):
	Settings.set("rakugo/default/delays/typing_effect_delay", abs(value))

<<<<<<< HEAD
#func _on_visibility_changed():
#	if visible:
#		value = -Rakugo.get_value("text_time")
=======
func _on_visibility_changed():
	if visible:
		value = -Settings.get("rakugo/default/delays/typing_effect_delay")
>>>>>>> 2f0ccc265c301fec149ce0efc56a5a616474660a
