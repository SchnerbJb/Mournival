shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float thickness : hint_range(0.001, 0.005) = 0.01;

void fragment() {
	vec4 c = texture(TEXTURE, UV);

	float a = c.a;
	float ar = texture(TEXTURE, UV + vec2(thickness, 0.0)).a;
	float al = texture(TEXTURE, UV + vec2(-thickness, 0.0)).a;
	float au = texture(TEXTURE, UV + vec2(0.0, thickness)).a;
	float ad = texture(TEXTURE, UV + vec2(0.0, -thickness)).a;

	float neighbor = max(max(ar, al), max(au, ad));

	float outline_mask = step(0.01, neighbor) * (1.0 - step(0.01, a));
	vec4 out_col = mix(c, outline_color, outline_mask);
	out_col.a = max(c.a, outline_mask * outline_color.a);

	COLOR = out_col;
}


