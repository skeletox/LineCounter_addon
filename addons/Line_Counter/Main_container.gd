@tool
extends Control

@onready var Vbox = %VBoxContainer
@onready var Comments_included = $MainContainer/HBoxContainer/Commtens_ON
# Called when the node enters the scene tree for the first time.
var file_name_array : Array = []
var file_count_array : Array = []
func _ready():
	_add_lines()
	pass # Replace with function body.

func _add_lines():
	var global_sum : int = 0
	if not Vbox :
		return
#	print(file_name_array)
	for ii in file_name_array.size() :
		var myfile = FileAccess.open(file_name_array[ii] , FileAccess.READ)
		var count = 0  
		while not myfile.eof_reached() :
			var mytext_line = myfile.get_line()
#			print(mytext_line)
			if mytext_line == "" :
				continue
			if mytext_line.begins_with("#") && Comments_included.button_pressed != true :
				continue
			count+=1
		myfile.close()
#		printt(file_name_array[ii]  , k)
		global_sum+= count
		Vbox._add_new_line(file_name_array[ii],count)
	Vbox._add_new_line("TOTAL" , global_sum)



func _clear_lines():
	file_name_array.clear()
	file_count_array.clear()
	for child in Vbox.get_children() :
		Vbox.remove_child(child)
	pass

func _on_visibility_changed():
	if visible :
		_add_lines()
	else :
		_clear_lines()
	pass # Replace with function body.




func _on_commtens_on_toggled(button_pressed):
	for child in Vbox.get_children() :
		Vbox.remove_child(child)
	file_count_array.clear()
	_add_lines()
	pass # Replace with function body.
