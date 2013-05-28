package com.jumpGame.builders
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import starling.display.Sprite;
	
	public class PhysicsBuilder
	{
		public var isStatic:Boolean = false;
		public var type:int;
		public var radius:Number;
		public var halfWidth:Number;
		public var halfHeight:Number;
		
		protected var world:b2World;
		
		public function PhysicsBuilder(world:b2World)
		{
			this.world = world;
		}
		
		public function setDimensions(type:int, dimension1:Number, dimension2:Number = NaN):void {
			this.type = type;
			if (type == Constants.SHAPE_CIRCLE) {
				this.radius = dimension1;
			} else if (type == Constants.SHAPE_BOX) {
				this.halfWidth = dimension1;
				this.halfHeight = dimension2;
			}
		}
		
		public function build(sprite:Sprite,
							  initialX:Number, 
							  initialY:Number, 
							  initialVelocityX:Number = 0.0, 
							  initialVelocityY:Number = 0.0,
							  restitution:Number = 1.0,
							  friction:Number = 0.75,
							  density:Number = 1.0):b2Body {
			// create shape
			if (this.type == Constants.SHAPE_CIRCLE) {
				var circleShape:b2CircleShape = new b2CircleShape(this.radius);
			} else if (this.type == Constants.SHAPE_BOX) {
				var boxShape:b2PolygonShape = new b2PolygonShape();
				boxShape.SetAsBox(this.halfWidth, this.halfHeight);
			}
			
			
			// create fixture definition
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			if (this.type == Constants.SHAPE_CIRCLE) {
				fixtureDef.shape = circleShape;
			} else if (this.type == Constants.SHAPE_BOX) {
				fixtureDef.shape = boxShape;
			}
			fixtureDef.restitution = restitution;
			fixtureDef.friction = friction;
			fixtureDef.density = density;
			
			// create body definition
			var bodyDef:b2BodyDef = new b2BodyDef();
			if (this.isStatic) {
				bodyDef.type = b2Body.b2_staticBody;
			} else {
				bodyDef.type = b2Body.b2_dynamicBody;
			}
			bodyDef.position.Set(initialX, initialY);
			
			// create body
			var body:b2Body = world.CreateBody(bodyDef);
			
			// create fixture
			body.CreateFixture(fixtureDef);
			
			// set starting velocity
			var startingVelocity:b2Vec2 = new b2Vec2(initialVelocityX, initialVelocityY);
			body.SetLinearVelocity(startingVelocity);
			
			// link sprite
			body.SetUserData(sprite);
			
			return body;
		}
	}
}
