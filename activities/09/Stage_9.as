package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.*;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import RandomPlus;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.events.DataEvent;
	
	public class Stage_9 extends MovieClip
	{
		
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		
		private var firstStage:MovieClip;
		private var cardsArray:Array;
		private var cardHitArray:Array;
		private var StartPoxX:Number;
		private var StartPoxY:Number;
		private var CurrentIndex:int;

		private var numberTextArray:Array;
		private var randomPlus:RandomPlus;
		private var randomIndex:int
		private var CorrectCounter:int
		private var forRandom:Array
		private var soundControl:SoundControl;
		
		public function Stage_9(_stageWidth:Number = 1024, _stageHeight:Number = 768)
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
			
			addStage();
			cardsArray = [firstStage.Card_1, firstStage.Card_2, firstStage.Card_3, firstStage.Card_4, firstStage.Card_5, firstStage.Card_6, firstStage.Card_7, firstStage.Card_8, firstStage.Card_9, firstStage.Card_10, firstStage.Card_11, firstStage.Card_12, firstStage.Card_13, firstStage.Card_14]
			cardHitArray = [firstStage.CardHit_1, firstStage.CardHit_2, firstStage.CardHit_3, firstStage.CardHit_4, firstStage.CardHit_5, firstStage.CardHit_6, firstStage.CardHit_7, firstStage.CardHit_8, firstStage.CardHit_9, firstStage.CardHit_10, firstStage.CardHit_11, firstStage.CardHit_12, firstStage.CardHit_13, firstStage.CardHit_14]
			
			
			forRandom = [{start: 0, end: 13}, {start: 13, end: 26}]
			
			numberTextArray = ["21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
			
			randomPlus = new RandomPlus(forRandom[0].start, forRandom[0].end);
			
			
			addListeners();
			
		
		}
		
		private function addListeners():void
		{
		
			
			for (var i:int = 0; i < cardsArray.length; i++)
			{	
				
				randomIndex = randomPlus.getNum();
				
				cardsArray[i].num.text = numberTextArray[randomIndex];
				cardHitArray[i].num.alpha = 0
				
				//cardsArray[i].Cardcover.alpha = 0.5;
				
				cardHitArray[i].num.text = numberTextArray[i]
				cardsArray[i].addEventListener (MouseEvent.MOUSE_DOWN, StartDragFunc)
				//cardsArray[i].addEventListener (MouseEvent.MOUSE_UP, StopDragFunc)
				
				
				///FOR EXAMPLE
				if (cardsArray[i].num.text == 21)
				{
					
					TweenLite.to(cardsArray[i].Cardcover, 0.5, {alpha:0});
					TweenLite.to(cardsArray[i], 1.5, { x:firstStage.CardHit_1.x, y:firstStage.CardHit_1.y } );
					TweenMax.to(cardsArray[i], 2, { glowFilter: { color:0x91e600, alpha:1, blurX:15, blurY:15, strength:3, remove:true }} );
					setTimeout(CorrecteFunc, 1500)
					
					cardsArray[i].removeEventListener (MouseEvent.MOUSE_UP, StopDragFunc);
					cardsArray[i].removeEventListener (MouseEvent.MOUSE_DOWN, StartDragFunc);
					
				}
			}
		}
		
		private function StartDragFunc (e:MouseEvent):void
		{
			e.currentTarget.addEventListener (MouseEvent.MOUSE_UP, StopDragFunc);
			//sawyisi koordinatebi
			StartPoxX = e.currentTarget.x;
			StartPoxY = e.currentTarget.y;
			//yoveltvis zemodan iqnba sxvebze!! 
			e.currentTarget.parent.setChildIndex(DisplayObject(e.currentTarget),  e.currentTarget.parent.numChildren-1)
			
			TweenLite.to(e.currentTarget.Cardcover, 0.2, {alpha:0});
			
			e.currentTarget.startDrag();
			
			for (var i:int = 0; i <	cardsArray.length; i++ )
			{
				if (e.currentTarget.num.text == cardHitArray[i].num.text)
				{
					CurrentIndex = i;
				}
			}
		}
		
		private function StopDragFunc (e:MouseEvent):void
		{
			
			
			if ((e.currentTarget.hitTestObject(cardHitArray[CurrentIndex]))&&(e.currentTarget.num.text == cardHitArray[CurrentIndex].num.text))
			{
				
				CorrecteFunc();
				e.currentTarget.x = cardHitArray[CurrentIndex].x
				e.currentTarget.y = cardHitArray[CurrentIndex].y
				e.currentTarget.stopDrag();
				TweenMax.to(e.currentTarget, 1, { glowFilter: { color:0x91e600, alpha:1, blurX:15, blurY:15, strength:3, remove:true }} );
				e.currentTarget.removeEventListener (MouseEvent.MOUSE_UP, StopDragFunc);
				e.currentTarget.removeEventListener (MouseEvent.MOUSE_DOWN, StartDragFunc);
				return
			}
			
			TweenLite.to(e.currentTarget, 0.5, {x:StartPoxX, y:StartPoxY});
			TweenLite.to(e.currentTarget.Cardcover, 0.2, {alpha:1});
			e.currentTarget.stopDrag();
			FalseFunc();
			TweenMax.to(e.currentTarget, 1, { glowFilter: { color:0xff0000, alpha:1, blurX:15, blurY:15, strength:3, remove:true }} );
		}
		
		
		private function CorrecteFunc()
		{
			soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 0.5);
			addChild(soundControl);
			soundControl.soundPlay();
			
			if (CorrectCounter == 13)
			{
				//destroycaller
				ClapFunc();
			}
			
			CorrectCounter++
			trace (CorrectCounter)
		}
		private function FalseFunc()
		{
			soundControl = new SoundControl();
			soundControl.loadSound("error.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
		}
			private function ClapFunc()
		{
			soundControl = new SoundControl();
			soundControl.loadSound("clap.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
		}
		
		private function addStage():void
		{
			firstStage = new FirstStage();
			addChild(firstStage);
			
			firstStage.x = _stageWidth / 2;
			firstStage.y = _stageHeight / 2;
			firstStage.height = _stageHeight / 1.5;
			firstStage.scaleX = firstStage.scaleY;
		}


	
	}

}
