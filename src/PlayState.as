package{
    import org.flixel.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;


    public class PlayState extends FlxState{
        [Embed(source="../assets/tiles.png")] private var ImgCube:Class;

        public var _world:b2World;
        private var ratio:Number = 30;
        public var dad:Dad;
        public var player:Player;
        public var floor:B2FlxTileblock;
        public var fish:B2FlxSprite;
        public var sizeCounter:Number = 20;
        public var deadFish:FlxGroup = new FlxGroup();

        override public function create():void{
            setupWorld();

            floor = new B2FlxTileblock(0, 400, 640, 80, _world);
            floor.createBody();
            floor.makeGraphic(640, 80);
            add(floor);

            dad = new Dad(_world);
            player = new Player(20,20);
            add(player);

            makeFish(20);
        }

        private function setupWorld():void{
            var gravity:b2Vec2 = new b2Vec2(0,9.8);
            _world = new b2World(gravity,true);
            var debugDrawing:DebugDraw = new DebugDraw();
            debugDrawing.debugDrawSetup(_world, ratio, 1.0, 1, 0.5);
        }

        private function makeFish(size:Number):void{
            var fixtureDef:b2FixtureDef = new b2FixtureDef();
            fixtureDef.density = size*.005;

            fish = new B2FlxSprite(320, 240, size, size, _world);
            fish.createBody(b2Body.b2_dynamicBody, null, fixtureDef);
            fish.makeGraphic(size, size);
            add(fish);
            dad.hook(fish);
        }

        public function spriteCollide(fish:B2FlxSprite,player:Player):void{
            if(player.isTouching(FlxObject.DOWN) && fish.isTouching(FlxObject.UP)){
                deadFish.add(fish);
                dad.hook(null);
                sizeCounter += 2;
                makeFish(sizeCounter);
            } else {
                player.fill(0xFFFF0000);
            }
        }

        public function spriteCollide2(floor:B2FlxTileblock,player:Player):void{
        }

        public function deadFishCollide(dead:FlxSprite,player:Player):void{
        }

        override public function update():void{
            _world.Step(FlxG.elapsed, 10, 10);
            _world.DrawDebugData();
            FlxG.collide(fish,player,spriteCollide);
            FlxG.collide(deadFish,player,deadFishCollide);
            FlxG.collide(floor,player,spriteCollide2);

            dad.update();

            super.update();
        }
    }
}
