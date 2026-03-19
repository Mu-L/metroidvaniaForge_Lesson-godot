class_name HitParticles
extends GPUParticles2D

func start_effect( settings : HitParticlesSettings , dir : Vector2 ) -> void :
	if settings :
		amount = settings.count
		modulate = settings.color
		texture = settings.texture
	
	process_material.direction = Vector3(dir.x , dir.y, 0)
	
		
	emitting = true
	await finished
	queue_free()
	pass
