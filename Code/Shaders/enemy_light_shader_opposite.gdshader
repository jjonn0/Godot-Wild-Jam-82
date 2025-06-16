shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	//float average_color = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
	//
	//COLOR = vec4(average_color, average_color, average_color, 1.0);

}

void light() {

	// Create the light mask
	//vec4 light_mask = LIGHT_COLOR * COLOR;
	//
	//LIGHT = light_mask;

	// Creating the light mask while avoiding the transparency from the light to make the object see-through.
	// In turn we need to multiply the RGB Colours by the Light Alpha to allow shading instead.
	//vec3 light_mask = LIGHT_COLOR.rgb * COLOR.rgb;
	//
	//float transparency_value;
	//
	//if (LIGHT_COLOR.a <= 0.0) {
		//transparency_value = COLOR.a;
	//}
	//else {
		//transparency_value = 0.0;
	//}
	//
	//LIGHT = vec4(light_mask * LIGHT_COLOR.a, transparency_value);
	
	if (LIGHT_COLOR.a > 0.0) {
		discard;
	}

}
