package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import com.greensock.*;
	import com.greensock.easing.*; // au ravi bicho ar vici mirians miwere veraferi vqeni, ok no problem jigari xar, gagacvale ise prosta naxe erti ragac anu green socks xedavs da flashs vera ,,, mokled mivwer.. ;) :* sps  daica
	import flash.events.DataEvent;
	
	
	public class Stage6Class extends MovieClip
	{
		private var mc:MovieClip;
		private var all:MovieClip;
		private var soundControl:SoundControl;
		private var soundControl_1:SoundControl;
		

		private var myRandom:int;
		private var circles:MovieClip;
		private var triangles:MovieClip;
		private var xutkutxedi: MovieClip;
		private var stars: MovieClip;
		private var martkutxedi:MovieClip;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var scoreCounter:int
	
		
		
		
		private var currMc:MovieClip;
		
		public function Stage6Class(_stageWidth:Number = 1024, _stageHeight:Number = 768)
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
			
			if (martkutxedi)
			{
				removeChild(martkutxedi);
				martkutxedi = null
			}
			if (triangles)
			{
				removeChild(triangles);
				triangles=null
			}
			if (stars)
			{
				removeChild(stars);
				stars=null
			}
			if (circles)
			{
				removeChild(circles);
				circles=null
			}
					if (xutkutxedi)
			{
				removeChild(xutkutxedi);
				xutkutxedi=null
			}
			
		}
		
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addFigures();
		}
		
		private function addFigures():void
		{
			
			var myRandom = Math.floor(Math.random() * (1 + 5 - 1)) + 1;
			
			if (myRandom == 1)
			{
				circles = new Circles();
				addChild(circles);
				currMc=circles;
				
				circles.x = _stageWidth / 2;
				circles.y = _stageHeight / 2;
				randomFunc(circles);
			}
			if (myRandom == 2)
			{
				triangles = new Triangles();
				addChild(triangles);
				currMc=triangles;
				triangles.x = _stageWidth / 2;
				triangles.y = _stageHeight / 2;
				
				randomFunc(triangles);
			}
			
			if (myRandom == 3)
			{
				xutkutxedi = new Xutkutxedi();
				addChild(xutkutxedi);
				currMc=xutkutxedi;
				xutkutxedi.x = _stageWidth / 2;
				xutkutxedi.y = _stageHeight / 2;
				
				randomFunc(xutkutxedi);
			}
			
			if (myRandom == 4)
			{
				stars = new Star();
				addChild(stars);
				currMc=stars;
				stars.x = _stageWidth / 2;
				stars.y = _stageHeight / 2;
				
				randomFunc(stars);
			}
			if (myRandom == 5)
			{
				martkutxedi = new Martkutx();
				addChild(martkutxedi);
				currMc=martkutxedi;
				
				martkutxedi.x = _stageWidth / 2;
				martkutxedi.y = _stageHeight / 2;
				randomFunc(martkutxedi);
			}
			
		}
		
		private function randomFunc(mc):void
		{
			mc.box1.addEventListener(MouseEvent.MOUSE_DOWN, ErrorFunc);
			mc.box2.addEventListener(MouseEvent.MOUSE_DOWN, TrueFunc);
			mc.box3.addEventListener(MouseEvent.MOUSE_DOWN, ErrorFunc);
		}
		
		private function ErrorFunc(e:MouseEvent)
		{
			TweenMax.to(e.currentTarget, 1, {glowFilter:{color:0xcc0000, alpha:1, blurX:30, blurY:30, remove:true}});
			soundControl = new SoundControl();
			soundControl.loadSound("error.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
		
		}
		
		private function TrueFunc(e:MouseEvent): void
		{	
			TweenMax.to(e.currentTarget, 1, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30,  remove:true}});
			soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
			scoreCounter++
			
			setTimeout(destroyCaller, 1500);
			
		}
		
		private function destroyCaller ():void
		{
			if (scoreCounter == 3 )
			{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
			destroy(null);
			return
			}
			
			
			destroy(null);
			addFigures();
		}
		
		private function FinalFunc():void
		{
			currMc.box1.visible = false
			currMc.box3.visible = false
			soundControl_1= new SoundControl();
			soundControl_1.loadSound("clap.mp3", 1);
			addChild(soundControl_1);
			soundControl_1.soundPlay();
			currMc.box2.removeEventListener(MouseEvent.MOUSE_DOWN, TrueFunc);
		}
		
	}

}
