package com.visualizer.ui
{
	import com.vml.ui.AbstractButton;
	import com.vml.utils.SpriteFactory;
	
	public class CategoryButton extends AbstractButton
	{
		
		private var _category:String;
		public function CategoryButton( category:String, colors:Array )
		{
			super();
			_category = category;
			
			addChild( SpriteFactory.getGradientCircleSprite( 5, colors ) );
		}
		
		public function get category( ):String
		{
			return _category;
		}
	}
}