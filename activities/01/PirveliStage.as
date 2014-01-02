package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import RandomPlus;
	import com.greensock.*; 
    import com.greensock.easing.*;
	import flash.events.DataEvent;
	
	public class PirveliStage extends MovieClip
	{
		
		private var tamashi:MovieClip;
		
		private var figureArray:Array
		private var textArray:Array
		private var randomPlus:RandomPlus
		private var randomIndex:int
		private var randomPlus1:RandomPlus;
		private var randomIndex1:Number;
		private var soundControl2:SoundControl;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var scoreCounter:int;
		
		
		
		
		var randomPos:int;
		public function PirveliStage(_stageWidth:Number = 1024, _stageHeight:Number = 768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			YvelaferiFunc();
		}
		
		private function YvelaferiFunc():void
		{
			
			tamashi = new Tamashi();
			addChild(tamashi);
			
			tamashi.x = _stageWidth / 2;
			tamashi.y = _stageHeight / 2;
			tamashi.height = _stageHeight/1.5;
			tamashi.scaleX = tamashi.scaleY;
			
			figureArray = [tamashi.circle, tamashi.Eqvskutxedi, tamashi.square, tamashi.Samkutxedi, tamashi.star, tamashi.Martkutxedi]
			textArray = [tamashi.text_circle, tamashi.text_Eqvskutxedi, tamashi.text_square, tamashi.text_Samkutxedi, tamashi.text_star, tamashi.text_Martkutxedi]
			
			tamashi.button_yes.addEventListener(MouseEvent.CLICK, yesFunc)
			tamashi.button_no.addEventListener(MouseEvent.CLICK, noFunc)
			
			randomPlus = new RandomPlus(0, 5);
			randomIndex = randomPlus.getNum();
			randomPlus1 = new RandomPlus(0, 5);
			randomIndex1 = randomPlus1.getNum();
			
			trace(randomIndex)
			trace(randomIndex1)
			
			for (var i:int = 0; i < figureArray.length; i++)
			{
				
				figureArray[i].visible = false;
				textArray[i].visible = false;
			}
			
			figureArray[randomIndex].visible = true;
			textArray[randomIndex1].visible = true;
		
		}
		
		
		private function yesFunc(ev:MouseEvent):void
		{
			
			if (randomIndex == randomIndex1)
			{
				trace("MOIGE")
				soundControl2 = new SoundControl;
				soundControl2.loadSound("correct.mp3", 1);
				addChild(soundControl2);
				soundControl2.soundPlay();
				setTimeout(endFunc, 2000);
				tamashi.button_yes.removeEventListener(MouseEvent.CLICK, yesFunc)
				tamashi.button_no.removeEventListener(MouseEvent.CLICK, noFunc)
				TweenMax.to(ev.currentTarget, 1, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, remove:true}});
				scoreCounter++
				
				if (scoreCounter == 3)
			{
				
				ClapFunc();
				
			}
				}
			else
			{
				trace("Waage")
				soundControl2 = new SoundControl;
				soundControl2.loadSound("error.mp3", 1);
				addChild(soundControl2);
				soundControl2.soundPlay();
				setTimeout(endFunc, 2000);
				tamashi.button_yes.removeEventListener(MouseEvent.CLICK, yesFunc)
				tamashi.button_no.removeEventListener(MouseEvent.CLICK, noFunc)
				TweenMax.to(ev.currentTarget, 1, {glowFilter:{color:0xff0033, alpha:1, blurX:30, blurY:30, remove:true}});
				
			}
		
		} 
		
		private function noFunc(ev:MouseEvent):void
		{
			
			if (randomIndex == randomIndex1)
			{
				trace("waage")
				soundControl2 = new SoundControl;
				soundControl2.loadSound("error.mp3", 1);
				addChild(soundControl2);
				soundControl2.soundPlay();
				setTimeout(endFunc, 2000);
				tamashi.button_yes.removeEventListener(MouseEvent.CLICK, yesFunc)
				tamashi.button_no.removeEventListener(MouseEvent.CLICK, noFunc)
				TweenMax.to(ev.currentTarget, 1, {glowFilter:{color:0xff0033, alpha:1, blurX:30, blurY:30, remove:true}});
			}
			else
				
			{
				soundControl2 = new SoundControl;
				soundControl2.loadSound("correct.mp3", 1);
				addChild(soundControl2);
				soundControl2.soundPlay();
				trace("moige")
				setTimeout(endFunc, 2000);
				tamashi.button_yes.removeEventListener(MouseEvent.CLICK, yesFunc)
				tamashi.button_no.removeEventListener(MouseEvent.CLICK, noFunc)
				TweenMax.to(ev.currentTarget, 1, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, remove:true}});
				scoreCounter++
			if (scoreCounter == 3)
			{
				ClapFunc();
			}
			}
		
		} 
		
		private function endFunc():void
		{
			if (scoreCounter == 3)
			{
				dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
				destroy();
				//ClapFunc();
				return
			}
			
			
			clearTimeout(1);
			
			destroy();
			YvelaferiFunc();
		
		}
		
		private function destroy():void
		{
			if (tamashi)
			{
				tamashi.button_yes.removeEventListener(MouseEvent.CLICK, yesFunc)
				tamashi.button_no.removeEventListener(MouseEvent.CLICK, noFunc)
				removeChild(tamashi);
				tamashi = null;
			}
		}
		
		private function ClapFunc()
		{
			soundControl2 = new SoundControl();
			soundControl2.loadSound("clap.mp3", 1);
			addChild(soundControl2);
			soundControl2.soundPlay();
		}
	
	}

}
