package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
			import flash.events.MouseEvent;
		import com.greensock.*; 
		import com.greensock.easing.*;
				import flash.utils.*;
		import flash.events.DataEvent;
	
	
	public class SasworiClass extends MovieClip
	{
		

		private var staticNum:MovieClip;
		private var backGround:MovieClip;
		private var numberArray:Array;
		private var randomPlus:RandomPlus;
		private var randomPlus1:RandomPlus;
		private var randomIndex:int
		private var randomIndex1:int
		private var numberTextArray:Array;
		private var numberHitArray:Array
		private var giriArray:Array
		private var qula_1:int
		private var qula_2:int
		private var k:Number 
		private var numberXarray:Array;
		private var numberYarray:Array;
		private var currentIndex:int
		private var soundControl:SoundControl;
		
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		
		
		
		
		public function SasworiClass(_stageWidth:Number = 1024, _stageHeight:Number = 768)
		{
				this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addFigures();
		}
		
		
		
		private function addFigures():void
		{
			
			addRandomStage();
			
			numberArray = [{figure:backGround.N1_mc, isAllowed:true} , {figure:backGround.N2_mc, isAllowed:true}, {figure:backGround.N3_mc, isAllowed:true}, {figure:backGround.N4_mc, isAllowed:true}, {figure:backGround.N5_mc, isAllowed:true}, {figure:backGround.N6_mc, isAllowed:true}]
			
			numberXarray = [backGround.N1_mc.x, backGround.N2_mc.x, backGround.N3_mc.x, backGround.N4_mc.x, backGround.N5_mc.x, backGround.N6_mc.x];
			numberYarray = [backGround.N1_mc.y, backGround.N2_mc.y, backGround.N3_mc.y, backGround.N4_mc.y, backGround.N5_mc.y, backGround.N6_mc.y];
			
			numberTextArray = ["21", "20", "31" , "5" , "45", "10"]
			
			
			randomPlus1 = new RandomPlus(12);
			randomIndex1 = randomPlus1.getNum();
			
			
			randomPlus = new RandomPlus(5);
			
			numberHitArray = [ { figure:backGround.axis.plate1.plateN1_mc }, { figure:backGround.axis.plate1.plateN2_mc } ]; 
			
			giriArray = ["41", "52","26","66", "55", "31", "51", "36", "50", "15", "30", "31", "25"]
			backGround.axis.plate2.giri.txt.text = giriArray[randomIndex1]
			
			addListeners ();
			
			
			
		}
		
		private function addListeners ():void
		{
			
			for (var i:int = 0 ; i < numberArray.length; i++)
			{
				randomIndex = randomPlus.getNum();
				numberArray[i].figure.txt.text = numberTextArray[randomIndex]
				numberArray[i].figure.BG.alpha=0
				numberArray[i].figure.addEventListener (MouseEvent.MOUSE_OVER, invertNumber)
				numberArray[i].figure.addEventListener (MouseEvent.MOUSE_OUT, NOinvertNumber)
				numberArray[i].figure.addEventListener (MouseEvent.MOUSE_DOWN, dragObject)
				numberArray[i].figure.addEventListener (MouseEvent.MOUSE_UP, stopDragObject)
				
				numberArray[i].figure.addEventListener (MouseEvent.MOUSE_UP, hitTestFunc)
				
			}
		}
		try 
		{
			private function hitTestFunc (e:Event):void
			{
				for (var p:int = 0 ; p < numberArray.length; p++)
				{
					trace (p)
					if (e.currentTarget == numberArray[p].figure)
					{
						currentIndex=p
						trace (currentIndex)
					}
				}
				
				
				for (var i:int = 0 ; i < numberArray.length; i++)
				{
				if (e.currentTarget.hitTestObject(numberHitArray[i].figure))
					{	TrueFunc();
						numberHitArray[i].figure.txt.text = e.currentTarget.txt.text	
						TweenLite.to(e.currentTarget, 0.5, { x:numberXarray[currentIndex], y:numberYarray[currentIndex]} );
						trace (numberArray[currentIndex].figure.x)
						//e.currentTarget.visible=false
						qula_1 = numberHitArray[0].figure.txt.text 
						qula_2 = numberHitArray[1].figure.txt.text
						
						k = (qula_1+qula_2)/giriArray[randomIndex1]
						
						if (k > 2.3)
						{
							k=2.3
						}
						if (k == 1)
						{
							endFunc();
						}
						
						rotateAxis();
						break
					}
					else
					{
						TweenLite.to(e.currentTarget, 0.5, { x:numberXarray[currentIndex], y:numberYarray[currentIndex]} );
						trace ("NO")
					}
				}
			
			}
		}
		catch (error:Error) {
			
		}
		private function endFunc():void
		{
			FinalFunc();
			TweenMax.to(numberHitArray[0].figure, 1, { glowFilter: { color:0x91e600, alpha:1, blurX:30, blurY:30, strength:3,  remove:true }, ease:Expo.easeOut } );
			TweenMax.to(numberHitArray[1].figure, 1, { glowFilter: { color:0x91e600, alpha:1, blurX:30, blurY:30, strength:3,  remove:true }, ease:Expo.easeOut } );
			
		}
		
		private function addRandomStage():void
		{
			backGround = new BackGround();
			addChild(backGround);
			
			
			backGround.x = _stageWidth / 2;
			backGround.y = _stageHeight / 2;
			backGround.height = _stageHeight/1.5;
			backGround.scaleX = backGround.scaleY;
			

		}
		
		private function destroyCaller ():void
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
			destroy()
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
		
		private function rotateAxis ():void
		{	
			TweenLite.to(backGround.axis, 1, { rotation: -15*k } );
			TweenLite.to(backGround.axis.plate1, 1, { rotation:15*k } );
			TweenLite.to(backGround.axis.plate2, 1, {rotation:15*k});
		}
		private function stopDragObject (e:MouseEvent):void
		{
			e.currentTarget.stopDrag();
		}
		
				private function FinalFunc():void
		{
			soundControl= new SoundControl();
			soundControl.loadSound("clap.mp3", 0.5);
			addChild(soundControl);
			soundControl.soundPlay();
			setTimeout(destroyCaller, 1500)

		}
		
			private function TrueFunc(): void
		{	
			soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 0.5);
			addChild(soundControl);
			soundControl.soundPlay();		
		}
		
		
		private function destroy ():void
		{
			removeChild(backGround);
			backGround = null
		}
		
		
	}
}