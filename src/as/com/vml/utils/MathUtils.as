/**
 * author - chris shanley
 *   */


package  com.vml.utils
{
	public class MathUtils
	{
		public function MathUtils()
		{
		}
		
		public static function radiansToDegrees( value:Number ):Number
		{
			return value*(180/Math.PI);
		}
		
		public static function percentInRange( min:Number, max:Number, percent:Number ):Number
		{
			var range:Number = max - min;
			var p:Number = (percent * range) + min;
			return p;
		}

	}
}