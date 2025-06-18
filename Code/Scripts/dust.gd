@tool
extends GPUParticles2D

@export var emission_box : Vector2:
	set(value):
		
		print(value)
		self.process_material.emission_box_extents.xy = value
		
