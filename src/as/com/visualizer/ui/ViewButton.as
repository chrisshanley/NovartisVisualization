package com.visualizer.ui
{
	import com.vml.text.VMLTextField;
	import com.vml.ui.AbstractButton;
	
	public class ViewButton extends AbstractButton
	{
		
		private static const format:String = "close-button";
		private var _label:VMLTextField;
		
		public function ViewButton()
		{
			super();
		}
		
		public function set label( value:String ):void
		{
			if( _label )
			{
				_label.htmlText = value;	
			}
			else
			{
				
				_label = new VMLTextField( value,  ViewButton.format );
				addChild( _label );
			}
		}
	}
}