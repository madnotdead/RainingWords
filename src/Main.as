package
{	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.IntroWorld;
	/**
	 * ...
	 * @author madnotdead
	 */
	
	public class Main extends Engine 
	{
		
		public function Main() 
		{
			super(400, 600);
		}
		
		override public function init():void 
		{
			super.init();
			trace("game initialized");
			
			FP.world = new IntroWorld();
			FP.console.enable();
			FP.console.toggleKey = 188;
		}
	}
	
}