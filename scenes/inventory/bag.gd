extends PanelContainer

@onready var slot_grid: GridContainer = $slots_area/MarginContainer/slot_grid

@export var max_slots: int
@export var min_slots: int
@export var inventory_data: InventoryData
@export var items_avaliable: Array[ItemData]
var slot_scene = preload("res://scenes/inventory/bag_slot.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	inventory_data.min_slots = min_slots
	inventory_data.max_slots = max_slots
	inventory_data.slot_added.connect(_on_new_slot_added)
	inventory_data.capacity_maxed_out.connect(_on_inventory_is_full)
	inventory_data.initialize_slots()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		open_close()
	if Input.is_action_just_pressed("add_slot"):
		inventory_data.try_add_slot()
	if Input.is_action_just_pressed("add_item"):
		_generate_random_item()
	pass

func open_close() -> void:
	if visible:
		hide()
	else:
		show()
	pass
	
func _on_new_slot_added(total_slots: int, new_slot_data: ItemInventoryData) -> void:
	print(total_slots)
	var new_slot = slot_scene.instantiate()
	new_slot.item_slot = new_slot_data
	slot_grid.add_child(new_slot)
	pass

func _on_inventory_is_full() -> void:
	print("inventory is full!")
	pass
	
func _generate_random_item() -> void:	
	var new_item = items_avaliable.pick_random()
	inventory_data.insert_item(new_item)
	pass
