import "package:image_extensions/image_extensions.dart";

void main() async {
  final Image canvas = Image(1000, 1000);
  drawLinearGradient(
    canvas,
    0,
    0,
    canvas.width,
    canvas.height,
    getColor(61, 144, 245),
    getColor(27, 116, 244),
  );
  await canvas.saveAsPNG("build/gradient.png");
}
