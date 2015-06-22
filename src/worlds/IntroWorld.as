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
	public class IntroWorld extends World 
	{
		
		public function IntroWorld() 
		{
			super();		
			FP.screen.color = 0x0066FF;
		}
		
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.ANY))
				FP.world = new GameWorld();
		}
		
	}

}