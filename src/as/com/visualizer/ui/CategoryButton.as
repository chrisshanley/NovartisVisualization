package com.visualizer.ui
{
	import com.greensock.TweenLite;
	import com.vml.ui.AbstractButton;
	import com.vml.utils.SpriteFactory;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class CategoryButton extends AbstractButton
	{
		private var _over:Sprite;
		private var _category:String;
		
		public function CategoryButton( category:String, colors:Array )
		{
			super();
			_category = category;
			
			_over = addChild( SpriteFactory.getCircleSprite( 8, 0xffffff ) ) as Sprite;
			_over.scaleX = _over.scaleY = 0;
			addChild( SpriteFactory.getGradientCircleSprite( 5, colors ) );
		}
		
		override protected function handleOver(event:MouseEvent):void
		{
			if( _active )
			{
				TweenLite.to( _over, 0.5, { scaleX:1, scaleY:1 } );
			}
		}
		
		override protected function handleOut(event:MouseEvent):void
		{
			if( _active )
			{
				TweenLite.to( _over, 0.5, { scaleX:0, scaleY:0 } );
			}
		}
		
		override public function set active(value:Boolean):void
		{
			if( value )
			{
				TweenLite.to( _over, 0.5, { scaleX:0, scaleY:0 } );
			}
			else
			{
				handleOver( null );	
			}
			super.active = value;
		}
		
		public function get category( ):String
		{
			return _category;
		}
	}
}