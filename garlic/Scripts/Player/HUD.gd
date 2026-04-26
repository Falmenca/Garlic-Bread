extends CanvasLayer

@onready var name_display = $PlayerStats/Name
@onready var health_display = $PlayerStats/Health/Value
@onready var max_health_display = $PlayerStats/Health/MaxValue
@onready var level_display = $PlayerStats/Level/Value


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_pHud()
	PlayerStats.pStats_changed.connect(update_pHud)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_pHud():
	update_pHud()

func update_pHud():
	name_display.text = PlayerStats.pStats.pname
	health_display.text = str(PlayerStats.pStats.health)
	max_health_display.text = str(PlayerStats.pStats.max_health)
	level_display.text = str(PlayerStats.pStats.level)
