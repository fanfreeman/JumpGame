package com.jumpGame.builders
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import starling.display.Sprite;
	
	public class RoundObjectBuilder
	{
		protected var world:b2World;
		
		public function RoundObjectBuilder(world:b2World)
		{
			this.world = world;
		}
		
		public function build(sprite:Sprite, 
							  radius:Number, 
							  initialX:Number, 
							  initialY:Number, 
							  initialVelocityX:Number = 0.0, 
							  initialVelocityY:Number = 0.0,
							  restitution:Number = 1.0,
							  friction:Number = 0.75,
							  density:Number = 1.0):b2Body {
			// create shape
			var shape:b2CircleShape = new b2CircleShape(radius);
			
			// create fixture definition
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.restitution = restitution;
			fixtureDef.friction = friction;
			fixtureDef.density = density;
			
			// create body definition
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_dynamicBody;
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