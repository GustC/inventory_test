extends PanelContainer

@onready var slot_grid: GridContainer = $HBoxContainer/slots_container/slots_margin/VBoxContainer/slots_scroll/slot_grid
@onready var slot_details_container: Panel = $HBoxContainer/MarginContainer/slot_details_container
@onready var add_slot_button: Button = $HBoxContainer/slots_container/slots_margin/VBoxContainer/add_slot_button

@export var max_slots: int
@export var min_slots: int
@export var inventory_data: InventoryData
@export var item_loader: ItemLoader

signal on_bag_open()
signal on_bag_close()

var slot_scene = preload("res://scenes/inventory/bag_slot.tscn")
var _items_avaliable : Array[ItemData]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	inventory_data.min_slots = min_slots
	inventory_data.max_slots = max_slots
	inventory_data.slot_added.connect(_on_new_slot_added)
	inventory_data.capacity_maxed_out.connect(_on_inventory_is_full)
	inventory_data.show_slot_details.connect(_on_item_focused)
	inventory_data.hide_slot_details.connect(_on_item_unfocus)
	inventory_data.initialize_slots()
	_items_avaliable = item_loader.load_items()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		open_close()
	if Input.is_action_just_pressed("add_slot") and visible:
		inventory_data.try_add_slot()
	if Input.is_action_just_pressed("add_item") and visible:
		generate_random_item()
	pass

func open_close() -> void:
	if visible:
		hide()
		on_bag_close.emit()
	else:
		show()
		on_bag_open.emit()
	pass
	
func _on_new_slot_added(total_slots: int, new_slot_data: ItemInventoryData) -> void:
	print(total_slots)
	var new_slot = slot_scene.instantiate()
	new_slot.item_slot = new_slot_data
	slot_grid.add_child(new_slot)
	pass

func _on_inventory_is_full() -> void:
	add_slot_button.disabled = true
	pass
	
func generate_random_item() -> void:	
	var new_item = _items_avaliable.pick_random()
	inventory_data.insert_item(new_item)
	pass

func _on_item_focused(slot: ItemInventoryData) -> void:
	if slot.can_hover or slot.selected:
		slot_details_container.show_details(slot.item_data)
	pass

func _on_item_unfocus(slot: ItemInventoryData) -> void:
	if slot.can_hover:
		slot_details_container.close_details()
	pass


func _on_add_slot_button_pressed() -> void:
	inventory_data.try_add_slot()
	pass # Replace with function body.
