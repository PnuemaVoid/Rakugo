extends Object
class_name Statement

var type := 0 # Rakugo.StatementType.BASE
var def_parameters := {"add_to_history": false} # default parameters
var parameters := {} # dict of pairs keyword: argument
var parameters_names := ["add_to_history"] # possible keywords for this type of statement - to use in RakuScript in near future


func exec() -> void:
	debug(parameters_names)

	Rakugo.current_statement = self
	Rakugo.exec_statement(type, parameters)


func set_parameters(new_parameters: Dictionary) -> void:
	# update statement
	parameters = def_parameters.duplicate()
	add_parameters(new_parameters)


func add_parameters(new_parameters: Dictionary):
	for k in new_parameters.keys():
		parameters[k] = new_parameters[k]


func setup_exit(_type: int, new_parameters := {}) -> bool:
	if _type != type:
		return false

	if new_parameters != {}:
		add_parameters(new_parameters)

	return true


func on_exit(_type: int, new_parameters := {}) -> void:
	if !setup_exit(_type, new_parameters):
		return

	if parameters.add_to_history:
		add_to_history()

	Rakugo.story_step()


func get_history_id() -> Array:
	if not Rakugo.current_scene_name or not Rakugo.current_dialogue:
		return []
	var id_list = [
		Rakugo.current_scene_name,
		Rakugo.current_dialogue.name,
		Rakugo.current_dialogue.event_stack[0][0],
		Rakugo.current_dialogue.event_stack[0][1]
	]

	var id = PoolStringArray(id_list).join(",")

	return id


func get_as_history_item() -> Dictionary:
	var hparameters = parameters.duplicate()
	hparameters.erase("avatar")
	var history_item = {
		"type": type,
		"parameters": hparameters
	}

	return history_item


func add_to_history() -> void:
	var id = get_history_id()
	var history_item = get_as_history_item()
	Rakugo.history[id] = history_item
	Rakugo.global_history[id] = history_item

	Rakugo.history_id += 1


func debug(parameters_names: Array = [], some_custom_text: String = "") -> void:
	var dbg = (Rakugo.StatementType.keys()[type].to_lower() + "("
			+ Rakugo.debug_dict(parameters, parameters_names, some_custom_text) + ")")
	Rakugo.debug(dbg)
