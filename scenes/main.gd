extends Control

@onready var create_item_button: Button = $PanelContainer/MarginContainer/VBoxContainer/create_item_button
@onready var bag: PanelContainer = $bag

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_item_button.disabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bag_open() -> void:
	create_item_button.disabled = false
	pass # Replace with function body.

func _on_bag_close() -> void:
	create_item_button.disabled = true
	pass # Replace with function body.


func _on_create_item_button_pressed() -> void:
	bag.generate_random_item()
	pass # Replace with function body.
