package entities 
{
	import misc.Constants;
	import misc.Utils;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import worlds.GameWorld;
	
	/**
	 * ...
	 * @author madnotdead
	 */
	public class Word extends Entity 
	{
		
		private var _wordType:String;
		private var _speedY:int = 20;
		private var _wordText:Text = null;
		private var _wordInputText:String = null;
		private var _textOwner:Entity = null;
		private var _arrayWord:Array = null;
		private var _image:Image = null;
		private var _offSet:Number = 5;
		private var _soundGood:Sfx = null;
		private var _soundBad:Sfx = null;
		public function Word(x:Number=0, y:Number=0, speed:Number = 0, wordType:String = "", wordText:String = "", graphic:Graphic=null, mask:Mask=null) 
		{
			_wordType = wordType;
			
			_speedY = speed;
			_wordText = new Text(wordText, x + _offSet, y + _offSet);
			//_wordText = new Text(wordText, x , y );
			_wordInputText = _wordText.text;
			mask = new Pixelmask(Assets.WORD_IMAGE);
			
			if (wordType == Constants.WORD_SIMPLE)
				_image = new Image(Assets.WORD_IMAGE);
			else
			{
				_image = new Image(Assets.WORDS_IMAGE);	
				_arrayWord = _wordInputText.split("");
			}
				
			//_image.angle = _wordText.angle = Utils.randomRange(0, 90);
			graphic = _image;
			_soundGood = new Sfx(Assets.WORD_SOUND_GOOD);
			_soundBad = new Sfx(Assets.WORD_SOUND_BAD);
			super(x, y, graphic, mask);
		}
		
		override public function added():void 
		{
			super.added();
			_textOwner = FP.world.addGraphic(_wordText);
		}
		override public function update():void 
		{
			super.update();
			
			y += _speedY * FP.elapsed;
			_wordText.y = y + _offSet;
			//_wordText.y = y;
			
			if (_wordType == Constants.WORD_SIMPLE)
			{
				if (Input.pressed(_wordInputText))
				{
					trace("WordText: " + _wordInputText);
					GameWorld(FP.world).GameScore.AddScore(5);
					_soundGood.play();
					FP.world.remove(_textOwner);
					FP.world.remove(this);
					
				}
			}
			else
			{
				if (Input.check(Key.SPACE))
				{
					for (var i:int = 0; i < _arrayWord.length; i++) 
					{
						trace("key: " + _arrayWord[i]);
						if (Input.pressed(_arrayWord[i]))
						{
							_arrayWord.splice(i, 1);
						}
					}
					
					if (_arrayWord.length == 0)
					{
						_soundGood.play();
						GameWorld(FP.world).GameScore.AddScore(10);
						FP.world.remove(_textOwner);
						FP.world.remove(this);
					}
					
				}
			}

			if ( y + 16 >= FP.screen.height)
			{
				_soundBad.play();
				FP.world.remove(this);
				_wordText.color = 0xFF3300;
				GameWorld(FP.world).allowedPassed--;
			}
		}
		
	}

}