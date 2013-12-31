package
{
//	import com.greensock.TweenLite;
//	import com.greensock.easing.Linear;
//	import com.greensock.easing.Quad;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
//	import starling.textures.Texture;
	
	public class Weather extends Sprite
	{
		// Snow behavior
		private var fade:Boolean = false; // If true, the snowflakes will appear using opacity
		
		// Snow Look
		private var snowAmount:int = 100; // The number of snowflakes
		private var snowSize:Number = 1; // Scale of individual snowflakes. 1 is normal, 2 is double, 0.5 is half
		
		// Snow distance
		private var snowZmin:Number = 0; // The min snowflake distance : 0 is close, 1 is far
		private var snowZmax:Number = 1; // The max snowflake distance : 0 is close, 1 is far
		
		// Snow Opacity
		private var snowAlphaMin:Number = 0.1; // The minimum alpha value
		private var snowAlphaMax:Number = 1.3; // The maximum alpha value
		
		// Snow Rotation
		private var snowRotation:Number = 1 // Rotation animation. 0.5 is half, 2 is double.
		
		// Gravity
		private var gravity:int = 100; // Speed of fall. 100 is the normal speed. 0 to float, -100 to inverse the direction.
		
		// Wind Force
		private var windBegin:int = 200; // The inital wind when the snow starts, then it smoothly changes to the normal values
		
		
		// Wind duration
		private var windTimeMin:int = 1 // Minimum time between two winds
		private var windTimeMax:int = 6 // Maximum time between two winds
		
		// ADVANCED USER ONLY
//		import com.greensock.TweenMax;
//		TweenMax.globalTimeScale = 0.03 // Speed of animation. 1 is normal, 2 is double, 0.5 is half
		
		private var margin:int = 200;
		//var scene = this.parent
		
		private var nWind:int
		private var wind:Object = new Object;
		private var ok:Boolean = true;
		private var nAlpha:Number = 1;
		
		private var snowContainer:Sprite;
		private var snowList:Vector.<Image>;
		private var snowListLength:uint = 0;
		private var snowDepthList:Vector.<Number>;
		
		// weather effect scheduling
		private var switchTime:int;
		private var activated:Boolean = false;
		
		// rain particles
		private static var particleRain:PDParticleSystem;
		
		public function Weather():void {
			this.touchable = false;
//			// setup snow
//			wind.max = 400;
//			wind.min = 0;
//			wind.dir = "right";
//				
//			if (wind.dir == "right") {
//				wind.force = windBegin;
//			} else if(wind.dir == "left") {
//				wind.force = -windBegin;
//			} else {
//				wind.force = windBegin;
//			}
//			
//			this.snowList = new Vector.<Image>();
//			this.snowDepthList = new Vector.<Number>;
//			
//			this.windRandom();
//			this.snowContainer = new Sprite();
//			this.snowContainer.visible = false;
//			
//			// create snow
//			for (var i:int = 0; i < snowAmount; i++) {
//				createSnow(i);
//			}
//			
//			this.addChild(this.snowContainer);
			
			// setup rain
			particleRain = new PDParticleSystem(XML(new ParticleAssets.ParticleRainXML()), Statics.assets.getTexture("ParticleRain0000"));
			Starling.juggler.add(particleRain);
			this.addChild(particleRain);
			particleRain.emitterX = Statics.stageWidth / 2;
			particleRain.emitterY = 0;
		}
		
//		private function windRandom():void {
//			if (wind.dir == "right") {
//				nWind = Math.random() * (wind.max - wind.min) + wind.min;
//			} else if(wind.dir == "left") {
//				nWind = -Math.random() * (wind.max - wind.min) - wind.min;
//			} else {
//				nWind = Math.random() * (wind.max * 2 - wind.min) - wind.min - wind.max;
//			}
//			TweenLite.to(wind, Math.random() * 3 + 1, {force:nWind, delay:Math.random() * (windTimeMax - windTimeMin) + windTimeMin, onComplete:windRandom});
//		}
//		
//		private function createSnow(i:int):void {
//			var m:Image = new Image(Statics.assets.getTexture("Snowflake0000"));
//			m.pivotX = Math.ceil(m.width / 2);
//			m.pivotY = Math.ceil(m.height / 2);
//			this.snowList[this.snowListLength] = m;
//			
//			m.y = Math.random() * - margin *2;
//			m.x = Math.random() * (Constants.StageWidth / 2 + margin) - margin * 2;
//			
//			m.rotation = Math.random() * Math.PI * 2;
//			this.snowDepthList[this.snowListLength] = Math.random() * (snowZmax * 2 - snowZmin) + snowZmin;
//			this.snowDepthList[this.snowListLength] = int(this.snowDepthList[this.snowListLength] * 100) / 100;
//			m.scaleX = m.scaleY = Math.max(0.4, (1 / (Math.max(0, this.snowDepthList[this.snowListLength])) - 0.5) * snowSize);
//			//trace("d : "+m.depth + " = scaleX " + m.scaleX)
//			if (fade == true) {
//				m.alpha = 0;
//			} else {
//				m.alpha = newAlpha(this.snowListLength);
//			}
//			this.snowContainer.addChild(m);
//			snowX(this.snowListLength);
//			snowY(this.snowListLength);
//			
//			this.snowListLength++;
//		}
//		
//		private function newAlpha(index:uint):Number {
//			if(this.snowList[index].scaleX < 2 * snowSize) {
//				nAlpha = (Math.random() * (snowAlphaMax - snowAlphaMin) + snowAlphaMin);
//			} else if(this.snowList[index].scaleX > 2 * snowSize && this.snowList[index].scaleX < 4 * snowSize) {
//				nAlpha = (Math.random() * (snowAlphaMax - snowAlphaMin) + snowAlphaMin) * 0.6;
//			} else if(this.snowList[index].scaleX > 4 * snowSize) {
//				nAlpha = (Math.random() * (snowAlphaMax - snowAlphaMin) + snowAlphaMin) * 0.4;
//			}
//			return nAlpha;
//		}
//		
//		private function snowX(index:uint):void {
//			xReset(index);
//			TweenLite.to(this.snowList[index], Math.random()*2+1, {alpha:newAlpha(index), x:this.snowList[index].x+(Math.random()*80-40+wind.force)*(this.snowList[index].scaleX), rotation:String(Math.random() * snowRotation * Math.PI * 5), onComplete:snowX, onCompleteParams:[index], ease:Quad.easeInOut, overwrite:false});
//		}
//		
//		private function snowY(index:uint):void {
//			yReset(index);
//			TweenLite.to(this.snowList[index], Math.random()*2+1, {y:this.snowList[index].y+(Math.random()*(gravity/2)+(gravity/2))*(this.snowList[index].scaleX)*3, onComplete:snowY, onCompleteParams:[index], ease:Linear.easeInOut, overwrite:false});
//		}
//		
//		private function xReset(index:uint):void {
//			if (this.snowList[index].x > Constants.StageWidth + margin) {
//				this.snowList[index].x = Math.random() * -margin;
//			} else 	if (this.snowList[index].x < -margin) {
//				this.snowList[index].x = Constants.StageWidth + Math.random() * margin;
//			}
//		}
//		
//		private function yReset(index:uint):void {
//			if (this.snowList[index].y > Constants.StageHeight + margin) {
//				this.snowList[index].y = Math.random() * -margin;
//			} else if (this.snowList[index].y < -margin) {
//				this.snowList[index].y = Constants.StageHeight + Math.random() * margin;
//			}
//		}
		
		public function scheduleFirst():void {
			// schedule next weather effect in 10 to 20 seconds
			this.switchTime = Statics.gameTime + int((Math.random() * 10 + 10) * 1000);
		}
		
		public function checkSchedules():void {
			if (!this.activated) { // not activated
				if (Statics.gameTime > this.switchTime) {
					var duration:int = int(Math.random() * 10 + 10); // activate for 10 to 20 seconds
					
					// activate weather effect
//					if (Math.random() < 0.5) this.snowContainer.visible = true;
//					else particleRain.start(duration);
					particleRain.start(duration);
					
					// schedule deactivation time
					this.switchTime = Statics.gameTime + duration * 1000;
					this.activated = true;
				}
			} else { // activated
				if (Statics.gameTime > this.switchTime) {
					// turn off weather effect
//					this.snowContainer.visible = false;
					
					// schedule next activation time
					this.switchTime = Statics.gameTime + int((Math.random() * 10 + 10) * 1000); // rest 10 to 20 seconds
					this.activated = false;
				}
			}
		}
	}
}