extends Container

onready var item_list = $PanelContainer/VBoxContainer/ItemList

var item = 0


func _ready():
	# focus first item by default
	item_list.select(item, true)
	# warning-ignore:return_value_discarded
	item_list.connect("item_selected", self, "_on_item_selected")
	# warning-ignore:return_value_discarded
	item_list.connect("gui_input", self, "_on_ItemList_gui_input")


func _on_ItemList_gui_input(event: InputEvent) -> void:
	# get_tree().set_input_as_handled()
	
	# var mouse_item = item_list.get_item_at_position(get_global_mouse_position(), true)
	var mouse_item = item_list.get_item_at_position(get_local_mouse_position(), true)
	print(mouse_item)
	if mouse_item > -1:
		item = mouse_item

	if event is InputEventMouseMotion:
		if item != -1:
			item_list.select(item, true)
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
		if item != -1:
			_on_item_selected(item)
	
	if event is InputEventKey:
		if event.is_action_pressed("ui_down"):
			if item == item_list.get_item_count() - 1:
				item = 0
			else:
				item += 1
		elif event.is_action_pressed("ui_up"):
			if item == 0:
				item = item_list.get_item_count() - 1
			else:
				item -= 1
		elif event.is_action_pressed("ui_select"):
			_on_item_selected(item)
		
		item_list.select(item, true)


func _on_item_selected(index):
	prints("you selected item", index)
