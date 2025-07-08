extends PanelContainer
@export var label: String = "Label"
@export var data: String = "---"
@export var units: String = "units"
@onready var grid_canvas = get_node("/root/Range/RangeUI/GridCanvas")
signal drag_started
signal drag_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_label(label)
	set_data(data)
	set_units(units)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func set_label(l: String):
	label = l
	$VBoxContainer/Label.text = l
	

func set_data(value: String):
	data = value
	$VBoxContainer/Data.text = value
	

func set_units(u: String):
	units = u
	$VBoxContainer/Units.text = units
	
var dragging := false
var drag_offset := Vector2.ZERO

func _gui_input(event):
	if event is InputEventMouseButton:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				emit_signal("drag_started")
				dragging = true
				drag_offset = get_global_mouse_position() - global_position
			else:
				emit_signal("drag_ended")
				dragging = false
				grid_canvas.snap_to_grid(self)
	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - drag_offset
