extends Resource

class_name ItemInventoryData

signal qty_updated(new_qty: int)
signal item_created(slot_index: int)
signal item_deleted()
signal on_slot_selected(slot: ItemInventoryData)
signal on_slot_unselected(slot: ItemInventoryData)
signal on_slot_hover(slot: ItemInventoryData)
signal on_slot_unhover(slot: ItemInventoryData)
@export var item_data: ItemData
@export var qty: int
@export var selected: bool = false
@export var can_hover: bool = true

func update_qty(new_qty:int) -> void:
	qty = new_qty
	pass
	
func add()->void:
	qty+=1
	qty_updated.emit(qty)
	pass

func remove()->void:
	qty-=1
	qty_updated.emit(qty)
	pass

func hover()->void:
	if can_hover:
		on_slot_hover.emit(self)
	pass

func unhover()->void:
	if can_hover:
		on_slot_unhover.emit(self)
	pass

func select()->void:
	selected = true
	on_slot_selected.emit(self)
	pass

func unselect()->void:
	selected = false
	on_slot_unselected.emit(self)
