package com.oaxoa.fx {
	public class LightningType {
		public static const DISCHARGE:String = "discharge";
		public static const LIGHTNING:String = "lightning";
		public static const SHOCK:String = "shock";
		
		public static function setType(lightning:Lightning, type:String):void
		{
			switch(type) {
				case 'discharge' :
					lightning.childrenLifeSpanMin = 1;
					lightning.childrenLifeSpanMax = 3;
					lightning.childrenProbability = 1; // [0,1]
					lightning.childrenMaxGenerations = 3;
					lightning.childrenMaxCount = 4;
					lightning.childrenAngleVariation = 110;
					lightning.thickness = 2;
					lightning.steps = 100;
					lightning.smoothPercentage = 50; // [0,100]
					lightning.wavelength = .3;
					lightning.amplitude = .5;
					lightning.speed = .7;
					lightning.maxLength = 0;
					lightning.maxLengthVary = 0;
					lightning.childrenDetachedEnd = false; // true = lightning ; false = discharge
					lightning.alphaFadeType = LightningFadeType.GENERATION;
					lightning.thicknessFadeType = LightningFadeType.NONE;
					break;
				case 'lightning' :
					lightning.childrenLifeSpanMin = .1;
					lightning.childrenLifeSpanMax = 2;
					lightning.childrenProbability = 1;
					lightning.childrenMaxGenerations = 3;
					lightning.childrenMaxCount = 4;
					lightning.childrenAngleVariation = 130;
					lightning.thickness = 3;
					lightning.steps = 100;
					lightning.smoothPercentage = 50;
					lightning.wavelength = .3;
					lightning.amplitude = .5;
					lightning.speed = 1;
					lightning.maxLength = 0;
					lightning.maxLengthVary = 0;
					lightning.childrenDetachedEnd = true;
					lightning.alphaFadeType = LightningFadeType.TIP_TO_END;
					lightning.thicknessFadeType = LightningFadeType.GENERATION;
					break;
				case 'shock' :
					lightning.childrenLifeSpanMin = .1;
					lightning.childrenLifeSpanMax = 2;
					lightning.childrenProbability = 1;
					lightning.childrenMaxGenerations = 4;
					lightning.childrenMaxCount = 6;
					lightning.childrenAngleVariation = 10;
					lightning.thickness = 5;
					lightning.thickness = 3;
					lightning.steps = 100;
					lightning.smoothPercentage = 50;
					lightning.wavelength = .3;
					lightning.amplitude = .5;
					lightning.speed = 1;
					lightning.maxLength = 0;
					lightning.maxLengthVary = 0;
					lightning.childrenDetachedEnd = true;
					lightning.alphaFadeType = LightningFadeType.TIP_TO_END;
					lightning.thicknessFadeType = LightningFadeType.GENERATION;
					break;
			}
		}
	}
}