package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.events.DataEvent;
	
	public class Stage7Class extends MovieClip
	{
		
		private var buildingArray:Array;
		private var randomIndex:int
		private var randomIndexOut:int
		private var randomPlus:RandomPlus;
		private var soundControl:SoundControl;
		private var svanuriKoshki:MovieClip;
		private var piramida:MovieClip;
		private var pentagoni:MovieClip;
		private var korpusi:MovieClip;
		private var kolizeumi:MovieClip;
		private var didiTagi:MovieClip;
		
		private var currentBuilding:MovieClip
		private var background_MC:MovieClip
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var figureArray:Array
		private var scoreCounter:int
		
		public function Stage7Class(_stageWidth:Number = 1024, _stageHeight:Number = 768)
		{
			this._stageHeight = _stageHeight;
			this._stageWidth = _stageWidth;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addBuildings();
		}
		
		private function addBuildings():void
		{
			addRandomBuilding();
			
			figureArray = [{figure: background_MC.koshki, isAllowed: true, text: "koshki"}, {figure:background_MC.piramida, isAllowed:true, text:"piramida"}, {figure:background_MC.pentagoni, isAllowed:true, text:"pentagoni"}, {figure:background_MC.korpusi, isAllowed:true, text:"korpusi"}, {figure:background_MC.kolizeumi, isAllowed:true, text:"kolizeumi"}, {figure:background_MC.didiTagi, isAllowed:true, text:"didiTagi"}]//,{figure:background_MC.paralelogrami, isAllowed:true, text:"paralelogrami"}]    
			buildingArray = [ { figure: svanuriKoshki, text: "koshki" },                    { figure:piramida, text:"piramida" },                              {figure:pentagoni, text:"pentagoni" },                             { figure:korpusi, text:"korpusi" },                             { figure:kolizeumi, text:"kolizeumi" },                             {figure:didiTagi, text:"didiTagi" } ];
			
			addListeners();
		
		}
		
		private function addListeners():void
		
		{
			for (var i:int = 0; i < figureArray.length; i++)
			{
				background_MC.paralelogrami.addEventListener(MouseEvent.CLICK, falseFun);
				background_MC.paralelogrami.buttonMode = true
				
				figureArray[i].figure.buttonMode = true
				if (figureArray[i].text == buildingArray[randomIndexOut].text)
				{
					
					figureArray[i].figure.addEventListener(MouseEvent.CLICK, trueFunc)
					
				}	
				else
				{
					
					figureArray[i].figure.addEventListener(MouseEvent.CLICK, falseFun)
				}
			}
		}
		
		private function nextBuildingCall ():void
		{
			
			
			clearTimeout(1);
			TweenMax.killAll();
			
			removeChild(background_MC)
			removeChild(currentBuilding)
			
			background_MC = null;
			currentBuilding = null;
			
			
			
			for (var i:int = 0; i < figureArray[i].length; i++)
			{
				figureArray[i].figure.removeEventListener(MouseEvent.CLICK, trueFunc)
				figureArray[i].figure.removeEventListener(MouseEvent.CLICK, falseFun)
			}
			
			
			addBuildings();
		}
		
		private function trueFunc(e:MouseEvent):void
		{
			scoreCounter++

			if (scoreCounter == 3)
			{
				
				
				ClapFunc();
				setTimeout(destroyCaller,1500)
				
				scoreCounter = 0
				TweenMax.to(e.currentTarget, 1, { glowFilter: { color:0x33cccc, alpha:1, blurX:15, blurY:15, strength:3 }} );
				CorrecteFunc();
				return
			}
			TweenMax.to(e.currentTarget, 1, { glowFilter: { color:0x33cccc, alpha:1, blurX:15, blurY:15, strength:3 }} );
			CorrecteFunc();
			setTimeout(nextBuildingCall, 2000)
		}
		
		
		private function destroyCaller():void
		{
			dispatchEvent(new DataEvent(DataEvent.DATA, false, false, "endOfScene"));
			destroy();
		}
		
		private function falseFun(e:MouseEvent):void
		{
			TweenMax.to(e.currentTarget, 1, { glowFilter: { color:0xff0000, alpha:1, blurX:15, blurY:15, strength:3,delay:1.5 , remove:true }} );
			FalseFunc();
		}

		
		private function addRandomBuilding():void
		{
			
			currentBuilding = new MovieClip;
			randomPlus = new RandomPlus(5);
			randomIndex = randomPlus.getNum();
			
			svanuriKoshki = new SvanuriKoshki() as MovieClip;
			piramida = new Piramida() as MovieClip;
			pentagoni = new Pentagoni() as MovieClip;
			korpusi = new Korpusi() as MovieClip;
			kolizeumi = new Kolizeumi() as MovieClip;
			didiTagi = new DidiTagi() as MovieClip;
			background_MC = new Background_MC() as MovieClip;
			
			addChild(background_MC)
			background_MC.x = _stageWidth / 2;
			background_MC.y = _stageHeight / 2;
			randomIndexOut = randomIndex

			
			
			
			buildingArray = [svanuriKoshki, piramida, pentagoni, korpusi, kolizeumi, didiTagi]
			currentBuilding = buildingArray[randomIndex]
			addChild(currentBuilding)
			
			
			
			currentBuilding.x = _stageWidth / 2;
			currentBuilding.y = _stageHeight / 2;
			currentBuilding.height = _stageHeight/2.5;
			currentBuilding.scaleX = currentBuilding.scaleY;
			

			randomIndex = randomIndexOut
		}
		
		private function CorrecteFunc()
		{
			soundControl = new SoundControl();
			soundControl.loadSound("correct.mp3", 0.5);
			addChild(soundControl);
			soundControl.soundPlay();
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
		
				private function destroy():void
		{
			if (currentBuilding)
			{
				removeChild(currentBuilding);
				currentBuilding = null;
				
				
				removeChild(background_MC);
				background_MC = null;
				
			}
		}
	}

}
