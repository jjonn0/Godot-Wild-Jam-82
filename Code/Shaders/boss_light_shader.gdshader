shader_type canvas_item;

render_mode light_only;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	//COLOR = vec4(texture(TEXTURE, UV).rgba);
	//
	//COLOR.a -= 0.5;

}

void light() {

	// Create the light mask
	//vec4 light_mask = LIGHT_COLOR * COLOR;
	//
	//LIGHT = light_mask;

	// Creating the light mask while avoiding the transparency from the light to make the object see-through.
	// In turn we need to multiply the RGB Colours by the Light Alpha to allow shading instead.
	vec3 light_mask = LIGHT_COLOR.rgb * COLOR.rgb;

	float transparency_value;

	//if (LIGHT_COLOR.a <= 0.0) {
		//transparency_value = 0.0;
	//}
	//else {
		//transparency_value = COLOR.a;
	//}
//
	//LIGHT = vec4(light_mask * LIGHT_COLOR.a, transparency_value);
	
	if (LIGHT_COLOR.a <= 0.0) {
		transparency_value = 0.5;
	}
	else {
		transparency_value = 1.0;
	}

	LIGHT = vec4(COLOR.rgb * LIGHT_ENERGY, transparency_value * LIGHT_COLOR.a);

}
