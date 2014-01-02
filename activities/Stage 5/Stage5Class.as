package  {
	
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*; 
	import com.greensock.easing.*;
	import flash.ui.Mouse;
	import flash.utils.*;
	import flash.events.DataEvent;
	
	
	
	public class Stage5Class extends MovieClip 
	{
		private var stage5Objects:MovieClip;
		private var nishnebiArray:Array;
		private var answer_left:Number
		private var soundControl:SoundControl;
		
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		
		private var randomPlus:RandomPlus;
		private var randomIndex1:int;
		private var randomIndex2:int;
		private var randomNumLeft1:int
		private var randomNumLeft2:int
		private var randomNumRight1:int
		private var randomNumRight2:int
		
		private var mouse:MouseEvent
		
		private var plusMinusArray_left:Array;
		private var plusMinusArray_right:Array;
		
		private var tolobaX:Number;
		private var tolobaY:Number;
		private var metobaX:Number;
		private var metobaY:Number;
		private var naklebobaX:Number;
		private var naklebobaY:Number;
		private var scoreCounter:int
		private var leftBox:Number
		private var rightBox:Number
		
		public function Stage5Class(_stageWidth:Number=1024, _stageHeight:Number=768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		private function init (e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addNumbers()
		}
		
		private function destroy(event:Event):void
		{

			
			
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			TweenMax.killAll();
			randomNumbersFunc();
			
			stage5Objects.nishnebi_mc.toloba_mc.x = tolobaX;
			stage5Objects.nishnebi_mc.toloba_mc.y = tolobaY;
			
			stage5Objects.nishnebi_mc.nakleboba_mc.x = naklebobaX;
			stage5Objects.nishnebi_mc.nakleboba_mc.y = naklebobaY;
			
			stage5Objects.nishnebi_mc.metoba_mc.x = metobaX;
			stage5Objects.nishnebi_mc.metoba_mc.y = metobaY;
			
			for (var i:int = 0; i < nishnebiArray.length; i++)
			{
				
				nishnebiArray[i].figure.removeEventListener (MouseEvent.MOUSE_OVER, invertNumber)
				nishnebiArray[i].figure.removeEventListener (MouseEvent.MOUSE_OUT, NOinvertNumber)
				nishnebiArray[i].figure.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject)
				nishnebiArray[i].figure.removeEventListener (MouseEvent.MOUSE_UP, stopDragObject)	
			}
						if (stage5Objects)
			{
				removeChild(stage5Objects);
				stage5Objects = null;
			}
			
		}
		
		private function addNumbers():void
		{
			addStage();
			
			nishnebiArray= [{figure:stage5Objects.nishnebi_mc.toloba_mc, isAllowed:true}, {figure:stage5Objects.nishnebi_mc.nakleboba_mc, isAllowed:true}, {figure:stage5Objects.nishnebi_mc.metoba_mc, isAllowed:true}]
			plusMinusArray_left = [ { text:"+" }, { text:"-" } ]
			plusMinusArray_right = [ { text:"+" }, { text:"-" } ]
			
			tolobaX = stage5Objects.nishnebi_mc.toloba_mc.x;
			tolobaY = stage5Objects.nishnebi_mc.toloba_mc.y;
			
			naklebobaX = stage5Objects.nishnebi_mc.nakleboba_mc.x;
			naklebobaY = stage5Objects.nishnebi_mc.nakleboba_mc.y;
			
			metobaX = stage5Objects.nishnebi_mc.metoba_mc.x;
			metobaY = stage5Objects.nishnebi_mc.metoba_mc.y;
			
			randomNumbersFunc();
			
			for (var i:int = 0; i < nishnebiArray.length; i++)
			{
				nishnebiArray[i].figure.BG.alpha=0
				nishnebiArray[i].figure.addEventListener (MouseEvent.MOUSE_OVER, invertNumber)
				nishnebiArray[i].figure.addEventListener (MouseEvent.MOUSE_OUT, NOinvertNumber)
				nishnebiArray[i].figure.addEventListener (MouseEvent.MOUSE_DOWN, dragObject)
				nishnebiArray[i].figure.addEventListener (MouseEvent.MOUSE_UP, stopDragObject)	
			}
			
			checkFunc();
			
		}
		
		private function checkFunc ():void
		{
				if (leftBox > rightBox)
				{
					trace("metia")
					nishnebiArray[2].figure.addEventListener (MouseEvent.MOUSE_UP, hitTestFunc)
					
					nishnebiArray[1].figure.addEventListener (MouseEvent.MOUSE_UP, falseFunc)
					nishnebiArray[0].figure.addEventListener (MouseEvent.MOUSE_UP, falseFunc)
				}
				if (leftBox < rightBox)
				{
					trace("naklebia")
					nishnebiArray[1].figure.addEventListener (MouseEvent.MOUSE_UP, hitTestFunc)
					
					nishnebiArray[0].figure.addEventListener (MouseEvent.MOUSE_UP, falseFunc)
					nishnebiArray[2].figure.addEventListener (MouseEvent.MOUSE_UP, falseFunc)
				}
				if (leftBox == rightBox)
				{
					trace("tolia")
					nishnebiArray[0].figure.addEventListener (MouseEvent.MOUSE_UP, hitTestFunc)
					
					nishnebiArray[1].figure.addEventListener (MouseEvent.MOUSE_UP, falseFunc)
					nishnebiArray[2].figure.addEventListener (MouseEvent.MOUSE_UP, falseFunc)
				}
		}
		
		private function falseFunc (e:MouseEvent):void
		{
			if (e.currentTarget.hitTestObject(stage5Objects.target))
			{
			TweenMax.to(stage5Objects.target, 0.5, { glowFilter: { color:0xcc0000, alpha:1, blurX:15, blurY:15, strength:3, remove:true}} );
			trace("Shecdomaa")
			e.currentTarget.removeEventListener (MouseEvent.MOUSE_UP, falseFunc)
			e.currentTarget.addEventListener (MouseEvent.MOUSE_UP, falseFunc)
			if (e.currentTarget == nishnebiArray[0].figure)
				{
					
					TweenLite.to(e.currentTarget, 1, {x:tolobaX, y:tolobaY});
				FalseFunc()
					
				}
				
			if (e.currentTarget == nishnebiArray[1].figure)
				{
					
					TweenLite.to(e.currentTarget, 1, {x:naklebobaX, y:naklebobaY});
					FalseFunc()	
					}
			if (e.currentTarget == nishnebiArray[2].figure)
				{
					
					TweenLite.to(e.currentTarget, 1, {x:metobaX, y:metobaY});
				FalseFunc()
				}	
			}
			
			else {
					if (e.currentTarget == nishnebiArray[0].figure)
				{
					
					TweenLite.to(e.currentTarget, 1, {x:tolobaX, y:tolobaY});
					FalseFunc()
				}
				
			if (e.currentTarget == nishnebiArray[1].figure)
				{
					
					TweenLite.to(e.currentTarget, 1, {x:naklebobaX, y:naklebobaY});
			FalseFunc()
				}
			if (e.currentTarget == nishnebiArray[2].figure)
				{
					
					TweenLite.to(e.currentTarget, 1, {x:metobaX, y:metobaY});
			FalseFunc()
				}
			}
		}
		
		private function hitTestFunc (e:MouseEvent):void
		{
			if (e.currentTarget.hitTestObject(stage5Objects.target))
			{
				e.currentTarget.removeEventListener (MouseEvent.MOUSE_OVER, invertNumber)
				e.currentTarget.removeEventListener (MouseEvent.MOUSE_OUT, NOinvertNumber)
				e.currentTarget.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject)
				e.currentTarget.removeEventListener (MouseEvent.MOUSE_UP, stopDragObject)
				
			TweenMax.to(stage5Objects.target, 0.2, { glowFilter: { color:0x91e600, alpha:1, blurX:15, blurY:15, strength:3 }} );
			CorrecteFunc();
			e.currentTarget.x = 1.6*stage5Objects.target.x
			e.currentTarget.y = 3.85 * stage5Objects.target.y
			
			trace("good")
			TweenLite.to(e.currentTarget.BG, 0.2, {autoAlpha:0});
			TweenMax.to(e.currentTarget.txt, 0.2, { colorTransform: { tint:0x1F3304 }} );
			e.currentTarget.mouseChildren = false;
			if (scoreCounter == 3)
			{
				ClapFunc();
			}
			setTimeout(destroyCaller, 2000)
			}
			else
			{
							if (e.currentTarget == nishnebiArray[0].figure)
				{
					
					FalseFunc();
					TweenLite.to(e.currentTarget, 1, {x:tolobaX, y:tolobaY});	
				}
				
			if (e.currentTarget == nishnebiArray[1].figure)
				{
					FalseFunc();
					
					TweenLite.to(e.currentTarget, 1, {x:naklebobaX, y:naklebobaY});
				}
			if (e.currentTarget == nishnebiArray[2].figure)
				{
					FalseFunc()
					
					TweenLite.to(e.currentTarget, 1, {x:metobaX, y:metobaY});
				}
			}
			
			
		}
		
		private function destroyCaller():void
		{
			

			
			if (scoreCounter == 3)
			{
				dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
				destroy(null);
				return
			}
			destroy(null)
			addNumbers();
		}
		
		private function randomNumbersFunc():void
		{
			
			randomPlus = new RandomPlus(1);
			randomIndex1 = randomPlus.getNum();
			stage5Objects.txt_left.N_2.text = plusMinusArray_left[randomIndex1].text;
			
			///LeftBoxAlgorithm
			randomPlus = new RandomPlus(50, 25);
			randomNumLeft1 = randomPlus.getNum();
			randomPlus = new RandomPlus(25, 5);
			randomNumLeft2 = randomPlus.getNum();
			
			stage5Objects.txt_left.N_1.text = randomNumLeft1;
			stage5Objects.txt_left.N_3.text = randomNumLeft2;
			
			
			
			if (plusMinusArray_left[randomIndex1].text == "+")
			{
				leftBox = randomNumLeft1 + randomNumLeft2
				trace (leftBox + " " + "mmarcxena")
			}
			
			if (plusMinusArray_left[randomIndex1].text == "-")
			{
				leftBox = randomNumLeft1 - randomNumLeft2
				trace (leftBox + " " + "mmarcxena")

			}
			
			///RightBoxAlgorithm
			
			randomPlus = new RandomPlus(1);
			randomIndex2 = randomPlus.getNum();
			stage5Objects.txt_right.N_2.text = plusMinusArray_right[randomIndex2].text;
			
			
			randomPlus = new RandomPlus(50, 25);
			randomNumRight1 = randomPlus.getNum();
			randomPlus = new RandomPlus(25, 5);
			randomNumRight2 = randomPlus.getNum();
			
			stage5Objects.txt_right.N_1.text = randomNumRight1;
			stage5Objects.txt_right.N_3.text = randomNumRight2;
			
			if (plusMinusArray_right[randomIndex2].text == "+")
			{
				rightBox = randomNumRight1 + randomNumRight2
				trace (randomNumRight1 +" "+ randomNumRight2)
				trace(rightBox + " " + "marjvena")
			}
			
			if (plusMinusArray_right[randomIndex2].text == "-")
			{
				rightBox = randomNumRight1 - randomNumRight2
				trace(rightBox + " " + "marjvena")
			}
			
		}
		
		
		
		private function addStage():void
		{

			stage5Objects = new Stage5Objects();
			addChild(stage5Objects);
			
			stage5Objects.x = _stageWidth / 2;
			stage5Objects.y = _stageHeight / 2;
			stage5Objects.height = _stageHeight/1.5;
			stage5Objects.scaleX = stage5Objects.scaleY;
			
		}
		
		private function invertNumber (e:MouseEvent):void
		{
			TweenLite.to(e.currentTarget.BG, 0.2, {autoAlpha:1});
			TweenMax.to(e.currentTarget.txt, 0.2, {colorTransform:{tint:0x1F3304}});
		}
		private function NOinvertNumber (e:MouseEvent):void
		{
			TweenLite.to(e.currentTarget.BG, 0.2, {autoAlpha:0});
			TweenMax.to(e.currentTarget.txt, 0.2, {colorTransform:{tint:0xFEF8DD}});
		}
		private function dragObject (e:MouseEvent):void
		{
			e.currentTarget.startDrag();
			TweenLite.to(e.currentTarget.BG, 0.2, {autoAlpha:1});
			TweenMax.to(e.currentTarget.txt, 0.2, {colorTransform:{tint:0x1F3304}});
		}
		
		private function stopDragObject (e:MouseEvent):void
		{
			e.currentTarget.stopDrag();
		}
		
		private function CorrecteFunc()
		{
			soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 0.5);
			addChild(soundControl);
			soundControl.soundPlay();
			scoreCounter++
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
	}
	
}
