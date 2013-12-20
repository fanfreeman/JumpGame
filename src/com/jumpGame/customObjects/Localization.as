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
					return "You are on fire"
			}
			return "";
		}
	}
}