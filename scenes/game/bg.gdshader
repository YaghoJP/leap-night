shader_type canvas_item;

void vertex() {
	UV.x += TIME * 0.3;
	UV.y += TIME * 0.3;
}
