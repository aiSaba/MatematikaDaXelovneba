package 
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.utils.*;

	public class AddTangram extends MovieClip
	{
		
		private var tangram1:MovieClip;
		private var tangram2:MovieClip;
		private var tangram3:MovieClip;
		private var tangram4:MovieClip;
		private var PartsArray:Array;
		private var TargetsArray:Array;
		private var CenterArray:Array;
		private var randomPlus:RandomPlus;
		private var selectedArray:Array;
		private var soundControl:SoundControl;
		private var p:int = new int (0);
		private var hit:int = new int (0);
		private var currentTangram:MovieClip;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var randomIndex:int
		private var tangramArray:Array
		
		
		
		
		 private var tempString:String = new String("hitFalse");
		
		 private var HintArray:Array
		
		private var correctScore:int = new int(0)
		//private var rotationNumber:Number = new Number(0);
		
		public function AddTangram(_stageWidth:Number=1024, _stageHeight:Number=768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			
		}
		
		private function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			TweenMax.killAll();

			
			for (var i:int = 0; i < PartsArray.length; i++)
			{
				
				PartsArray[i].figure.removeEventListener(MouseEvent.CLICK, MoveAndScaleFunc);
				PartsArray[i].figure.center_mc.removeEventListener(MouseEvent.MOUSE_DOWN, dragObject);
				PartsArray[i].figure.center_mc.removeEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				PartsArray[i].figure.center_mc.removeEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
				PartsArray[i].figure.removeEventListener(MouseEvent.MOUSE_UP, stopDragObject);		
				PartsArray[i].figure.removeEventListener(MouseEvent.MOUSE_UP, hitTargetFunc);
				
				tangramArray[randomIndex].hint_button.removeEventListener (MouseEvent.CLICK, hintFunc)
				tangramArray[randomIndex].hint_button.removeEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				tangramArray[randomIndex].hint_button.removeEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);

				tangramArray[randomIndex].Button_Left.removeEventListener(MouseEvent.CLICK, rotateLeftFunc);
				tangramArray[randomIndex].Button_Left.removeEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				tangramArray[randomIndex].Button_Left.removeEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
				
				tangramArray[randomIndex].Button_Right.removeEventListener(MouseEvent.CLICK, rotateRightFunc);
				tangramArray[randomIndex].Button_Right.removeEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				tangramArray[randomIndex].Button_Right.removeEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
			}
			if (currentTangram)
			{
				removeChild(currentTangram);
				currentTangram = null;
			}
			
		}
		
		
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addParts();
		}

		private function addParts():void
		{
			
			randomPlus = new RandomPlus(3);
			randomIndex = randomPlus.getNum();
			
			addRandomFigure();
			
			
			PartsArray = [{figure:tangramArray[randomIndex].Paralelogram, isAllowed:true},  {figure:tangramArray[randomIndex].Square, isAllowed:true},  {figure:tangramArray[randomIndex].TringleMid, isAllowed:true},  {figure:tangramArray[randomIndex].TringleSmall_1, isAllowed:true},  {figure:tangramArray[randomIndex].TringleSmall_2, isAllowed:true},  {figure:tangramArray[randomIndex].TringleBig_1, isAllowed:true},  {figure:tangramArray[randomIndex].TringleBig_2, isAllowed:true}];
			TargetsArray = [tangramArray[randomIndex].Paralelogram_Target,  tangramArray[randomIndex].Square_Target,  tangramArray[randomIndex].TringleMid_Target,  tangramArray[randomIndex].TringleSmall_Target_1,  tangramArray[randomIndex].TringleSmall_Target_2,  tangramArray[randomIndex].TringleBig_Target_1,  tangramArray[randomIndex].TringleBig_Target_2 ];
			CenterArray =  [tangramArray[randomIndex].Paralelogram.center_mc,  tangramArray[randomIndex].Square.center_mc,  tangramArray[randomIndex].TringleMid.center_mc,  tangramArray[randomIndex].TringleSmall_1.center_mc,  tangramArray[randomIndex].TringleSmall_2.center_mc,  tangramArray[randomIndex].TringleBig_1.center_mc,  tangramArray[randomIndex].TringleBig_2.center_mc];
			selectedArray = [];
			
			HintArray = [{figure:tangramArray[randomIndex].Paralelogram_Target},  {figure:tangramArray[randomIndex].Square_Target},  {figure:tangramArray[randomIndex].TringleMid_Target},  {figure:tangramArray[randomIndex].TringleSmall_Target_1},  {figure:tangramArray[randomIndex].TringleSmall_Target_2},  {figure:tangramArray[randomIndex].TringleBig_Target_1},  {figure:tangramArray[randomIndex].TringleBig_Target_2} ];
			
			
			
			for (var i:int=0; i < PartsArray.length; i++)
			{
				PartsArray[i].figure.addEventListener(MouseEvent.CLICK, MoveAndScaleFunc);
				PartsArray[i].figure.center_mc.addEventListener(MouseEvent.MOUSE_DOWN, dragObject);
				PartsArray[i].figure.center_mc.addEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				PartsArray[i].figure.center_mc.addEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
				PartsArray[i].figure.center_mc.buttonMode = true
				PartsArray[i].figure.addEventListener(MouseEvent.MOUSE_UP, stopDragObject);		
				CenterArray[i].visible = false;
				PartsArray[i].figure.addEventListener(MouseEvent.MOUSE_UP, hitTargetFunc);
				tangramArray[randomIndex].hint_button.addEventListener (MouseEvent.CLICK, hintFunc)
				tangramArray[randomIndex].hint_button.addEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				tangramArray[randomIndex].hint_button.addEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
				HintArray[i].figure.visible = false
				HintArray[i].figure.targetCenter_mc2.alpha = 0;
				tangramArray[randomIndex].Paralelogram_Target.targetCenter_mc3.alpha = 0;
				tangramArray[randomIndex].Square_Target.targetCenter_mc3.alpha = 0;
				tangramArray[randomIndex].Square_Target.targetCenter_mc4.alpha = 0;
				tangramArray[randomIndex].Square_Target.targetCenter_mc5.alpha = 0;
				tangramArray[randomIndex].coordinate.visible = false
				HintArray[i].figure.targetCenter_mc.alpha = 0;
				PartsArray[i].figure.center_mc2.alpha = 0;
				

			}
		}
		
		private function addRandomFigure():void
		
		{
			currentTangram = new MovieClip;

			tangram1 = new Tangram1() as MovieClip;
			tangram2 = new Tangram2() as MovieClip;
			tangram3 = new Tangram3() as MovieClip;
			tangram4 = new Tangram4() as MovieClip;
			
			tangramArray = [tangram1, tangram2, tangram3, tangram4]
			currentTangram = tangramArray[randomIndex];
			addChild (currentTangram);
			
			tangramArray[randomIndex].x = _stageWidth / 2;
			tangramArray[randomIndex].y = _stageHeight / 2;
			tangramArray[randomIndex].height = _stageHeight/1.5;
			tangramArray[randomIndex].scaleX = tangramArray[randomIndex].scaleY;
			
			

		}
		
		
		private function  hitTargetFunc (e:Event):void
		{
			for (var hit:int = 0; hit < PartsArray.length; hit++)
			{
				try
				{
					
					if ((PartsArray[hit].figure.center_mc.hitTestObject(TargetsArray[hit].targetCenter_mc)) && (PartsArray[hit].figure.center_mc2.hitTestObject(TargetsArray[hit].targetCenter_mc2))||((PartsArray[hit].figure.center_mc.hitTestObject(TargetsArray[hit].targetCenter_mc)) && (PartsArray[hit].figure.center_mc2.hitTestObject(TargetsArray[hit].targetCenter_mc3))||((PartsArray[hit].figure.center_mc.hitTestObject(TargetsArray[hit].targetCenter_mc)) && (PartsArray[hit].figure.center_mc2.hitTestObject(TargetsArray[hit].targetCenter_mc4))||((PartsArray[hit].figure.center_mc.hitTestObject(TargetsArray[hit].targetCenter_mc)) && (PartsArray[hit].figure.center_mc2.hitTestObject(TargetsArray[hit].targetCenter_mc5))))))
					{	
						
						if (PartsArray[hit].isAllowed)
						{
							countFunc();
						}
						PartsArray[hit].figure.center_mc.removeEventListener (MouseEvent.MOUSE_DOWN, dragObject);
						PartsArray[hit].figure.x = TargetsArray[hit].x;
						PartsArray[hit].figure.y = TargetsArray[hit].y;
						TweenMax.to(PartsArray[hit].figure, 1, { glowFilter: { color:0x85C5BC, alpha:0, blurX:50, blurY:50 }} );
						TweenMax.to(PartsArray[hit].figure, 1, { glowFilter: { color:0x91e600, alpha:0, blurX:50, blurY:50, remove:true }} );
						
						PartsArray[hit].isAllowed = false;
						CenterArray[hit].visible = false
					}
				}
				catch (e:Error)
				{
					
				}
			}
		}
		
		private function countFunc ():void
		{
			correctScore++
			CorrecteFunc()
			
		if (correctScore == 7)
			{
				selectedArray.pop();
				
				ClapFunc();
				setTimeout(destroyCaller, 2000)
			}
			
			return
		}
		
		private function  destroyCaller ():void
		{
			if (correctScore == 7)
			{
				dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
				destroy(null);
				return
			}
			
				//dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
				destroy(null);
				
		}
		

		
		
		private function MoveAndScaleFunc (e:MouseEvent):void
		{
			e.currentTarget.center_mc.visible = true;
			e.currentTarget.removeEventListener (MouseEvent.CLICK, MoveAndScaleFunc)
			TweenLite.to(e.currentTarget, 1, { x:tangramArray[randomIndex].coordinate.x, y:tangramArray[randomIndex].coordinate.y, scaleX:1.9, scaleY:1.9 } );
			
			
				if (selectedArray.length != 0)
			{
				var k:int = 0;
				TweenMax.to(selectedArray[k].figure, 1, { glowFilter: { color:0x85C5BC, alpha:0, blurX:50, blurY:50 }} );
				selectedArray.pop();

			}
			
			if (selectedArray.length == 0)
			{
			//selectedArray.push (e.currentTarget)
			
			for (var i:int = 0; i < PartsArray.length; i++ )
			{
				
				if (e.currentTarget == PartsArray[i].figure)
				{
					selectedArray.push (PartsArray[i])
					break;
				}
			}
			TweenMax.to(e.currentTarget, 1, { glowFilter: { color:0x33cccc, alpha:1, blurX:15, blurY:15, strength:3 }} );
			
			tangramArray[randomIndex].Button_Left.addEventListener(MouseEvent.CLICK, rotateLeftFunc);
			tangramArray[randomIndex].Button_Left.addEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
			tangramArray[randomIndex].Button_Left.addEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
			
				tangramArray[randomIndex].Button_Right.addEventListener(MouseEvent.CLICK, rotateRightFunc);
				tangramArray[randomIndex].Button_Right.addEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				tangramArray[randomIndex].Button_Right.addEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
			}
			
		}

		private function rotateLeftFunc (e:MouseEvent):void
		{
			if (selectedArray[0].isAllowed)
			{
				selectedArray[0].figure.rotation -= 45;
			}
		}
				private function rotateRightFunc (e:MouseEvent):void
		{
			if (selectedArray[0].isAllowed)
			{
				selectedArray[0].figure.rotation += 45;
			}
		}
		
		private function dragObject(e:MouseEvent):void
		{
			if (selectedArray.length > 0)
			{	
				TweenMax.to(selectedArray[p].figure, 1, { glowFilter: { color:0x85C5BC, alpha:0, blurX:50, blurY:50 }} );
				selectedArray.pop();

			}
			
			
			if (selectedArray.length == 0)
			{
				e.currentTarget.parent.startDrag();
			/////	selectedArray.push (e.currentTarget.parent)
				
				for (var i:int = 0; i < PartsArray.length; i++ )
				{
					
					if (e.currentTarget.parent== PartsArray[i].figure)
					{
						selectedArray.push (PartsArray[i])
						break;
					}
				}
				
				TweenMax.to(e.currentTarget.parent, 1, { glowFilter: { color:0x33cccc, alpha:1, blurX:15, blurY:15, strength:3 }} );
				
				tangramArray[randomIndex].Button_Left.addEventListener(MouseEvent.CLICK, rotateLeftFunc);
				tangramArray[randomIndex].Button_Left.addEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				tangramArray[randomIndex].Button_Left.addEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
				
				tangramArray[randomIndex].Button_Right.addEventListener(MouseEvent.CLICK, rotateRightFunc);
				tangramArray[randomIndex].Button_Right.addEventListener(MouseEvent.MOUSE_OVER, alphaFunc);
				tangramArray[randomIndex].Button_Right.addEventListener(MouseEvent.MOUSE_OUT, alphaFunc1);
			}

		}
		

		private function hintFunc (e:MouseEvent):void
		{
			
			for (var i:int = 0; i < HintArray.length; i++ )
			{
				
				if (HintArray[i].figure.visible == true)
				{
					HintArray[i].figure.visible = false
				}
				else if (HintArray[i].figure.visible == false)
				{
				HintArray[i].figure.visible = true
				}
			}
		}
		

		private function stopDragObject(e:MouseEvent):void
		{
			e.currentTarget.parent.stopDrag();
		}
		
		///////////Hit Target/////
	
		
		private function alphaFunc(e:MouseEvent):void
		{
			e.currentTarget.alpha = 0.5;
			e.currentTarget.buttonMode = true
		}
		private function alphaFunc1(e:MouseEvent):void
		{
			e.currentTarget.alpha = 1;
			e.currentTarget.buttonMode = true
		}
		private function CorrecteFunc()
		{
			soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 1);
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