import 'dart:async';
import 'dart:html';
import 'package:RenderingLib/RendereringLib.dart';

import "package:CommonLib/Colours.dart";
import "package:LoaderLib/Loader.dart";

void main() {
    querySelector('#output').text = 'Your Dart app is running.';
    //start();
    testColourReplacement();
}

Future<Null> start() async {
    CanvasElement canvas = new CanvasElement(width: 130, height: 333);
    Renderer.drawWhateverFuture(canvas, "images/4.png");
    querySelector('#output').append(canvas);
}

Palette REFERENCE = new Palette()
    ..add("accent",             new Colour.fromHex(0xFF9B00))
    ..add("aspect_light",       new Colour.fromHex(0xFEFD49))
    ..add("aspect_dark",        new Colour.fromHex(0xFEC910))
    ..add("shoe_light",         new Colour.fromHex(0x10E0FF))
    ..add("shoe_dark",          new Colour.fromHex(0x00A4BB))
    ..add("cloak_light",        new Colour.fromHex(0xFA4900))
    ..add("cloak_mid",          new Colour.fromHex(0xE94200))
    ..add("cloak_dark",         new Colour.fromHex(0xC33700))
    ..add("shirt_light",        new Colour.fromHex(0xFF8800))
    ..add("shirt_dark",         new Colour.fromHex(0xD66E04))
    ..add("pants_light",        new Colour.fromHex(0xE76700))
    ..add("pants_dark",         new Colour.fromHex(0xCA5B00))
    //..add("hair_main",          new Colour.fromHex(0x313131))
    //..add("hair_accent",        new Colour.fromHex(0x202020))
    //..add("eye_white_left",     new Colour.fromHex(0xffba35))
    //..add("eye_white_right",    new Colour.fromHex(0xffba15))
    //..add("skin",               new Colour.fromHex(0xffffff))

    ..add("hair_main",          new Colour.fromHex(0x313131))
;

Palette MIND = new Palette()
    ..add("accent",       new Colour.fromHex(0x3da35a))
    ..add("aspect_light", new Colour.fromHex(0x06FFC9))
    ..add("aspect_dark",  new Colour.fromHex(0x04A885))
    ..add("shoe_light",   new Colour.fromHex(0x6E0E2E))
    ..add("shoe_dark",    new Colour.fromHex(0x4A0818))
    ..add("cloak_light",  new Colour.fromHex(0x1D572E))
    ..add("cloak_mid",    new Colour.fromHex(0x164524))
    ..add("cloak_dark",   new Colour.fromHex(0x11371D))
    ..add("shirt_light",  new Colour.fromHex(0x3DA35A))
    ..add("shirt_dark",   new Colour.fromHex(0x2E7A43))
    ..add("pants_light",  new Colour.fromHex(0x3B7E4F))
    ..add("pants_dark",   new Colour.fromHex(0x265133))

    ..add("hair_main",    new Colour.fromHex(0xFF000000, true))
;

Future<Null> testColourReplacement() async {
    ImageElement img = await Loader.getResource("images/test_colours.png");

    int testcount = 10;

    print("Control:");
    testAction(() {
        CanvasElement canvas = new CanvasElement(width: img.width, height: img.height);
        CanvasRenderingContext2D ctx = canvas.context2D;

        ctx.drawImage(img, 0, 0);
    }, testcount);

    print("Legacy:");
    testAction(() {
        CanvasElement canvas = new CanvasElement(width: img.width, height: img.height);
        CanvasRenderingContext2D ctx = canvas.context2D;

        ctx.drawImage(img, 0, 0);

        Renderer.swapPaletteLegacy(canvas, REFERENCE, MIND);
    }, testcount);

    print("New:");
    testAction(() {
        CanvasElement canvas = new CanvasElement(width: img.width, height: img.height);
        CanvasRenderingContext2D ctx = canvas.context2D;

        ctx.drawImage(img, 0, 0);

        Renderer.swapPalette(canvas, REFERENCE, MIND);
    }, testcount);

    // colour check
    {
        CanvasElement canvas = new CanvasElement(width: img.width, height: img.height);
        CanvasRenderingContext2D ctx = canvas.context2D;
        ctx.drawImage(img, 0, 0);
        Renderer.swapPaletteLegacy(canvas, REFERENCE, MIND);
        querySelector("#output")..append(canvas);
    }
    {
        CanvasElement canvas = new CanvasElement(width: img.width, height: img.height);
        CanvasRenderingContext2D ctx = canvas.context2D;
        ctx.drawImage(img, 0, 0);
        Renderer.swapPalette(canvas, REFERENCE, MIND);
        querySelector("#output")..append(canvas);
    }
}

typedef void Action();

void testAction(Action action, int repeats) {
    print("Starting test: $repeats iterations");
    DateTime then = new DateTime.now();

    for (int i=0; i<repeats; i++) {
        action();
    }

    DateTime now = new DateTime.now();
    int diff = now.microsecondsSinceEpoch - then.microsecondsSinceEpoch;
    double ms = diff / 1000;

    print("Test complete: $repeats iterations, total time $ms ms, average ${ms / repeats}ms per iteration");
}