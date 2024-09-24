extends StaticBody2D


var bullet = preload("res://red_bullet.tscn")
var bulletDamage = 5 
var pathName
var currTargets = []
var curr
@onready var aim = $area

func _on_tower_body_entered(body):
	print(body.name)
	if "Soldier A" in body.name:
		var tempArray =[]
		currTargets = get_node("Tower").get_overlapping_bodies()

		for i in currTargets:
			if "Soldier" in i.name:
				tempArray.append(i)

		var currTarget = null

		for i in tempArray: 
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")

		curr = currTarget
		pathName = currTarget.get_parent().name
 
		var tempbullet = bullet.instantiate()
		tempbullet.pathName=pathName
		tempbullet.bulletDamage=bulletDamage
		get_node("bulletContainer").call_deferred("add_child", tempbullet)
		tempbullet.global_position = aim.global_position


func _on_tower_body_exited(_body):
	pass
