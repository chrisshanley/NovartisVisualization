/**
 * author chris shanley
 *   */

package com.vml.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapUtils
	{
		
		public static const WIDTH:String = "width";
		public static const HEIGHT:String = "height";
		
		public function BitmapUtils()
		{
		}
		
		
		/**
		 * takes a source bitmap a crops out a rectangle from it
		 * @bitmap = source bitmap to draw from
		 * @rect = the rectangular area you want to get the pixels from
		 *   */
		
		public static function crop(bitmap:Bitmap, rect:Rectangle, transparent:Boolean = false):Bitmap
		{
			var copy:BitmapData = new BitmapData( rect.width, rect.height, transparent, 0 );
			var bmd:BitmapData = bitmap.bitmapData;
			copy.copyPixels( bmd, rect , new Point() );
			return new Bitmap( copy );	
		}
		
		
		
		/**
		 * resizes a bitmap with aspect ratoi
		 * @image - the bitmap one wants to resize, 
		 * @requestedSize - the number relating to the desired height or width
		 * @sideForRatio - a string representing which side is used to get the ratio, basically if you resizing it based on height or width; *   
		 * */
		public static function resizeWithAspect(image:Bitmap, requestedSize:int, sideForRatio:String ):void
		{
			var ratio:Number;
			switch( sideForRatio )
			{
				case BitmapUtils.WIDTH :
					ratio = requestedSize / image.width ;
					image.width = requestedSize;
					image.height *= ratio;
				break;
				case BitmapUtils.HEIGHT :
					ratio = requestedSize / image.height ;
					image.height = requestedSize;
					image.width *= ratio;
				break;
			}
		}

	}
}