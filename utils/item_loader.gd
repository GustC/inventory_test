extends Resource

class_name ItemLoader
@export var item_list_json : JSON

func load_items() -> Array[ItemData]:
	var items : Array[ItemData] = []
	if item_list_json.data is Array:
		for item_dict in item_list_json.data:
			var item = ItemData.new()
			item.from_json(item_dict)
			items.append(item)
	return items
