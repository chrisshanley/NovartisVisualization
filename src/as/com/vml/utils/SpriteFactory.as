﻿package com.vml.utils{		import flash.display.GradientType;	import flash.display.InterpolationMethod;	import flash.display.SpreadMethod;	import flash.display.Sprite;	import flash.geom.Matrix;
		public class SpriteFactory	{		public function SpriteFactory()		{		}						public static function getRectSprite( width:Number, height:Number, hex:uint = 0 ):Sprite		{			var sprite:Sprite = new Sprite();			sprite.graphics.beginFill( hex , 1 );			sprite.graphics.drawRect( 0, 0, width, height );			sprite.graphics.endFill();			return sprite;		}				public static function getCircleSprite( radius:Number, hex:uint = 0 ):Sprite		{			var sprite:Sprite = new Sprite();			sprite.graphics.beginFill( hex , 1 );			sprite.graphics.drawCircle( 0, 0,radius );			sprite.graphics.endFill();			return sprite;		}				public static function getRoundRectSprite( width:Number, height:Number, curve:uint = 10, hex:uint = 0 ):Sprite		{			var sprite:Sprite = new Sprite();			sprite.graphics.beginFill( hex , 1 );			sprite.graphics.drawRoundRect( 0, 0, width, height, curve, curve );			sprite.graphics.endFill();			return sprite;		}						public static function getGradientRectSprite(width:Number, height:Number, colors:Array, rotation:Number = 0.5 ):Sprite		{			var sprite:Sprite = new Sprite();			var fillType:String = GradientType.LINEAR;			var alphas:Array = [1, 1];			var ratios:Array = [65, 255]; 			var matr:Matrix = new Matrix();			var spreadMethod:String = SpreadMethod.PAD;			matr.createGradientBox(width, height, Math.PI * rotation, 0, 0);			sprite.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  			sprite.graphics.drawRect(0,0,width,height);			sprite.graphics.endFill();			return sprite;		}				public static function getGradientCircleSprite(radius:Number, colors:Array, rotation:Number = 0.5 ):Sprite		{			var sprite:Sprite = new Sprite();			var fillType:String = GradientType.RADIAL;			var alphas:Array = [1, 1];			var ratios:Array = [127, 255]; 			var matr:Matrix = new Matrix();						var spreadMethod:String = SpreadMethod.PAD;						matr.createGradientBox( radius*2 , radius*2, 0, radius * -1, radius * -1 );			sprite.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod, InterpolationMethod.RGB);  			sprite.graphics.drawCircle(0, 0, radius);			sprite.graphics.endFill();			return sprite;		}	}}