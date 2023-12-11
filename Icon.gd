extends Sprite2D

@onready
var _4e_044a_69b_3183_eca_1_fd_33_ad_890a_9d_0d: Sprite2D = $"../4e044a69b3183Eca1Fd33Ad890a9d0d"


func _physics_process(delta: float) -> void:
	_4e_044a_69b_3183_eca_1_fd_33_ad_890a_9d_0d.position = get_local_mouse_position()
