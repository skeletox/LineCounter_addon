@tool
extends EditorPlugin

const LineCounter = preload("res://addons/Line_Counter/Main_container.tscn")
var LineCounter_instance
var files_array : Array = []
func _enter_tree():
	# Initialization of the plugin goes here.
	main_screen_changed.connect(Callable(self , "_update_plugin"))
	LineCounter_instance = LineCounter.instantiate()
	LineCounter_instance.file_name_array = ["test1" , "test2" , "test3"]
	LineCounter_instance.file_count_array = [10 , 15 , 9]
	get_editor_interface().get_editor_main_screen().add_child(LineCounter_instance)
#	print(get_editor_interface().get_file_system_dock().get_child_count())
	_make_visible(false)
	pass

func _update_plugin(screen_name ):
	if screen_name != _get_plugin_name() :
		return
#	if LineCounter_instance :
#		LineCounter_instance.queue_free()
#	LineCounter_instance = LineCounter.instantiate()
	var all_files = get_editor_interface().get_resource_filesystem().get_filesystem_path("res://")
#	printt("test" , all_files)
#	for f in all_files  :
#		print(f.get_path())
#	print(_script_search(all_files))
	if LineCounter_instance :
		LineCounter_instance._clear_lines()
		LineCounter_instance.file_name_array = _script_search(all_files)
		LineCounter_instance._add_lines()
		
#	get_editor_interface().get_editor_main_screen().add_child(LineCounter_instance)
#	print(get_editor_interface().get_editor_main_screen().name)
	pass

func _script_search(main_res : EditorFileSystemDirectory) -> Array : 
	var output_array : Array = []
	for ii in main_res.get_subdir_count() :
		if main_res.get_subdir(ii).get_name() == "addons" :
			continue 
		var _subdir = main_res.get_subdir(ii) 
		if _subdir.get_subdir_count()!= 0 :
			output_array.append_array(_script_search(_subdir))
		for jj in _subdir.get_file_count()  :
			var file_extension = _subdir.get_file(jj).get_extension() 
			if file_extension != "gd" :
				continue
			var _file_name =_subdir.get_path() +  _subdir.get_file(jj).get_basename() + ".gd"
			output_array.append(_file_name)
			pass
	return output_array


func _exit_tree():
	# Clean-up of the plugin goes here.
	if LineCounter_instance :
		LineCounter_instance.queue_free()
	pass

func _has_main_screen():
	return true

func _make_visible(visible):
	if LineCounter_instance :
		LineCounter_instance.visible = visible

func _get_plugin_name():
	return "LineCounter"

func _get_plugin_icon():
	return get_editor_interface().get_base_control().get_theme_icon("Node" , "EditorIcons")
