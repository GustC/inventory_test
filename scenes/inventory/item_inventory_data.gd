extends Resource

class_name ItemInventoryData

signal qty_updated(new_qty: int)
signal item_created(slot_index: int)
signal item_deleted()

@export var item_data: ItemData
@export var qty: int

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
