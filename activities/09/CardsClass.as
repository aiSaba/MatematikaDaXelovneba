package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import RandomPlus;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.events.DataEvent;
	
	public class CardsClass extends MovieClip
	{
		
		private var firstStage:MovieClip;
		private var cardsArray:Array;
		private var cardHitArray:Array;
		private var currentIndex:int
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var numberTextArray:Array;
		private var cardsXarray:Array; // sawyisi koordinatebis masivi
		private var cardsYarray:Array;
		private var randomPlus:RandomPlus;
		private var randomIndex:int
		private var counterCorrect:int
		private var forRandom:Array
		private var scoreCounter:int
		private var soundControl:SoundControl;
		
		public function CardsClass(_stageWidth:Number = 1024, _stageHeight:Number = 768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		
		}
		
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			soundControl = new SoundControl();
			addChild(soundControl);
			YvelaferiFunc();
		}
		
		private function YvelaferiFunc():void
		{
			
			addStage();
			cardsArray = [firstStage.Card_1, firstStage.Card_2, firstStage.Card_3, firstStage.Card_4, firstStage.Card_5, firstStage.Card_6, firstStage.Card_7, firstStage.Card_8, firstStage.Card_9, firstStage.Card_10, firstStage.Card_11, firstStage.Card_12, firstStage.Card_13, firstStage.Card_14]
			cardHitArray = [firstStage.CardHit_1, firstStage.CardHit_2, firstStage.CardHit_3, firstStage.CardHit_4, firstStage.CardHit_5, firstStage.CardHit_6, firstStage.CardHit_7, firstStage.CardHit_8, firstStage.CardHit_9, firstStage.CardHit_10, firstStage.CardHit_11, firstStage.CardHit_12, firstStage.CardHit_13, firstStage.CardHit_14]
			
			cardsXarray = [firstStage.Card_1.x, firstStage.Card_2.x, firstStage.Card_3.x, firstStage.Card_4.x, firstStage.Card_5.x, firstStage.Card_6.x, firstStage.Card_7.x, firstStage.Card_8.x, firstStage.Card_9.x, firstStage.Card_10.x, firstStage.Card_11.x, firstStage.Card_12.x, firstStage.Card_13.x, firstStage.Card_14.x]
			cardsYarray = [firstStage.Card_1.y, firstStage.Card_2.y, firstStage.Card_3.y, firstStage.Card_4.y, firstStage.Card_5.y, firstStage.Card_6.y, firstStage.Card_7.y, firstStage.Card_8.y, firstStage.Card_9.y, firstStage.Card_10.y, firstStage.Card_11.y, firstStage.Card_12.y, firstStage.Card_13.y, firstStage.Card_14.y]
			
			forRandom = [{start: 0, end: 13}, {start: 13, end: 26}]
			
			numberTextArray = ["21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
			
			randomPlus = new RandomPlus(forRandom[0].start, forRandom[0].end);
			
			addListeners();
			
			counterCorrect = numberTextArray[0]
		
		}
		
		private function addListeners():void
		{
			
			for (var p:int = 0; p < cardHitArray.length; p++)
			{
				cardHitArray[p].num.alpha = 0
			}
			
			for (var i:int = 0; i < cardsArray.length; i++)
			{
				
				randomIndex = randomPlus.getNum();
				
				cardHitArray[i].num.text = numberTextArray[i]
				cardsArray[i].num.text = numberTextArray[randomIndex];
				cardsArray[i].addEventListener(MouseEvent.MOUSE_DOWN, cardAlpha0)
				///////cardsArray[i].addEventListener (MouseEvent.MOUSE_UP, cardAlphaX)
				cardsArray[i].addEventListener(MouseEvent.MOUSE_DOWN, dragObject)
				cardsArray[i].addEventListener(MouseEvent.MOUSE_UP, stopDragObject)
				cardsArray[i].addEventListener(MouseEvent.MOUSE_UP, hitTestFunc)
			
				cardsArray[i].CardHide_1.addEventListener(MouseEvent.MOUSE_DOWN, checkFunc)
			}
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
		
		private function checkFunc(e:MouseEvent):void
		{
			for (var i:int = 0; i < cardsArray.length; i++)
			{
				
				if (e.currentTarget == cardsArray[i].CardHide_1)
				{
					currentIndex = i
					return;
				}
			}
		}
		
		private function hitTestFunc(e:Event):void
		{
			
			allInvisible();
			
			
			for (var i:int = 0; i < cardsArray.length; i++)
			{
				if (cardsArray[currentIndex].num.text == counterCorrect)
				{
					if ((cardsArray[currentIndex].hitTestObject(cardHitArray[i])) && (cardsArray[currentIndex].num.text == cardHitArray[i].num.text) )
					{
						
						counterCorrect++;
						cardsArray[currentIndex].x = cardHitArray[i].x
						cardsArray[currentIndex].y = cardHitArray[i].y
						TrueFunc();
						
						TweenMax.to(e.currentTarget, 0.2, {glowFilter: {color: 0x91e600, alpha: 1, blurX: 30, blurY: 30, strength: 3, remove: true}, ease: Expo.easeOut});
						
						//TweenMax.to(e.currentTarget, 0.1, { delay:500, visible:false} );
						
						//	setTimeout(cardAlpha00, 602 )
						//aqq 
						cardsArray[currentIndex].removeEventListener(MouseEvent.MOUSE_DOWN, cardAlpha0)
						/////cardsArray[currentIndex].removeEventListener (MouseEvent.MOUSE_UP, cardAlphaX)
						cardsArray[currentIndex].removeEventListener(MouseEvent.MOUSE_DOWN, dragObject)
						cardsArray[currentIndex].removeEventListener(MouseEvent.MOUSE_UP, stopDragObject)
						cardsArray[currentIndex].removeEventListener(MouseEvent.MOUSE_DOWN, hitTestFunc)
						cardsArray[currentIndex].CardHide_1.removeEventListener(MouseEvent.MOUSE_DOWN, checkFunc)
						scoreCounter++
						
						cardsArray[currentIndex].notAlowed = true;
						cardsArray[currentIndex].CardHide_1.visible = false;
						
						if (scoreCounter == 14)
						{
							FinalFunc();
						}
						
						return
						
					}
					else
					{
						if (!cardsArray[i].notAlowed)
						{
							TweenLite.to(cardsArray[i], 1, {x: cardsXarray[i], y: cardsYarray[i]});
						}
						
					}
				}
				
				if (cardsArray[currentIndex].num.text != counterCorrect)
				{
					ErrorFunc();
					TweenMax.to(cardsArray[currentIndex], 0.5, {glowFilter: {color: 0xcc0000, alpha: 1, blurX: 30, blurY: 30, remove: true}, ease: Expo.easeOut});
					TweenLite.to(cardsArray[currentIndex], 1, {x: cardsXarray[currentIndex], y: cardsYarray[currentIndex]});
				}
				
			}
		}
		
		private function allInvisible():void
		{
			for (var i:int = 0; i < cardsArray.length; i++)
			{
				if (cardsArray[i].notAlowed)
				{
					
					continue;
				}
				cardsArray[i].CardHide_1.visible = true;
				cardsArray[i].CardHide_1.alpha = 0.5;
				
			}
		}
		
		private function destroyCaller():void
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
			destroy();
		}
		
		private function destroy():void
		{
			
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeChild(firstStage);
			firstStage = null
			TweenMax.killAll();
			scoreCounter = 0
		
		}
		
		private function cardAlpha0(e:MouseEvent):void
		{
			e.currentTarget.CardHide_1.visible = false;
			return
		}
		
		private function cardAlpha00():void
		{
			cardsArray[currentIndex].CardHide_1.visible = false;
			return
		}
		
		////	private function cardAlphaX(e:MouseEvent):void
		////	{
		/////       setTimeout(cardAlpha1, 600 )
		////		return
		////	}
		
		private function cardAlpha1():void
		
		{
			cardsArray[currentIndex].CardHide_1.visible = true
			return
		}
		
		private function dragObject(e:MouseEvent):void
		{
			var mc:MovieClip = e.currentTarget as MovieClip;
			mc.startDrag();
			
			mc.parent.setChildIndex(mc, mc.parent.numChildren - 1);
			
			return
		}
		
		private function stopDragObject(e:MouseEvent):void
		{
			e.currentTarget.stopDrag();
			return
		}
		
		private function ErrorFunc():void
		{
			
			soundControl.loadSound("error.mp3", 0.8);
			try
			{
				soundControl.soundPlay();
				
			}
			catch (e:Error)
			{
				trace (e,"რაღაც ერორი")
			}
		
		}
		
		private function TrueFunc():void
		{
			///soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 0.5);
			/////addChild(soundControl);
			soundControl.soundPlay();
		}
		
		private function FinalFunc():void
		{
			///soundControl = new SoundControl();
			soundControl.loadSound("clap.mp3", 0.5);
			/////addChild(soundControl);
			soundControl.soundPlay();
			setTimeout(destroyCaller, 1500)
		}
	
	}

}
