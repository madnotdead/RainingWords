package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class GameOverWorld extends World 
	{
		
		private var _score:Number;
		public function GameOverWorld(score:Number) 
		{
			super();
			FP.screen.color = 0x00FF00;
			_score = score;
		}
		
		override public function begin():void 
		{
			super.begin();
			trace("SCORE: " + _score);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.ANY))
			{
				FP.world = new IntroWorld();
			}
		}
		
	}

}