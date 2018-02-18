import 'dart:html';
import 'package:RenderingLib/RendererLib.dart';
import 'dart:async';

void main() {
    querySelector('#output').text = 'Your Dart app is running.';
    start();

}

Future<bool> start() async {
    CanvasElement canvas = new CanvasElement(width: 130, height: 333);
    Renderer.drawWhateverFuture(canvas, "images/4.png");
    querySelector('#output').append(canvas);
}
