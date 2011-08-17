package com.visualizer.ui
{
	import com.vml.font.FormatController;
	import com.vml.text.VMLTextField;
	import com.vml.ui.AbstractButton;
	
	import flash.display.Sprite;
	
	public class PostButton extends AbstractButton
	{
		private static const format:String = "post-button";
		
		private var _model:Model;
		
		private var _fill:Sprite;
		private var _label:VMLTextField;
		private var _icon:ThoughtBubble;
		
		public function PostButton( )
		{
			super();
			
			_fill = new PostButtonFill() as Sprite;
			addChild( _fill );
			
			_icon = new ThoughtBubble();
			_icon.x = 5;
			_icon.y = _fill.height * 0.5 - _icon.height * 0.5;
			addChild( _icon );
		}
		
		public function set label( value:String ):void
		{
			if( _label )
			{
				_label.htmlText = value;	
			}
			else
			{
				
				_label = new VMLTextField( value,  PostButton.format );
				_label.x = _icon.x + _icon.width - 2;
				_label.y = _fill.height * 0.5 - _label.height * 0.5;
			    addChild( _label );
			}
		}
	}
}