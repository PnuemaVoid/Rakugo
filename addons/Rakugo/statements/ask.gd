extends Node
class_name Ask

var default_parameters = {}


func _ready():
	default_parameters = Settings.get("rakugo/default/statements/default_ask_parameters", {}, false)

func exec(variable_name:String, parameters = {}) -> void:
	parameters = _apply_default(parameters, default_parameters)
	Rakugo.block_stepping()
	Rakugo.emit_signal("ask", variable_name, parameters)


#Utils functions

func _apply_default(input:Dictionary, default:Dictionary):
	var output = input.duplicate()
	for k in default.keys():
		if not output.has(k):
			output[k] = default[k]
	return output
