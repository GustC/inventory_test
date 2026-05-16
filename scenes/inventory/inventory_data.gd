extends Resource
# A declaração class_name registra esse script no Godot,
# permitindo que ele seja escolhido na criação de Resources e usado como tipo de variável.
class_name InventoryData

# Sinais para notificar quem estiver "escutando" (a UI)
signal slot_added(new_total_slots: int, slot_data: ItemInventoryData)
signal capacity_maxed_out()

@export var min_slots: int = 5
@export var max_slots: int = 20

# Array que representa os slots reais. No futuro, ele guardará os itens (ex: instâncias de ItemInventoryData).
@export var slots: Array[ItemInventoryData] = []

# Chamado quando o jogo começa para garantir a quantidade mínima
func initialize_slots() -> void:
	if slots.size() < min_slots:
		slots.resize(min_slots)
	slots.assign(slots.map(func(slot): 
		if slot != null:
			return slot
		return ItemInventoryData.new()
	))
	for slot in slots:
		slot_added.emit(slots.size(),slot)
# A lógica de negócio fica toda aqui
func try_add_slot() -> void:
	if slots.size() < max_slots:
		var new_slot = ItemInventoryData.new()
		slots.append(new_slot) # Adiciona um slot vazio aos dados
		slot_added.emit(slots.size(),new_slot) # Avisa que um slot foi adicionado
	else:
		capacity_maxed_out.emit() # Avisa que chegou ao limite
# Insere um item no primeiro slot
func insert_item(item: ItemData) -> void:	
	var empty_slot_index = slots.find_custom(func(slot: ItemInventoryData): return slot.item_data == null)
	if empty_slot_index == -1:
		return
	var slot_item = slots[empty_slot_index]
	slot_item.item_data = item
	slot_item.item_created.emit(empty_slot_index)
	pass
