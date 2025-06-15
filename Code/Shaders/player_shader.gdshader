shader_type canvas_item;

/** The colour that flashes when the player takes damage. */
instance uniform vec4 flash_colour : source_color = vec4(1.0);
instance uniform float flash_value : hint_range(0.0, 1.0, 0.1) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec4 texture_colour = texture(TEXTURE, UV);
	texture_colour.rgb = mix(texture_colour.rgb, flash_colour.rgb, flash_value);
	COLOR = texture_colour;
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
