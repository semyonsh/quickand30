extends Node2D

const COLUMNS: int = 6

@export var block_scene: PackedScene
@onready var block_holder: Node = $BlockHolder
@onready var numlist_shuf: Array = GameManager.num_list.duplicate()
@onready var numlist: Array = GameManager.num_list
@onready var time_label = $CanvasLayer/MarginContainer/time_label
@onready var animation = $CanvasLayer/MarginContainer/time_label/animation

var time_elapsed: float = 0.0

func _ready():
	GameManager.popped.connect(popped)
	GameManager.set_running(true)
	spawn_blocks()
		
func _process(delta: float):
	if GameManager._running == true:
		time_elapsed += delta
		time_label.text = "%.2f" % time_elapsed
		
	if numlist.is_empty():
		GameManager.set_score(time_elapsed)
		GameManager.set_running(false)
		time_label.text = "%.2f" % GameManager.get_score()
		animation.play("flash")

func spawn_blocks() -> void:
	numlist_shuf.shuffle()
	for i in range(numlist_shuf.size()):
		var x = (i % COLUMNS) * 64 + 64
		var y = (i / COLUMNS) * 64 + 64
		print("x: %s, y: %s" % [x, y])
		var block = block_scene.instantiate()
		block.get_node("Label").text = str(numlist_shuf[i])
		block.position = Vector2(x, y)
		block_holder.add_child(block)
	
func popped(node: Node) -> void:
	var num = int(node.get_node("Label").text)
	if num == numlist[0]:
		node.visible = false;
		numlist.erase(int(num))
