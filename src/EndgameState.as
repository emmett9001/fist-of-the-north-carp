package
{
    import org.flixel.*;

    public class EndgameState extends FlxState
    {

        public var score:Number;

        public function EndgameState(_score:Number):void{
            super();
            score = _score;
        }

        override public function create():void
        {
            var t:FlxText;
            t = new FlxText(0,FlxG.height/2-10,FlxG.width,"you lose\nfish: " + score);
            t.size = 16;
            t.alignment = "center";
            add(t);
            t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"DOWN to retry");
            t.alignment = "center";
            add(t);

            FlxG.mouse.show();
        }

        override public function update():void
        {
            super.update();

            if(FlxG.keys.DOWN)
            {
                FlxG.mouse.hide();
                FlxG.switchState(new PlayState());
            }
        }
    }
}
