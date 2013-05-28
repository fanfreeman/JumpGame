package
{
	import flash.display.Sprite;
	
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	public class PhysicsDebug extends Sprite
	{
		public var debugDraw:b2DebugDraw;
		public function PhysicsDebug()
		{
			this.debugDraw = new b2DebugDraw();
			this.debugDraw.SetSprite(this);
			this.debugDraw.SetDrawScale(1.0);
			this.debugDraw.SetLineThickness(1.0);
			this.debugDraw.SetAlpha(1.0);
			this.debugDraw.SetFillAlpha(0.8);
			this.debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
		}
	}
}