extends Node2D

const COLUMNS: int = 6

@export var block_scene: PackedScene
@onready var block_holder: Node = $BlockHolder
@onready var numlist_shuf: Array = GameManager.num_list.duplicate()
@onready var numlist: Array = GameManager.num_list.duplicate()
@onready var time_label = $CanvasLayer/MarginContainer/time_label
@onready var animation = $CanvasLayer/MarginContainer/time_label/animation
@onready var try_again = $CanvasLayer/try_again
@onready var high_score_2 = $CanvasLayer/high_score2
@onready var high_score = $CanvasLayer/high_score
@onready var correct = $correct
@onready var wrong = $wrong

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
		try_again.visible = true
		high_score_2.visible = true
		high_score.visible = true
		high_score.text = "%.2f" % GameManager.get_high_score()

		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) == true:
			numlist = GameManager.num_list
			GameManager.load_game_scene()
	
func spawn_blocks() -> void:
	numlist_shuf.shuffle()
	for i in range(numlist_shuf.size()):
		var x = (i % COLUMNS) * 64 + 64
		var y = (i / COLUMNS) * 64 + 64
		var block = block_scene.instantiate()
		block.get_node("Label").text = str(numlist_shuf[i])
		block.position = Vector2(x, y)
		block_holder.add_child(block)
	
func popped(node: Node) -> void:
	var num = int(node.get_node("Label").text)
	if num == numlist[0]:
		node.visible = false;
		correct.play()
		numlist.erase(int(num))
	else:
		wrong.play()
