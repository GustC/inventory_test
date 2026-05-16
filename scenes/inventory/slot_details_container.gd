extends Panel


@onready var item_name: Label = $detail_margin/VBoxContainer/item_name
@onready var item_description: RichTextLabel = $detail_margin/VBoxContainer/item_description

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_details(item: ItemData) -> void:
	if item:
		item_name.text = item.item_name
		item_description.text = item.description
		show()
	pass
	
func close_details() -> void:
	hide()
	pass 
