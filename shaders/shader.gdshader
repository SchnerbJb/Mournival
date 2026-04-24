shader_type canvas_item;

uniform float blue = 1.0;

void vertex() {
	
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.b = lue;
}
