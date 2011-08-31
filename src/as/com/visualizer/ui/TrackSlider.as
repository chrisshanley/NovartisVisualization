package com.visualizer.ui
{
	import com.vml.text.VMLTextField;
	
	import flash.display.Sprite;
	
	public class TrackSlider extends Sprite
	{
		private var _view:Sprite;
		private var _label:VMLTextField;
		
		public function TrackSlider( view:Sprite, date:String = null )
		{
			super();
		
			if( date )
			{
				_label = addChild(  new VMLTextField( date, "date-format" ) ) as VMLTextField;
				_label.y = _label.height * -1;
			}
			_view  = addChild( view )  as Sprite;
			
		}
		
		public function get label():VMLTextField 
		{
			return _label;
		}
		
		override public function get width():Number
		{
			return _view.width;
		}
		
		override public function get height():Number
		{
			return _view.height;
		}
	}
}