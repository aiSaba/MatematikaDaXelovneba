package  {
	import fl.motion.Animator;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.*
	import com.greensock.easing.*
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import flash.events.DataEvent;
	
	
	public class Zgarbi extends MovieClip {
		
		private var stage4MC:MovieClip;
		private var zgarbi:MovieClip;
		private var textFrame:MovieClip;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var soundControl1:SoundControl;
		
		public function Zgarbi(_stageWidth:Number=1024, _stageHeight:Number=768) 
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(ev:Event):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init)
			addFirstStage();
		}
		
		private function addFirstStage():void
		{
			stage4MC = new Stage4MC();
			addChild(stage4MC);
			stage4MC.x = _stageWidth / 2;
			stage4MC.y = _stageHeight / 2;
			stage4MC.height = _stageWidth/2.5;
			stage4MC.scaleX = stage4MC.scaleY;
			
			zgarbi = stage4MC.zgarbi;
		    textFrame = stage4MC.textFrame;
			
			zgarbi.alpha = 0;
			textFrame.alpha = 0;
			
			
			firstStageMcAnimation();
		}
		
		private function firstStageMcAnimation():void
		{

			TweenMax.fromTo(zgarbi, 1, {x:zgarbi.x, y:(2 * _stageHeight)}, {x:zgarbi.x, y:zgarbi.y, alpha:1, onComplete:addText});
			
		}
		
		private function addText():void
		{
			soundControl1 = new SoundControl();
			addChild(soundControl1);
			soundControl1.loadSound("09_aqtivoba.mp3", 1);
			soundControl1.soundPlay();
			TweenMax.to(textFrame, 0.5, { alpha:1 , onComplete:waitFunc} );
			
		}
		
		private function waitFunc():void
		{
			setTimeout(next, 7000)
		}
		private function next ():void
		{	
			destroy();	
		}
		
		private function destroy():void
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "movrchi"));
			
			TweenMax.killTweensOf(zgarbi);
			TweenMax.killTweensOf(textFrame);
			
			if (stage4MC)
			{
				removeChild(stage4MC);
				stage4MC = null;
			}
			if (soundControl1)
			{
				removeChild(soundControl1)
				soundControl1 = null;
			}
			
		}
		
	}
	
}
