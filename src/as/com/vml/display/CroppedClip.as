package com.vml.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class CroppedClip extends Sprite
	{
		protected var _spriteSheet:BitmapData;
		protected var _width:Number;
		protected var _height:Number;
		protected var _crop:BitmapData;
		protected var _bitmap:Bitmap;	
		protected var _position:Point;
		
		public function CroppedClip( spriteSheet:BitmapData, width:Number, height:Number )
		{
			super();
			_spriteSheet = spriteSheet;
			_width = width;
			_height = height;
			
			_crop = new BitmapData( _width, _height, true, 0x000000);
			_bitmap  = new Bitmap( _crop );
			_position = new Point();
			
			addChild( _bitmap );
		}
		
		public function move( position:Point ):void
		{	
			_position = position;
			_crop.copyPixels( _spriteSheet, new Rectangle( _position.x, _position.y, _width, _height ), new Point() );
			_bitmap.bitmapData = _crop;
		}
		
		public function get position():Point
		{
			return _position;
		}
		
		
	}
}