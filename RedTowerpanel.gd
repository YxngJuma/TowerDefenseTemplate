extends Panel


@onready var tower  = preload("res://towers/redbullettower.tscn")
var currTile

func _on_gui_input(event:InputEvent):
	var tempTower = tower.instantiate()
	var mouseposition=get_global_mouse_position()
	if event is InputEventMouseButton and event.button_mask ==1:
		#Left click down
		add_child(tempTower)
		tempTower.process_mode = Node.PROCESS_MODE_DISABLED
		

	elif event is InputEventMouseMotion and event.button_mask ==1:
		#Left click down drag
		if get_child_count()>1:
			get_child(1).global_position= mouseposition
	
			var mapPath =get_tree().get_root().get_node("Main/TileMap")
			var tile= mapPath.local_to_map(get_global_mouse_position())
			currTile= mapPath.get_cell_atlas_coords(0, tile, false)
			if (currTile == Vector2i(4,5)):
				get_child(1).get_node("Area").modulate = Color(0,255,0)

	elif event is InputEventMouseButton and event.button_mask == 0:
		#Left click up
		if event.global_position.x >=2944:
			if get_child_count() > 1:
				get_child(1).queue_free()
		else:
			if get_child_count() == 0:
				return
			var path = get_tree().get_root().get_node("Main/towers")

			path.add_child(tempTower)
			tempTower.global_position= get_global_mouse_position()
			#tempTower.get_node("Area").hide()
			get_child(1).queue_free()

