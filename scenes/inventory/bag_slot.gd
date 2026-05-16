extends PanelContainer

@export var item_slot: ItemInventoryData
@export var hover_color: Color
@onready var item_texture: TextureRect = $item_texture
var _container_resource : Resource

# Called when the node enters the scene tree for the first time.
var _default_border_color : Color
func _ready() -> void:
	_container_resource = get_theme_stylebox("panel").duplicate()
	_default_border_color = _container_resource.border_color
	if item_slot:
		item_slot.item_created.connect(created_item)
		item_slot.on_slot_selected.connect(_on_select_slot)
		item_slot.on_slot_unselected.connect(_on_unselect_slot)
		item_slot.on_slot_hover.connect(_on_hover_slot)
		item_slot.on_slot_unhover.connect(_on_unhover_slot)
	_update_sprite()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _update_sprite() -> void:
	if item_slot.item_data:
		item_texture.texture = item_slot.item_data.sprite
	pass

func created_item(slot_index: int)->void:
	_update_sprite()
	pass

func _on_select_slot(slot_selected: ItemInventoryData) -> void:
	_change_to_selected_mode()
	pass
	
func _on_unselect_slot(slot_selected: ItemInventoryData) -> void:
	_change_to_unselected_mode()
	pass

func _on_hover_slot(slot_hovered: ItemInventoryData) -> void:
	if slot_hovered.can_hover:
		_change_to_selected_mode()
	pass
	
func _on_unhover_slot(slot_hovered: ItemInventoryData) -> void:
	_change_to_unselected_mode()
	pass

func _change_to_selected_mode() -> void:
	_container_resource.border_color = hover_color
	add_theme_stylebox_override("panel", _container_resource)
	pass

func _change_to_unselected_mode() -> void:
	_container_resource.border_color = _default_border_color
	add_theme_stylebox_override("panel", _container_resource)
	pass

func _on_mouse_hover() -> void:
	if !item_slot.selected:
		item_slot.hover()
	pass


func _on_mouse_unhover() -> void:
	if !item_slot.selected:
		item_slot.unhover()
	pass


func _on_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		if item_slot.selected:
			item_slot.unselect()
		else:
			item_slot.select()
	pass
