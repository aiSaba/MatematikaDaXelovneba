package
{
	
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.geom.Point;
	import flash.utils.*;
	import flash.events.DataEvent;
	
	public class Stage4Class extends MovieClip
	{
		
		private var stage4Objects:MovieClip;
		private var stage4_2:MovieClip;
		private var stage4_3:MovieClip;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		
		private var numberArray:Array;
		private var numberTextArray:Array;
		private var numberHitArray:Array;
		private var numberTextBoxArray:Array
		private var randomPlus:RandomPlus;
		private var randomIndex:int
		private var StartCordinats:Point;
		private var currentIndex:int
		private var numberXarray:Array
		private var numberYarray:Array
		private var scoreCounter:int;
		private var stageIndex:int;
		private var soundControl:SoundControl;
		private var stageArray:Array;
		
		public function Stage4Class(_stageWidth:Number = 1024, _stageHeight:Number = 768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function destroy(event:Event):void
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeChild(stageArray[stageIndex]);
			//stageArray[stageIndex] = null
			TweenMax.killAll();
			scoreCounter = 0
		
		/*
		   for (var i:int = 0 ; i < numberArray.length; i++)
		   {
		   numberArray[i].figure.removeEventListener (MouseEvent.MOUSE_OVER, invertNumber)
		   numberArray[i].figure.removeEventListener (MouseEvent.MOUSE_OUT, NOinvertNumber)
		   numberArray[i].figure.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject)
		   numberArray[i].figure.removeEventListener (MouseEvent.MOUSE_UP, stopDragObject)
		   numberArray[i].figure.removeEventListener (MouseEvent.MOUSE_UP, hitTestFunc)
		   TweenLite.to(numberArray[i].figure, 1, {x:numberXarray[i], y:numberYarray[i]});
		 }*/
		
		}
		
		private function init(e:Event):void
		{
			soundControl = new SoundControl();
			addChild(soundControl)
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addNumbers();
		}
		
		private function addNumbers():void
		{
			
			addRandomStage();
			
			randomPlus = new RandomPlus(9);
			
			numberArray = [{figure: stageArray[stageIndex].mc_N1, isAllowed: true}, {figure: stageArray[stageIndex].mc_N2, isAllowed: true}, {figure: stageArray[stageIndex].mc_N3, isAllowed: true}, {figure: stageArray[stageIndex].mc_N4, isAllowed: true}, {figure: stageArray[stageIndex].mc_N5, isAllowed: true}, {figure: stageArray[stageIndex].mc_N6, isAllowed: true}, {figure: stageArray[stageIndex].mc_N7, isAllowed: true}, {figure: stageArray[stageIndex].mc_N8, isAllowed: true}, {figure: stageArray[stageIndex].mc_N9, isAllowed: true}, {figure: stageArray[stageIndex].mc_N10, isAllowed: true}]
			numberHitArray = [{figure: stageArray[stageIndex].mc_N1_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N2_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N3_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N4_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N5_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N6_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N7_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N8_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N9_hit, isAllowed: true}, {figure: stageArray[stageIndex].mc_N10_hit, isAllowed: true}]
			
			numberTextArray = ["23", "25", "27", "28", "35", "38", "40", "42", "43", "46"]
			
			numberXarray = [stageArray[stageIndex].mc_N1.x, stageArray[stageIndex].mc_N2.x, stageArray[stageIndex].mc_N3.x, stageArray[stageIndex].mc_N4.x, stageArray[stageIndex].mc_N5.x, stageArray[stageIndex].mc_N6.x, stageArray[stageIndex].mc_N7.x, stageArray[stageIndex].mc_N8.x, stageArray[stageIndex].mc_N9.x, stageArray[stageIndex].mc_N10.x]
			numberYarray = [stageArray[stageIndex].mc_N1.y, stageArray[stageIndex].mc_N2.y, stageArray[stageIndex].mc_N3.y, stageArray[stageIndex].mc_N4.y, stageArray[stageIndex].mc_N5.y, stageArray[stageIndex].mc_N6.y, stageArray[stageIndex].mc_N7.y, stageArray[stageIndex].mc_N8.y, stageArray[stageIndex].mc_N9.y, stageArray[stageIndex].mc_N10.y]
			
			addListeners();
		
		}
		
		private function addRandomStage():void
		{
			
			randomPlus = new RandomPlus(2);
			stageIndex = randomPlus.getNum();
			
			stage4Objects = new Stage4Objects() as MovieClip;
			stage4_2 = new Stage4_2() as MovieClip;
			stage4_3 = new Stage4_3() as MovieClip;
			
			stageArray = [stage4Objects, stage4_2, stage4_3];
			
			addChild(stageArray[stageIndex])
			
			stageArray[stageIndex].x = _stageWidth / 2;
			stageArray[stageIndex].y = _stageHeight / 2;
			stageArray[stageIndex].height = _stageHeight / 1.5;
			stageArray[stageIndex].scaleX = stageArray[stageIndex].scaleY;
			
			stageArray[stageIndex].mc_N5_hit.visible = false
			stageArray[stageIndex].mc_N6_hit.visible = false
			stageArray[stageIndex].mc_N7_hit.visible = false
			stageArray[stageIndex].mc_N8_hit.visible = false
			stageArray[stageIndex].mc_N9_hit.visible = false
			stageArray[stageIndex].mc_N10_hit.visible = false
		
		}
		
		private function addListeners():void
		{
			for (var i:int = 0; i < numberArray.length; i++)
			{
				randomIndex = randomPlus.getNum();
				
				numberArray[i].figure.txt.text = numberTextArray[randomIndex];
				numberArray[i].figure.BG.alpha = 0
				numberArray[i].figure.addEventListener(MouseEvent.MOUSE_OVER, invertNumber)
				numberArray[i].figure.addEventListener(MouseEvent.MOUSE_OUT, NOinvertNumber)
				numberArray[i].figure.addEventListener(MouseEvent.MOUSE_DOWN, dragObject)
				numberArray[i].figure.addEventListener(MouseEvent.MOUSE_UP, stopDragObject)
				numberArray[i].figure.addEventListener(MouseEvent.MOUSE_UP, hitTestFunc)
				numberArray[i].figure.addEventListener(MouseEvent.MOUSE_DOWN, checkFunc)
				numberHitArray[i].figure.txt.alpha = 0;
			}
		}
		
		private function checkFunc(e:MouseEvent):void
		{
			for (var i:int = 0; i < numberArray.length; i++)
			{
				if (e.currentTarget == numberArray[i].figure)
				{
					currentIndex = i
					break
				}
			}
		}
		
		private function hitTestFunc(e:Event):void
		{
			
			
			for (var i:int = 0; i < numberArray.length; i++)
			{
				if (e.currentTarget.hitTestObject(numberHitArray[i].figure) && (e.currentTarget.txt.text == numberHitArray[i].figure.txt.text))
				{
					TweenLite.to(e.currentTarget, 0.2, {x: numberHitArray[i].figure.x, y: numberHitArray[i].figure.y});
					//e.currentTarget.x =	numberHitArray[i].figure.x
					//e.currentTarget.y = numberHitArray[i].figure.y
					TweenMax.to(e.currentTarget, 1, {glowFilter: {color: 0x91e600, alpha: 1, blurX: 30, blurY: 30, strength: 3, remove: true}, ease: Expo.easeOut});
					numberArray.splice(currentIndex, 1)
					
					e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, invertNumber)
					e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, NOinvertNumber)
					e.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN, dragObject)
					e.currentTarget.removeEventListener(MouseEvent.MOUSE_UP, stopDragObject)
					e.currentTarget.removeEventListener(MouseEvent.MOUSE_UP, hitTestFunc)
					TrueFunc();
					scoreCounter++
					checkScore();
					
					return
				}
				
				else
				{
					
					TweenLite.to(numberArray[i].figure, 0.5, {x: numberXarray[i], y: numberYarray[i]});
					TweenMax.to(e.currentTarget, 0.5, {glowFilter: {color: 0xcc0000, alpha: 1, blurX: 30, blurY: 30, strength: 3, remove: true}, ease: Expo.easeOut});
					
					ErrorFunc();
					
				}
			}
		}
		
		private function checkScore():void
		{
			if (scoreCounter == 4)
			{
				FinalFunc();
			}
		}
		
		private function destroyCaller():void
		{
			
			destroy(null)
		}
		
		private function invertNumber(e:MouseEvent):void
		{
			TweenLite.to(e.currentTarget.BG, 0.2, {autoAlpha: 1});
			TweenMax.to(e.currentTarget.txt, 0.2, {colorTransform: {tint: 0x1F3304}});
		}
		
		private function NOinvertNumber(e:MouseEvent):void
		{
			TweenLite.to(e.currentTarget.BG, 0.2, {autoAlpha: 0});
			TweenMax.to(e.currentTarget.txt, 0.2, {colorTransform: {tint: 0xFEF8DD}});
		}
		
		private function dragObject(e:MouseEvent):void
		{
			e.currentTarget.startDrag();
			TweenLite.to(e.currentTarget.BG, 0.2, {autoAlpha: 1});
			TweenMax.to(e.currentTarget.txt, 0.2, {colorTransform: {tint: 0x1F3304}});
		}
		
		private function stopDragObject(e:MouseEvent):void
		{
			e.currentTarget.stopDrag();
		}
		
		private function ErrorFunc():void
		{
			
			soundControl.loadSound("error.mp3", 0.4);
			soundControl.soundPlay();
		}
		
		private function TrueFunc():void
		{
			
			soundControl.loadSound("correct.mp3", 0.5);
			soundControl.soundPlay();
		}
		
		private function FinalFunc():void
		{
			
			soundControl.loadSound("clap.mp3", 0.5);
			soundControl.soundPlay();
			setTimeout(destroyCaller, 1500)
		}
	
	}

}
