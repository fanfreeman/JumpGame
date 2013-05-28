package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	[SWF(width = "756", height = "650", frameRate = "60", backgroundColor = "#000000")]
	
	public class JumpGame extends Sprite
	{
		private var myStarling:Starling;
		
		public function JumpGame()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Initialize Starling object.
			myStarling = new Starling(Game, stage);
			
			// Define basic anti aliasing.
			myStarling.antiAliasing = 1;
			
			// Show statistics for memory usage and fps.
			myStarling.showStats = true;
			
			// Position stats.
			myStarling.showStatsAt("left", "bottom");
			
			// Start Starling Framework.
			myStarling.start();
		}
	}
}