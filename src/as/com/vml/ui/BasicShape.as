
/*  BasicShape.as
**	Author: Marc Brown (mbrown2@vml.com)
**	Version: 1.0
**	
**	Supported shapes:
**	rect		(x, y, width, height)
**	roundRect	(x, y, width, height, ellipseWidth, ellipseHeight)
**	circle		(x, y, radius)
**	ellipse		(x, y, width, height)
*/

package com.vml.ui {
	
	import flash.display.Sprite;
	
	
	public class BasicShape extends Sprite
	{
		
		
		public function BasicShape( $type:String, $color:uint, $alpha:Number, $x:Number, $y:Number, $widthOrRadius:Number, $height:Number = NaN, $ellipseWidth:Number = NaN, $ellipseHeight:Number = NaN )
		{
			
			init( $type, $color, $alpha, $x, $y, $widthOrRadius, $height, $ellipseWidth, $ellipseHeight );
		}
		
		public function init( $type:String, $color:uint, $alpha:Number, $x:Number, $y:Number, $widthOrRadius:Number, $height:Number, $ellipseWidth:Number, $ellipseHeight:Number ):void
		{
			
			if ( $type == "rect" || $type == "roundRect" || $type == "circle" || $type == "ellipse" ) {
				var bg:Sprite = new Sprite;
				bg.graphics.beginFill( $color, $alpha );
				if ( $type == "rect") bg.graphics.drawRect( $x, $y, $widthOrRadius, $height );
				else if ( $type == "roundRect") bg.graphics.drawRoundRect( $x, $y, $widthOrRadius, $height, $ellipseWidth, $ellipseHeight );
				else if ( $type == "circle") bg.graphics.drawCircle( $x, $y, $widthOrRadius );
				else if ( $type == "ellipse") bg.graphics.drawEllipse( $x, $y, $widthOrRadius, $height );
				bg.graphics.endFill();
				addChild( bg );
			} else {
				trace("[BasicShape.as] ---> ERROR: Only rect, roundRect, circle and ellipse are supported.");
			}
		}
	}
}