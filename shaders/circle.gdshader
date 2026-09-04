shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.0, 0.01) = 0.7;
uniform float thickness : hint_range(0.0, 1.0, 0.01) = 0.1;
uniform float speed : hint_range(0.0, 1.0, 0.1) = 0.1;
uniform bool start = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	float current_radius = clamp(TIME*speed, 0.0, 1.0)*radius;
	
	vec2 centered = UV*2.0 - vec2(1.0, 1.0);
	float sum = pow(centered.x, 2) + pow(centered.y, 2);
	if (current_radius-thickness < sum && sum < current_radius+thickness)
		COLOR = vec4(1, 1, 0, 1);
}

void process() {
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
