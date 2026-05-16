extends Resource

class_name ItemData

@export var id: int
@export var item_name: String
@export var description: String
@export var sprite: Texture2D

func from_json(dict: Dictionary) -> void:
	id = dict.get('id')
	item_name = dict.get('item_name')
	description = dict.get('description')
	var sprite_dir: String = dict.get('sprite')
	if sprite_dir:
		sprite = load(sprite_dir)
	pass
