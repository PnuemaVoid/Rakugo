extends Node

const rakugo_version := "2.1.06"
const credits_path := "res://addons/Rakugo/credits.txt"

# project settings integration
onready var game_title : String = Settings.get("application/config/name")
onready var game_version : String = Settings.get("rakugo/game/info/version")
onready var game_credits : String = Settings.get("rakugo/game/info/credits")
onready var markup : String = Settings.get("rakugo/game/text/markup")
onready var debug_on : bool = Settings.get("rakugo/editor/debug")
onready var scene_links : String = Settings.get("rakugo/game/scenes/scene_links")
onready var theme : RakugoTheme = load(Settings.get("rakugo/default/gui/theme"))


var current_scene_name := ""
var current_scene_path := ""
var current_scene_node: Node = null
var current_dialogue:Node = null
var current_statement: Statement = null

var store = null setget set_current_store, get_current_store
var persistent = null setget set_persistent_store, get_persistent_store 

# don't save this
var viewport : Viewport


var active := false
var emoji_size := 16

var can_save := true

var file := File.new()
var loading_in_progress := false
var started := false

var auto_stepping := false
var skipping := false
var stepping_block = 0

# timers use by rakugo
onready var auto_timer := $AutoTimer
onready var skip_timer := $SkipTimer
onready var notify_timer := $NotifyTimer

onready var SceneLoader: = $SceneLoader
onready var StoreManager: = $StoreManager
onready var ShowableManager: = $ShowableManager
onready var History: = $History
onready var TextParser: = $TextParser
onready var Say = $Statements/Say
onready var Ask = $Statements/Ask
onready var Menu = $Statements/Menu

signal say(character, text, parameters)
signal ask(variable_name, parameters)
signal menu(choices, parameters)
signal menu_return(result)
#TODO clean those
signal started()
signal begin()#TODO Looks redundant with started, look into it
signal story_step(dialogue_name, event_name)
signal checkpoint()
signal game_ended()
#TODO assert the need of those
signal notified()
signal hide_ui(value)
#TODO prune those
signal play_anim(node_id, anim_name)
signal stop_anim(node_id, reset)
signal play_audio(node_id, from_pos)
signal stop_audio(node_id)

func _ready():
	self.viewport = get_tree().get_root()
	StoreManager.init()
	History.init()

	OS.set_window_title(game_title + " " + game_version)

	#file.open(credits_path, file.READ)
	#define("rakugo_credits", file.get_as_text(), false)
	#file.close()

## Rakugo flow control


# it starts Rakugo
func start(after_load := false):
	started = true
	if not after_load:
		emit_signal("started")


func save_game(save_name := "quick"):
	StoreManager.save_persistent_store()
	debug(["save data to :", save_name])
	return StoreManager.save_store_stack(save_name)


func load_game(save_name := "quick"):
	self.unblock_stepping()
	return StoreManager.load_store_stack(save_name)


func rollback(amount=1):
	self.unblock_stepping(true)
	self.StoreManager.change_current_stack_index(self.StoreManager.current_store_id + amount)


func activate_skipping():
	self.skipping = true
	skip_timer.start()

func deactivate_skipping():
	self.skipping = false


func activate_auto_stepping():
	self.auto_stepping = true
	auto_timer.start()

func deactivate_auto_stepping():
	self.auto_stepping = false


func prepare_quitting():
	if self.started:
		self.save_game("auto")
	StoreManager.save_persistent_store()
	Settings.save_property_list()


func load_scene(scene_id: String, force_reload:bool = false):
	SceneLoader.load_scene(scene_id, force_reload)


func clean_viewport():
	if self.viewport != get_tree().get_root():
		for c in self.viewport.get_children():
			self.viewport.remove_child(c)


func reset_game():#TODO rewrite that
	if current_scene_node != null:
		if current_scene_node.get_parent():
			current_scene_node.get_parent().remove_child(current_scene_node)
		current_scene_node.queue_free()

	var start_scene = Settings.get("application/run/main_scene")
	var lscene = load(start_scene)
	current_scene_node = lscene.instance()
	exit_dialogue()
	get_tree().get_root().add_child(current_scene_node)
	started = false
	emit_signal("game_ended")

# use this to change/assign current scene and dialogue
# id_of_current_scene is id to scene defined in scene_links or full path to scene
func jump(scene_id: String, dialogue_name: String, event_name: String, force_reload:bool = false):
	$Statements/Jump.invoke(scene_id, dialogue_name, event_name, force_reload)

## Dialogue flow control
func block_stepping():
	stepping_block += 1


func unblock_stepping(_all=false):
	stepping_block += -1
	if _all or stepping_block < 0:
		stepping_block = 0


func story_step(_unblock=false):
	if _unblock or stepping_block == 0:
		stepping_block = 0
		StoreManager.stack_next_store()
		print("Emitting _step")
		get_tree().get_root().propagate_call('_step')
		#emit_signal("story_step", current_dialogue_name, current_event_name)
	else:
		print("Emitting _blocked_step")
		get_tree().get_root().propagate_call('_blocked_step')


func exit_dialogue():
	if self.current_dialogue:
		self.current_dialogue.exit()




## Signal Emission

func notified():
	emit_signal("notified")



## Global history

func can_qload():
	return false
	


## Utils

# parse text like in renpy to bbcode
# defaults to project setting if null
func parse_rich_text(text: String, markup = null):
	return TextParser.parse(text, markup)


# crate new character as global variable that Rakugo will see
# possible parameters: name, color, prefix, suffix, avatar, stats
func define_character(character_name: String, character_tag: String) -> Character:
	var new_character = Character.new().duplicate()
	new_character.init(character_name, character_tag)
	StoreManager.get_current_store()[character_tag] = new_character
	return new_character


# statement of type say
# its make given 'character' say 'text'
# 'parameters' keywords:typing, type_speed, avatar, avatar_state, add
# speed is time to show next letter
func say(character, text:String, parameters: Dictionary):
	Say.exec(character, text, parameters)


# statement of type ask
# with keywords: placeholder
# speed is time to show next letter
func ask(variable_name:String, parameters: Dictionary):
	Ask.exec(variable_name, parameters)


# statement of type menu
func menu(choices:Array, parameters: Dictionary):
	Menu.exec(choices, parameters)


# it show nod tagged with "showable <space separated tag>"
func show(showable_tag:String, parameters := {}):
	ShowableManager.show(showable_tag, parameters)


# statement of type hide
func hide(showable_tag: String):
	ShowableManager.hide(showable_tag)


# statement of type notify
#func notify(info: String, length: int = get_value("notify_time")):
#	var parameters = {
#		"info": info,
#		"length":length
#	}
#	_set_statement($Statements/Notify, parameters)
#	notify_timer.wait_time = parameters.length
#	notify_timer.start()

func debug_dict(parameters: Dictionary, parameters_names := [], some_custom_text := "") -> String:
	var dbg = ""

	for k in parameters_names:
		if k in parameters:
			if not k in [null, ""]:
				dbg += k + ":" + str(parameters[k]) + ", "

	if parameters_names.size() > 0:
		dbg.erase(dbg.length() - 2, 2)

	return some_custom_text + dbg


# for printing debugs is only print if debug_on == true
# put some string array or string as argument
func debug(some_text = []):
	if not debug_on:
		return

	if not started:
		return	

	if typeof(some_text) == TYPE_ARRAY:
		var new_text = ""

		for i in some_text:
			new_text += str(i) + " "

		some_text = new_text

	print(some_text)

func get_current_store():
	return StoreManager.get_current_store()
	
func set_current_store(value):
	return 

func get_persistent_store():
	return StoreManager.get_persistent_store()
	
func set_persistent_store(value):
	return 
