library simplegamelib.test;

import 'package:simplegamelib/simplegamelib.dart';
import 'package:test/test.dart';
import 'helpers.dart';
import 'dart:html';

void main() {
  group('Core :', () {
    setUp(() {});

    test('Background', () {
      Background s = new Background(getCanvas(), new Rectangle(0, 0, 800, 600));
      expect(s, isNotNull);
    });

    test('Arena', () {
      Arena s = new Arena();
      expect(s, isNotNull);
    });

    test('Player', () {
      Player s = new Player();
      expect(s, isNotNull);
      expect(s.sprite, isNull);
    });

    test('Game', () {
      Game s = new Game("test");
      expect(s.name, equals("test"));
      expect(s, isNotNull);
    });
  });
  group('Renderer : ', () {
    test('Creation', () {
      CanvasRenderingContext2D GameCanvas = getCanvas();
      Renderer myRenderer =
          new Renderer(GameCanvas, new Rectangle(0, 0, 800, 600));
      expect(myRenderer, isNotNull);
    });

    test('Draw', () {
      CanvasRenderingContext2D GameCanvas = getCanvas();
      Renderer s = new Renderer(GameCanvas, new Rectangle(0, 0, 800, 600));
      s.draw();
      expect(s, isNotNull);
    });
  });

  group('Sprite : ', () {
    setUp(() {});

    test('Creation', () {
      Sprite s = createSprite();
      expect(s, isNotNull);
    });

    test('Movement', () {
      Sprite s = createSprite();
      s.setMovement(10, 15);
      s.update();
      s.update();
      s.update();

      expect(s.x, equals(31));
      expect(s.y, equals(47));
      expect(s.rect.left, equals(31));
      expect(s.rect.top, equals(47));
      expect(s.rect.height, equals(4));
      expect(s.rect.width, equals(3));
    });

    test('Speed', () {
      Sprite s = createSprite();
      s.setMovement(10, 15);
      s.update();
      s.update();
      s.update();

      expect(s.x, equals(31));
      s.speed = 2;

      s.update();
      s.update();
      s.update();

      expect(s.x, equals(91));

    });

  });

  group('SpriteGroup : ', () {
    test('Creation', () {
      SpriteGroup s = new SpriteGroup();
      expect(s, isNotNull);
    });

    test('Population', () {
      SpriteGroup sg = createSpriteGroup(4);
      expect(sg.length, equals(4));
    });

    test('Reset', () {
      SpriteGroup sg = createSpriteGroup(4);
      sg.reset();
      expect(sg.length, equals(0));
    });

    test('Reverse', () {
      SpriteGroup sg = createSpriteGroup(4);
      sg.sprites[0].height = 100;
      sg.reverse();
      expect(sg.sprites[0].height, 4);
      expect(sg.sprites[3].height, 100);
    });

    test('Check empty', () {
      SpriteGroup sg = createSpriteGroup(4);
      expect(sg.empty, equals(false));
      sg.reset();
      expect(sg.empty, equals(true));
    });

    test('Update', () {
      SpriteGroup sg = createSpriteGroup(4);
      sg.sprites.forEach((Sprite s) => s.setMovement(5, 10));
      sg.update();
      expect(sg.sprites[0].x, equals(6));
      expect(sg.sprites[1].y, equals(12));
      expect(sg.sprites[2].x, equals(6));
      expect(sg.sprites[3].y, equals(12));
    });

    test('Remove Dead Sprites', () {
      SpriteGroup sg = createSpriteGroup(4);
      sg.sprites[0].alive = false;
      sg.removeDead();
      expect(sg.length, equals(3));
      sg.sprites[0].alive = false;
      sg.removeDead();
      expect(sg.length, equals(2));
      sg.sprites[0].alive = false;
      sg.removeDead();
      expect(sg.length, equals(1));
      sg.sprites[0].alive = false;
      sg.removeDead();
      expect(sg.length, equals(0));
    });

    test('Detect collision with other Sprite', () {
      SpriteGroup sg = createSpriteGroup(4);
      sg.add(new Sprite(110, 110, 10, 10));
      Sprite s1 = new Sprite(0, 0, 10, 10);
      expect(sg.detectCollision(s1).length, 4);
    });

    test('Add limiter to a Sprite', () {
      Sprite sg = new Sprite(10, 10, 10, 10);
      sg.limits = new Rectangle(0,0,100,100);
      sg.movement = new Point(-10,-10);
      print(sg.rect);
      sg.update();print(sg.rect);
      sg.update();print(sg.rect);
      sg.update();print(sg.rect);
      expect(sg.x, 0);
      expect(sg.y, 0);
      sg.movement = new Point(10,5);
      sg.update();
      sg.update();
      sg.update();
      sg.update();
      sg.update();
      expect(sg.x, 50);
      expect(sg.y, 25);
      sg.movement = new Point(10,50);
      sg.update();
      sg.update();
      sg.update();
      sg.update();
      sg.update();
      sg.update();
      expect(sg.x, lessThan(101));
      expect(sg.y, lessThan(101));
    });

    test('Detect collision with some dying Sprites', () {
      SpriteGroup sg = createSpriteGroup(4);
      Sprite dyingSprite = sg.sprites[0];
      dyingSprite.dying = true;
      sg.add(dyingSprite);

      Sprite s1 = new Sprite(0, 0, 10, 10);
      expect(sg.detectCollision(s1).length, 3);
    });
  });

  group('Limiter :', () {
    test('Limiter', () {
      Limiter s = new Limiter();
      print(s);
    });
  });

  group('Assets :', () {
    setUp(() {});

    test('ResourcePack', () {
      ResourcePack s = new ResourcePack();
      print(s);
    });

    test('Audio', () {
      AudioBank s = new AudioBank();
      print(s);
    });
  });
}
