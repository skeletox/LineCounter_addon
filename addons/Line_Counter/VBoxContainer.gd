@tool
extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _add_new_line(Input_text : String , Count : int = 0) -> void :
	var Hbox_Container = HBoxContainer.new()
	var text_label = Label.new() 
	var count_label = Label.new()
	text_label.text = Input_text
	count_label.text = str(Count)
	Hbox_Container.add_child(text_label)
	Hbox_Container.add_spacer(false)
	Hbox_Container.add_child(count_label)
	add_child(Hbox_Container)
	
