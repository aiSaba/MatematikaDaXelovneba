package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundCodec;
	import flash.utils.setTimeout;
	import flash.events.DataEvent;
	
	public class MoveClass extends MovieClip
	{
		
		private var gza1:MovieClip;
		private var gza2:MovieClip;
		private var gza3:MovieClip;
		private var gza4:MovieClip;
		private var kvati:MovieClip;
		private var soundControl:SoundControl;
		private var wrongArray:Array;
		private var correctArray:Array;
		private var Kadri:int;
		private var counterCorrect:Number = 0;
		private var gzaArray:Array
		private var randomPlus:RandomPlus;
		private var randomIndex:int
		private var CVLADI:int = new int(0);
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		
		
		public function MoveClass(_stageWidth:Number = 1024, _stageHeight:Number = 768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(ev:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addMoves();
		}
		
		private function destroy(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			counterCorrect =0
			//correctArray[counterCorrect].removeEventListener(MouseEvent.MOUSE_DOWN, PathWay1);
			removeChild(gzaArray[randomIndex])
			
		}
		
		private function addMoves():void
		{
			
			addRandomWay();
			trace ("addmoves")

			/// False_6 da False_7 gamomrcha simboloebi dawere umagisod!!///
			FalsePath(gzaArray[randomIndex].False_1, gzaArray[randomIndex].False_2, gzaArray[randomIndex].False_3, gzaArray[randomIndex].False_4, gzaArray[randomIndex].False_5, gzaArray[randomIndex].False_6, gzaArray[randomIndex].False_7, gzaArray[randomIndex].False_8, gzaArray[randomIndex].False_9, gzaArray[randomIndex].False_10, gzaArray[randomIndex].False_11, gzaArray[randomIndex].False_12, gzaArray[randomIndex].False_13, gzaArray[randomIndex].False_14, gzaArray[randomIndex].False_15, gzaArray[randomIndex].False_16, gzaArray[randomIndex].False_17);
			correctArray = [gzaArray[randomIndex].True_1, gzaArray[randomIndex].True_2, gzaArray[randomIndex].True_3, gzaArray[randomIndex].True_4, gzaArray[randomIndex].True_5, gzaArray[randomIndex].True_6, gzaArray[randomIndex].True_7, gzaArray[randomIndex].True_8, gzaArray[randomIndex].True_9, gzaArray[randomIndex].True_10, gzaArray[randomIndex].True_11, gzaArray[randomIndex].True_12, gzaArray[randomIndex].True_13, gzaArray[randomIndex].True_14, gzaArray[randomIndex].True_15, gzaArray[randomIndex].True_16, gzaArray[randomIndex].True_17];
			gzaArray[randomIndex].BestWay.visible=false
			
			
			correctArray[counterCorrect].addEventListener(MouseEvent.MOUSE_DOWN, PathWay1);

		
		}
		private function addRandomWay():void
		{
			
			randomPlus = new RandomPlus(3);
			randomIndex = randomPlus.getNum();
			gza1 = new Gza1() as MovieClip;
			gza2 = new Gza2() as MovieClip;	
			gza3 = new Gza3() as MovieClip;
			gza4 = new Gza4() as MovieClip;	
			gzaArray = [gza1, gza2, gza3, gza4]
			addChild(gzaArray[randomIndex])
			
			gzaArray[randomIndex].x = _stageWidth / 2;
			gzaArray[randomIndex].y = _stageHeight / 2;
			gzaArray[randomIndex].height = _stageHeight/1.5;
			gzaArray[randomIndex].scaleX = gzaArray[randomIndex].scaleY;

		}
		
		private function PathWay1(ev:MouseEvent):void
		{
			counterCorrect ++;
			trace(counterCorrect)

			
			ev.currentTarget.visible = false
			CorrectFunc(ev);
			gzaArray[randomIndex].kvati.x = ev.currentTarget.x	
			gzaArray[randomIndex].kvati.y = ev.currentTarget.y
			
			if (counterCorrect == 17)
			{
				trace("GILOCAV!!")
				gzaArray[randomIndex].BestWay.visible=true
				TrueFunc(ev);	
				return
			}
			

			correctArray[counterCorrect].addEventListener(MouseEvent.MOUSE_DOWN, PathWay1);
			correctArray[counterCorrect - 1].removeEventListener(MouseEvent.MOUSE_DOWN, PathWay1);
		}
		
		private function destroyCaller():void
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
			destroy(null)
			
		}
		
		private function FalsePath(... objects):void
		{
			for (var i:int = 0; i < objects.length; i++)
			{
				objects[i].addEventListener(MouseEvent.CLICK, ErrorFunc);
			}
		}
		
		
		//////////SOUND CONTROL///////
		private function ErrorFunc(e:MouseEvent)
		{
			soundControl = new SoundControl();
			soundControl.loadSound("error.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
		
		}
		
		private function TrueFunc(e:MouseEvent)
		{
			soundControl = new SoundControl();
			soundControl.loadSound("clap.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
			setTimeout(destroyCaller, 1500);
		}
		
		private function CorrectFunc(e:MouseEvent)
		{
			soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 1);
			addChild(soundControl);
			soundControl.soundPlay();
		}
	
	}

}
