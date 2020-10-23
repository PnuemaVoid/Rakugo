extends Dialogue

var path_choice = ''

func some_dialog():
	
	start_event("some_dialog")

<<<<<<< HEAD
	say(null, "They say that happiness is a thing that you must create for your self.", {'typing': true})
	show("rect red")
	step()
	
	say(null, "They say that your life is something that you must treasure.", {'typing': true})
	show("rect blue")
	step()
	
	say(null, "They say many things...", {'typing': true})
	hide("rect red")
	step()
	
	say(null, "When my mother passed, she handed me this seed.", {'typing': true})
	step()

	say(null, "She said that the day I found true happiness, the seed would grow.", {'typing': true})
	step()

	say(null, "She said she wanted me to find my own happiness,", {'typing': true})
	step()

	say(null, "And I promised I would.", {'typing': true})
	step()

	say(null, "So I planted the seed here on this hill,", {'typing': true})
	step()

	say(null, "And I've waited...", {'typing': true})
	step()

	say(null, "I waited for the happiness my mother wanted me to have,", {'typing': true})
	step()

	say(null, "Until I realised it would not come.", {'typing': true})
	step()

	say(null, "And so I read, I sang, and I played..", {'typing': true})
	step()

	say(null, "I searched for the happiness she spoke of..", {'typing': true})
	step()

	say(null, "And it never came...", {'typing': true})
	step()

	say(null, "But leaving that seed would mean turining my back on my promise.", {'typing': true})
	step()

	say(null, "I can't let myself do that..", {'typing': true})
	step()

	say(null, "So here I am, and here I will be. Until I can make this seed grow.", {'typing': true})
	step()

	say(null, "Little test of the choice menu")
=======

	say(null, "Show 'rect {color=red}red{/color}', step #%d" % get_event_step(), {"typing":true})
	show("rect red")
	step()
	
	say(null, "Show 'rect {color=blue}blue{/color}', step #%d" % get_event_step(), {"typing":true})
	show("rect blue")
	step()
	
	say(null, "Hide 'rect red', step #%d" % get_event_step(), {"typing":true})
	hide("rect red")
	step()
	
	say(null, "Little test of the choice menu", {"typing":true})
>>>>>>> 2f0ccc265c301fec149ce0efc56a5a616474660a
	var choice = menu([["Choice 1", 1, {}], ["Choice 2", 2, {'visible':true}],["Choice 3", 3, {'visible':false}]])
	step()
	
	say(null, "You chose '%s' (not saved)  image tag test :{img=res://addons/Rakugo/emojis/16x16/1f1e6.tres}" % str(choice))
	step()
	
	say(null, "Show 'rect'(inexistant), step #%d  emoji tag test {:1f1e6:}" % get_event_step())
	show("rect")
	step()
	
	say(null, "Hide 'rect', step #%d" % get_event_step())
	hide("rect")
	step()
	
	say(null, "Select a path")
	show("rect red")
	show("pathchoice")
	step()
	
	if cond(path_choice == 'green'):
		say(null, "Green path chosen, yeah fuck blue")
		show("rect green")
		hide("pathchoice")
		step()
		
		say(null, "I confirm {color=[path_color]}[path_color]{/color} chosen")
		step()
		
		say(null, "Step #%d Green" % get_event_step())
		step()
		say(null, "Step #%d Green" % get_event_step())
		step()
		say(null, "Step #%d Green" % get_event_step())
		step()
	elif cond(path_choice == 'blue'):
		say(null, "Blue FTW, Green is for tards, amiright")
		show("rect blue")
		hide("pathchoice")
		step()
		
		say(null, "I confirm {color=[path_color]}[path_color]{/color} chosen")
		step()
		
		say(null, "Step #%d Blue" % get_event_step())
		step()
		say(null, "Step #%d Blue" % get_event_step())
		step()
		say(null, "Step #%d Blue" % get_event_step())
		step()
		say(null, "Step #%d Blue" % get_event_step())
		step()
	else:
		say(null, "Haha you did the right thing not picking of those inferior colors, ")
		hide("pathchoice")
		step()
		
		say(null, "Step #%d RED" % get_event_step())
		step()
		say(null, "Step #%d RED" % get_event_step())
		step()
		say(null, "Step #%d RED" % get_event_step())
		step()
		say(null, "Step #%d RED" % get_event_step())
		step()
		say(null, "Step #%d RED" % get_event_step())
		step()
		
	say(null, "Step #%d" % get_event_step())
	step()
	say(null, "Step #%d" % get_event_step())
	step()
	
	end_event()


func _on_green_path_chosen():
	self.path_choice = "green"
	Rakugo.store.path_color = "green"
	Rakugo.story_step()


func _on_blue_path_chosen():
	self.path_choice = "blue"
	Rakugo.store.path_color = "blue"
	Rakugo.story_step()
