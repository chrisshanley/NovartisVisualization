package com.visualizer.views
{
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Sine;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.visualizer.events.VisualizerEvent;
	import com.vml.utils.SpriteFactory;
	import com.vml.views.AbstractView;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	public class IdeaView extends AbstractView
	{
		
		private var _animating:Boolean;
		private var _colors:Array;
		private var _category:String;
		private var _indicator:Sprite;
		private var _topTen:Boolean;
		private var _size:Number;
		
		public function IdeaView( radius:Number, colors:Array, category:String )
		{
			
			super();
			_size = radius;
			_colors = colors;
			_category = category;
			_animating = true;
			buttonMode = true;
			var drawable:Sprite = SpriteFactory.getGradientCircleSprite( Math.ceil(radius), colors );
		//	var bmd:BitmapData = new BitmapData( drawable.width, drawable.height, true, 0 );
		//	var bm:Bitmap = new Bitmap();
		//	bmd.draw( drawable );
	
			
			addChild( drawable );
			addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver );
			addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut );
			addEventListener(MouseEvent.CLICK, handleMouseClick );	
			TweenPlugin.activate([ GlowFilterPlugin ] );
		}
		
		public function set topTen( value:Boolean ):void
		{
			_topTen = value;
		}
		
		public function get topTen():Boolean
		{
			return _topTen;
		}
		
		public function get category():String 
		{
			return _category;
		}
		
		public function get colors():Array 
		{
			return _colors;
		}
		
		private function handleMouseOver( event:MouseEvent ):void
		{
			trace( this, name , " handle over  " );
 			dispatchEvent( new VisualizerEvent( VisualizerEvent.IDEA_OVER , true ) );	
		}
		
		private function handleMouseOut( event:MouseEvent ):void
		{
			dispatchEvent( new VisualizerEvent( VisualizerEvent.IDEA_OUT , true ) );
		}
		
		private function handleMouseClick( event:MouseEvent ):void
		{
			trace( this, " click "  );
			dispatchEvent( new VisualizerEvent( VisualizerEvent.IDEA_CLICK , true ) );
		}
		
		public function show():void
		{
			TweenLite.to( this, 0.7, { scaleX:1, scaleY:1, ease:Back.easeOut } );
		}
		
		public function hide():void
		{
			TweenLite.to( this, 0.7, { scaleX:0, scaleY:0, ease:Back.easeOut } );
		}
		
		public function indicate():void
		{
			_animating = true;
			filters = [ new GlowFilter( _colors[1], 1, 10, 10, 2 ) ];
			//_indicator.alpha = 1;
			//TweenLite.to( _indicator, 0.5, { alpha:0, onComplete:indicateComplete } );
			TweenLite.to(this, 2, { glowFilter:{blurX:1, blurY:1, alpha:0 } } );
		}
		
		public function get size():Number
		{
			return _size;
		}
		
		private function indicateComplete():void
		{
			_animating = false
			filters = null;
		}
		
		public function get animating():Boolean
		{
			return _animating;
		}
	}
}