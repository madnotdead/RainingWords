package worlds 
{
	import entities.Score;
	import entities.Word;
	import misc.Constants;
	import misc.Utils;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author madnotdead
	 */
	public class GameWorld extends World
	{
		
		public var GameScore:Score = null;
		private var gameTime:Number = .75;
		private var gameTimeCounter:Number = 0;
		private var speed:Number = Constants.INITIAL_SPEED;
		public var allowedPassed:int = 5;
		private var _background:Image = null;
		private var _cloudImage:Image = null;
		private var _mainTheme:Sfx = null;
		
		public function GameWorld() 
		{
			FP.screen.color = 0x330000;
			GameScore = new Score(FP.screen.width - 200, FP.screen.height - 40);
			_background = new Image(Assets.PLAY);
			_cloudImage = new Image(Assets.CLOUD);
			_cloudImage.x = (FP.screen.width - _cloudImage.scaledWidth) / 2;
			_cloudImage.y = -50;
			
			_mainTheme = new Sfx(Assets.MAIN);
			_mainTheme.loop();
		}
		
		override public function begin():void 
		{
			super.begin();
			addGraphic(_background,100);
			addGraphic(_cloudImage);
			add(GameScore);
			
			DefineKeysString();
		}
		override public function update():void 
		{
			super.update();
			//if (Input.pressed(Key.BACKSPACE))
				//FP.world = new GameOverWorld(10);
			gameTimeCounter += FP.elapsed;
			
			if (gameTimeCounter > gameTime)
			{
				var wordTypeRandom:Number = Utils.randomRange(0, 200);
				
				var wordType:String = (wordTypeRandom > 180) ? Constants.WORD_MULTIPLE : Constants.WORD_SIMPLE;
				
				//var wordText:String = null;
				
				if (wordType == Constants.WORD_SIMPLE)
				{
					var randomCode:int = Utils.randomRange(65, 90);
					add(new Word(Utils.randomRange(0, FP.screen.width - 32), 0, speed, Constants.WORD_SIMPLE, Key.name(randomCode)));
					speed += Constants.SPEED_SIMPLE_MODIFIER;
				}
				else
				{
					add(new Word(Utils.randomRange(0, FP.screen.width - 64), 0, speed, Constants.WORD_MULTIPLE, getWordByNumber(Utils.randomRange(1, 4))));
					speed += Constants.SPEED_MULTIPLE_MODIFIER;
				}
				
				gameTimeCounter = 0;
			}
			
			if (allowedPassed <= 0)
			{
				_mainTheme.stop();
				FP.world = new GameOverWorld(GameScore.GetScore);
			}

		}
		
		private function DefineKeysString():void
		{
			Input.define("A", Key.A);
			Input.define("B", Key.B);
			Input.define("C", Key.C);
			Input.define("D", Key.D);
			Input.define("E", Key.E);
			Input.define("F", Key.F);
			Input.define("G", Key.G);
			Input.define("H", Key.H);
			Input.define("I", Key.I);
			Input.define("J", Key.J);
			Input.define("K", Key.K);
			Input.define("L", Key.L);
			Input.define("M", Key.M);
			Input.define("N", Key.N);
			Input.define("O", Key.O);
			Input.define("P", Key.P);
			Input.define("Q", Key.Q);
			Input.define("R", Key.R);
			Input.define("S", Key.S);
			Input.define("T", Key.T);
			Input.define("U", Key.U);
			Input.define("V", Key.V);
			Input.define("W", Key.W);
			Input.define("X", Key.X);
			Input.define("Y", Key.Y);
			Input.define("Z", Key.Z);
		}
		
		private function getWordByNumber(wordIndex:int):String
		{
			var word:String = "";
			
			switch(wordIndex)
			{
				case 1:
					word = "DOG";
					break;
				case 2:
					word = "CAT";
					break;
				case 3:
					word = "WHALE";
					break;
				case 4:
					word = "GOAT";
					break;
			}
			
			return word;
		}
	}

}