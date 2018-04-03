extends RigidBody
var left = false
var top =  true
var vel = 5
var speed = Vector2(0,0)

func _ready():
	set_translation(Vector3(get_translation().x, get_translation().y, Variables.z))
	connect("body_enter", self, "_bodyenter")
	get_node("AnimationPlayer").play("IDLE")
	speed = Vector2(vel, vel)
	set_fixed_process(true)
	
func _bodyenter(body):
	if body.get_name() == "Right":
		left = true
	if body.get_name() == "Left":
		left = false
	if body.get_name() == "Top":
		top = false
	if body.get_name() == "Bottom":
		top = true
		#get_tree().change_scene("res://Scenes/GameOver.tscn")
	if body.is_in_group("Enemy"):
		left = !left
	if body.get_name() == "Player":
		top = !top
		left = !body.right
	set_angular_velocity(Vector3(0,0,0))
	get_node("AnimationPlayer").play("Bounce")

func _stopbounce():
	get_node("AnimationPlayer").play("IDLE")

func _fixed_process(delta):
	if left:
		speed.x = -vel
	else:
		speed.x = vel
	if top:
		speed.y = vel
	else:
		speed.y = -vel
	
	set_linear_velocity(Vector3 (speed.x, speed.y, 0))