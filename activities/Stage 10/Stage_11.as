package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*; 
	import com.greensock.easing.*;
	import flash.utils.setTimeout;
	import flash.events.DataEvent;
	
	
	
	
	public class Stage_11 extends MovieClip 
	{
		private var stage_1:MovieClip;
		private var soundControl:SoundControl;
		private var soundControl_1:SoundControl;
		
		private var stage_0:MovieClip;
		private var stage_2:MovieClip;
		private var stage_3:MovieClip;
		private var squareX:Number
		private var squareY:Number
		private var randomPlus:RandomPlus;
		private var triangleX:Number
		private var triangleY:Number
		private var scoreCounter:int
		
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var eqvskuX:Number
		private var eqvskuY:Number
		
		private var stageArray:Array
		private var stageIndex:int
		
		public function Stage_11(_stageWidth:Number = 1024, _stageHeight:Number = 768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		private function destroy (event:Event):void
		{
			
			
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			TweenMax.killAll();
			scoreCounter = 0 
		 
			stageArray[stageIndex].Square.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject);
			stageArray[stageIndex].Square.removeEventListener (MouseEvent.MOUSE_UP, stopDragObject);
			stageArray[stageIndex].Square.removeEventListener (MouseEvent.MOUSE_UP, hitTestFunc1);
			
			stageArray[stageIndex].Triangles.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject);
			stageArray[stageIndex].Triangles.removeEventListener (MouseEvent.MOUSE_UP, stopDragObject);
			stageArray[stageIndex].Triangles.removeEventListener (MouseEvent.MOUSE_UP, hitTestFunc2);
			
			stageArray[stageIndex].Eqvskutxedi.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject);
			stageArray[stageIndex].Eqvskutxedi.removeEventListener (MouseEvent.MOUSE_UP, stopDragObject);
			stageArray[stageIndex].Eqvskutxedi.removeEventListener (MouseEvent.MOUSE_UP, hitTestFunc3);
			
			removeChild(stageArray[stageIndex]);
			
			stageArray[stageIndex] = null
			
			
		}
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			YvelaferiFunc();
		}
		private function YvelaferiFunc():void
		{
			
			addRandomStage();
			
			
			
			squareX = stageArray[stageIndex].Square.x
			squareY = stageArray[stageIndex].Square.y
			
			triangleX = stageArray[stageIndex].Triangles.x
			triangleY = stageArray[stageIndex].Triangles.y
			
			eqvskuX = stageArray[stageIndex].Eqvskutxedi.x
			eqvskuY = stageArray[stageIndex].Eqvskutxedi.y
			
			stageArray[stageIndex].Square.addEventListener (MouseEvent.MOUSE_DOWN, dragObject);
			stageArray[stageIndex].Square.addEventListener (MouseEvent.MOUSE_UP, stopDragObject);
			stageArray[stageIndex].Square.addEventListener (MouseEvent.MOUSE_UP, hitTestFunc1);
			
			stageArray[stageIndex].Triangles.addEventListener (MouseEvent.MOUSE_DOWN, dragObject);
			stageArray[stageIndex].Triangles.addEventListener (MouseEvent.MOUSE_UP, stopDragObject);
			stageArray[stageIndex].Triangles.addEventListener (MouseEvent.MOUSE_UP, hitTestFunc2);
			
			stageArray[stageIndex].Eqvskutxedi.addEventListener (MouseEvent.MOUSE_DOWN, dragObject);
			stageArray[stageIndex].Eqvskutxedi.addEventListener (MouseEvent.MOUSE_UP, stopDragObject);
			stageArray[stageIndex].Eqvskutxedi.addEventListener (MouseEvent.MOUSE_UP, hitTestFunc3);
			
			
		}
		
		private function hitTestFunc1 (e:MouseEvent):void
		{
			
			if (stageArray[stageIndex].Square.hitTestObject(stageArray[stageIndex].Stick_1))
			{
				TrueFunc(e); 
				
				stageArray[stageIndex].Square.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject);
				stageArray[stageIndex].Square.removeEventListener (MouseEvent.MOUSE_UP, hitTestFunc1);
				
				stageArray[stageIndex].Square.x = stageArray[stageIndex].Stick_1.x;
			    stageArray[stageIndex].Square.y = stageArray[stageIndex].Stick_1.y;
				stageArray[stageIndex].Stick_1.alpha = 0;
				TweenMax.to(stageArray[stageIndex].Square, 1, { glowFilter: { color:0x91e600, alpha:1, blurX:30, blurY:30, strength:3, remove:true }} );
				scoreCounter++
				
				if (scoreCounter == 2)
				{
					
					
					
					setTimeout(destroyCaller,1000);
					setTimeout(FinalFunc,1);
				}
				}
			else 
			{
				ErrorFunc(e);
				TweenLite.to(stageArray[stageIndex].Square, 0.2, {x:squareX, y:squareY});
                TweenMax.to(stageArray[stageIndex].Square, 1, { glowFilter: { color:0xcc0000, alpha:1, blurX:30, blurY:30, strength:2, remove:true }} );
			}
		}
		
		private function hitTestFunc2 (e:MouseEvent):void
		{
			if (stageArray[stageIndex].Triangles.hitTestObject(stageArray[stageIndex].Stick_2))
			{
				TrueFunc(e);
				
				stageArray[stageIndex].Triangles.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject);
				stageArray[stageIndex].Triangles.removeEventListener (MouseEvent.MOUSE_UP, hitTestFunc2);
				
				stageArray[stageIndex].Triangles.x = stageArray[stageIndex].Stick_2.x;
			    stageArray[stageIndex].Triangles.y = stageArray[stageIndex].Stick_2.y;
				stageArray[stageIndex].Stick_2.alpha = 0;
				TweenMax.to(stageArray[stageIndex].Triangles, 1, { glowFilter: { color:0x91e600, alpha:1, blurX:30, blurY:30, strength:3, remove:true }} );
				scoreCounter++
				trace (scoreCounter)
				if (scoreCounter == 2)
				{
					
					TrueFunc(e);
					
					setTimeout(destroyCaller, 1000);
					setTimeout(FinalFunc,1);
				}
			}
			else 
			{
				ErrorFunc(e);
				TweenLite.to(stageArray[stageIndex].Triangles, 0.2, {x:triangleX, y:triangleY});
                TweenMax.to(stageArray[stageIndex].Triangles, 1, { glowFilter: { color:0xcc0000, alpha:1, blurX:30, blurY:30, strength:2, remove:true }} );
			}
		}
		
		
		private function hitTestFunc3 (e:MouseEvent):void 
		{
			if (stageArray[stageIndex].Eqvskutxedi.hitTestObject(stageArray[stageIndex].Stick_3))
			{
				TrueFunc(e);
				stageArray[stageIndex].Eqvskutxedi.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject);
				stageArray[stageIndex].Eqvskutxedi.removeEventListener (MouseEvent.MOUSE_UP, hitTestFunc3);
				
				stageArray[stageIndex].Eqvskutxedi.x = stageArray[stageIndex].Stick_3.x;
			    stageArray[stageIndex].Eqvskutxedi.y = stageArray[stageIndex].Stick_3.y;
				stageArray[stageIndex].Stick_3.alpha = 0;
				TweenMax.to(stageArray[stageIndex].Eqvskutxedi, 1, { glowFilter: { color:0x91e600, alpha:1, blurX:30, blurY:30, strength:3, remove:true }} );
				scoreCounter++
				trace (scoreCounter)
				
				if (scoreCounter == 2)
				{
					
					TrueFunc(e);
					
					setTimeout(destroyCaller, 1000); 
					setTimeout(FinalFunc,1);
				}
				}
			else 
			{
				ErrorFunc(e);
				TweenLite.to(stageArray[stageIndex].Eqvskutxedi, 0.2, {x:eqvskuX, y:eqvskuY});
                TweenMax.to(stageArray[stageIndex].Eqvskutxedi, 1, { glowFilter: { color:0xcc0000, alpha:1, blurX:30, blurY:30, strength:2, remove:true }} );
			}
		}
		
		
		
		private function addRandomStage():void
		{

			
			randomPlus = new RandomPlus(2); 
			stageIndex = randomPlus.getNum();
			
			stage_0 = new Stage_0() as MovieClip;
			stage_3 = new Stage_3() as MovieClip;
			stage_2 = new Stage_2() as MovieClip;
			
			stageArray = [stage_0, stage_2, stage_3]
			
			
			addChild(stageArray[stageIndex]);
			
			stageArray[stageIndex].x = _stageWidth / 2;
			stageArray[stageIndex].y = _stageHeight / 2;
			stageArray[stageIndex].height = _stageHeight/1.5;
			stageArray[stageIndex].scaleX = stageArray[stageIndex].scaleY;
			
			
			if (stage_0)
			{
				stage_0.Stick_3.visible=false
			}
			if (stage_2)
			{
				stage_2.Stick_2.visible=false
			}
			if (stage_3)
			{
				stage_3.Stick_1.visible=false
			}
			
			
		}
		
		
			private function dragObject (e:MouseEvent):void
		{
			e.currentTarget.startDrag();
			
		}
		
		private function stopDragObject (e:MouseEvent):void
		{
			e.currentTarget.stopDrag(); 
			 
		}
		
		private function destroyCaller ():void  
		
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
			destroy(null)
			
		}
		
		private function ErrorFunc(e:MouseEvent)
		{
			soundControl = new SoundControl();
			soundControl.loadSound("error.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
		
		}
		
		private function TrueFunc(e:MouseEvent): void
		{	
			soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
			
		
		}
		
		private function FinalFunc():void
		{
			soundControl_1= new SoundControl();
			soundControl_1.loadSound("clap.mp3", 1);
			addChild(soundControl_1);
			soundControl_1.soundPlay();
			
			
			
		}
		
		}
	}
