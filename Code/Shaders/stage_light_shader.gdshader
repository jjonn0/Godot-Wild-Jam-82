shader_type canvas_item;

varying vec4 lit_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	lit_color = COLOR;

	float average_color = (COLOR.r + COLOR.g + COLOR.b) / 3.0;

	COLOR = vec4(average_color, average_color, average_color, COLOR.a);

}

void light() {

	// Remove anything if it is outside the light
	//if (LIGHT_COLOR.rgb != vec3(0.0, 0.0, 0.0)) {
		//LIGHT = vec4(LIGHT_COLOR.rgb * lit_color.rgb * LIGHT_ENERGY, LIGHT_COLOR.a);
	//}

	if (LIGHT_COLOR.rgb != vec3(0.0, 0.0, 0.0)) {
		LIGHT = vec4(lit_color.rgb * LIGHT_ENERGY * LIGHT_COLOR.rgb, lit_color.a * LIGHT_COLOR.a);
	}

}
