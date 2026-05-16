extends Control

@export var item_slot: ItemInventoryData
@onready var item_sprite: Sprite2D = $item_sprite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item_slot:
		item_slot.item_created.connect(created_item)
	_update_sprite()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _update_sprite() -> void:
	if item_slot.item_data:
		item_sprite.texture = item_slot.item_data.sprite
	pass

func created_item(slot_index: int)->void:
	_update_sprite()
	pass
