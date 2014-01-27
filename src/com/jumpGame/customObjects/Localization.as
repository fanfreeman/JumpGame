package com.jumpGame.customObjects
{
	public class Localization
	{
		public function Localization()
		{
		}
		
		public function getMessageRoundStart():String {
			var randomInt:int = Math.floor(Math.random() * 10);
			switch (randomInt) {
				case 0:
					return "Hey there, you look good today";
				case 1:
					return "Who doesn't love a starry sky?";
				case 2:
					return "No leg cramps hopefully";
				case 3:
					return "You ready? Let's do this!";
				case 4:
					return "Meanwhile, in a kingdom far far away...";
				case 5:
					return "Finger warm up prior to play is recommended";
				case 6:
					return "Are you feeling the holiday spirit?";
				case 7:
					return "Warning: do not try this at home";
				case 8:
					return "This looks like good exercise";
				case 9:
					return "Hopefully you don't have fear of heights";
			}
			return "";
		}
		
		public function getMessagePlayerFail():String {
			var randomInt:int = Math.floor(Math.random() * 11);
			switch (randomInt) {
				case 0:
					return "Ouch, that's gotta hurt";
				case 1:
					return "Let's take a bath in boiling lava";
				case 2:
					return "NoooOOoooooOo, n33d MOAR COINS!";
				case 3:
					return "The cake is just a little bit further";
				case 4:
					return "Whoa, how did that happen?";
				case 5:
					return "Next time, maybe try the 'button smash' method";
				case 6:
					return "Next time, bring a jetpack or something";
				case 7:
					return "This should be called 'The Jumping Games: Catching Fire'";
				case 8:
					return "Alright, let's try this again";
				case 9:
					return "Medic! We need a medic!";
				case 10:
					return "You are on fire";
			}
			return "";
		}
		
		/**
		 * Helpful tip shown on loading screens
		 */
		public static function getMessageTip():String {
			var randomInt:int = Math.floor(Math.random() * 5);
			switch (randomInt) {
				case 0:
					return "Suggestions or concerns? Let us know by writing on our page.";
				case 1:
					return "Click and drag to scroll menus, like you would on a mobile device.";
				case 2:
					return "Don't get run over by a train! You won't if you move upward quickly.";
				case 3:
					return "Step on evil floating cannons to get rid of them!";
				case 4:
					return "Bouncy blue balls knocking you sideways? Best to let the hero come to a stop by himself."
				case 5:
					return "The Big Bell sprays magical goodies when you bump it up."
				case 6:
					return "Bouncy red balls do not help you move up, so it's best to avoid them.";
				case 7:
					return "Fairies trapped in bubbles are worth more score points than coins.";
			}
			return "";
		}
		//					return "Suggestions or concerns? Let us know by click on the feedback button to the left.";
	}
}