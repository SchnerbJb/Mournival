shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 0.2, 0.08);

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	
	float alpha = c.a;
	float alpha_right = texture(TEXTURE, UV+vec2(0.01, 0.0)).a;
	
	float wave = sin(TIME) * amplitude;
}

