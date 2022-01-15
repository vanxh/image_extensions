import "package:image_extensions/image_extensions.dart";

void main() async {
  final Image? image = await loadImage(
      "https://avatars.githubusercontent.com/u/71810662?s=400&u=20d056ba55558adaa53e125e0bdca43a14e6073f&v=4");

  await copyResize(image!, width: 100, height: 100).saveAsPNG("final.png");
}
