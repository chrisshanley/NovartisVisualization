package com.vml.utils
{
	import com.greensock.easing.Bounce;
	import com.vml.data.StageObjectData;
	
	import flash.display.DisplayObject;

	public class LiquidStageManagementUtils
	{
		public function LiquidStageManagementUtils()
		{
		}
		
		public static function removeObject( vector:Vector.<StageObjectData>,  view:DisplayObject ):Boolean
		{
			var success:Boolean = false;
			var stageObject:StageObjectData;
			var i:int = 0;
			for each( stageObject in vector )
			{
				if( stageObject.view == view )
				{
					vector.splice( i, 1 );
					success = true;
				}
				i++;
			}
			return success;
		}
		

	}
}