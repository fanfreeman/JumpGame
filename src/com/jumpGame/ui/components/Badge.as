package com.jumpGame.ui.components
{
	import com.jumpGame.customObjects.Font;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class Badge extends Sprite
	{
		private var badgeAnimationBottom:MovieClip;
		private var badgeTextBottom:TextField;
		private var badgeBottomInUse:Boolean = false;
		
		private var badgeAnimationTop:MovieClip;
		private var badgeTextTop:TextField;
		private var badgeTopInUse:Boolean = false;
		
		public function Badge()
		{
			super();
			
			// badge animations
			badgeAnimationBottom = new MovieClip(Statics.assets.getTextures("BadgeFlash"), 30);
			badgeAnimationBottom.pivotX = Math.ceil(badgeAnimationBottom.width / 2); // center art on registration point
			badgeAnimationBottom.pivotY = badgeAnimationBottom.height;
			badgeAnimationBottom.x = Statics.stageWidth / 2;
			badgeAnimationBottom.y = Statics.stageHeight - 40;
			badgeAnimationBottom.loop = false;
			badgeAnimationBottom.visible = false;
			this.addChild(badgeAnimationBottom);
			
			badgeAnimationTop = new MovieClip(Statics.assets.getTextures("BadgeFlash"), 30);
			badgeAnimationTop.pivotX = Math.ceil(badgeAnimationTop.width / 2); // center art on registration point
			badgeAnimationTop.pivotY = badgeAnimationTop.height;
			badgeAnimationTop.x = Statics.stageWidth / 2;
			badgeAnimationTop.y = Statics.stageHeight - 150;
			badgeAnimationTop.loop = false;
			badgeAnimationTop.visible = false;
			this.addChild(badgeAnimationTop);
			
			// badge text fields
			var fontBadge:Font = Fonts.getFont("Materhorn25");
			badgeTextBottom = new TextField(200, 50, "", fontBadge.fontName, 18, 0xffffff);
			badgeTextBottom.hAlign = HAlign.CENTER;
			badgeTextBottom.vAlign = VAlign.CENTER;
			badgeTextBottom.pivotX = badgeTextBottom.width / 2;
			badgeTextBottom.pivotY = badgeTextBottom.height / 2;
			badgeTextBottom.x = Statics.stageWidth / 2;
			badgeTextBottom.y = badgeAnimationBottom.y - Math.ceil(badgeAnimationBottom.height / 2) - 5;
			badgeTextBottom.visible = false;
			this.addChild(badgeTextBottom);
			
			badgeTextTop = new TextField(200, 100, "", fontBadge.fontName, 18, 0xffffff);
			badgeTextTop.hAlign = HAlign.CENTER;
			badgeTextTop.vAlign = VAlign.CENTER;
			badgeTextTop.pivotX = badgeTextTop.width / 2;
			badgeTextTop.pivotY = badgeTextTop.height / 2;
			badgeTextTop.x = Statics.stageWidth / 2;
			badgeTextTop.y = badgeAnimationTop.y - Math.ceil(badgeAnimationTop.height / 2) - 5;
			badgeTextTop.visible = false;
			this.addChild(badgeTextTop);
		}
		
		/**
		 * Display achievement badge
		 */
		public function showAchievement(message:String):void {
			if (!badgeBottomInUse) {
				// bring achievement badge to front
//				setChildIndex(badgeAnimationBottom, numChildren - 1);
//				setChildIndex(badgeTextBottom, numChildren - 1);
				badgeBottomInUse = true;
				if (!Sounds.sfxMuted) Sounds.sndGong.play();
				
				starling.core.Starling.juggler.add(badgeAnimationBottom);
				badgeAnimationBottom.alpha = 1;
				badgeAnimationBottom.visible = true;
				badgeAnimationBottom.play();
				
				badgeTextBottom.text = message;
				badgeTextBottom.alpha = 1;
				badgeTextBottom.visible = true;
				Starling.juggler.delayCall(fadeOutBadgeBottom, 4);
			}
			else if (!badgeTopInUse) {
				badgeTopInUse = true;
				if (!Sounds.sfxMuted) Sounds.sndGong.play();
				
				starling.core.Starling.juggler.add(badgeAnimationTop);
				badgeAnimationTop.alpha = 1;
				badgeAnimationTop.visible = true;
				badgeAnimationTop.play();
				
				badgeTextTop.text = message;
				badgeTextTop.alpha = 1;
				badgeTextTop.visible = true;
				Starling.juggler.delayCall(fadeOutBadgeTop, 4);
			}
			// if both badges are in use, do nothing
		}
		
		/**
		 * Fade out the bottom achievement badge
		 */
		private function fadeOutBadgeBottom():void {
			badgeAnimationBottom.stop();
			starling.core.Starling.juggler.remove(badgeAnimationBottom);
			Starling.juggler.tween(badgeAnimationBottom, 1, {
				transition: Transitions.LINEAR,
				alpha: 0
			});
			Starling.juggler.tween(badgeTextBottom, 1, {
				transition: Transitions.LINEAR,
				alpha: 0
			});
			Starling.juggler.delayCall(hideBadgeBottom, 1);
		}
		
		/**
		 * Fade out the top achievement badge
		 */
		private function fadeOutBadgeTop():void {
			badgeAnimationTop.stop();
			starling.core.Starling.juggler.remove(badgeAnimationTop);
			Starling.juggler.tween(badgeAnimationTop, 1, {
				transition: Transitions.LINEAR,
				alpha: 0
			});
			Starling.juggler.tween(badgeTextTop, 1, {
				transition: Transitions.LINEAR,
				alpha: 0
			});
			Starling.juggler.delayCall(hideBadgeTop, 1);
		}
		
		/**
		 * Hide the bottom achievement badge
		 */
		private function hideBadgeBottom():void {
			badgeAnimationBottom.visible = false;
			badgeTextBottom.visible = false;
			badgeBottomInUse = false;
		}
		
		/**
		 * Hide the top achievement badge
		 */
		private function hideBadgeTop():void {
			badgeAnimationTop.visible = false;
			badgeTextTop.visible = false;
			badgeTopInUse = false;
		}
	}
}