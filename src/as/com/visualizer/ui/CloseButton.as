package com.visualizer.ui
{
	import com.vml.text.VMLTextField;
	import com.vml.ui.AbstractButton;
	
	public class CloseButton extends AbstractButton
	{
		
		private static const format:String = "close-button";
		private var _label:VMLTextField;
		
		public function CloseButton()
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
				
				_label = new VMLTextField( value,  CloseButton.format );
				addChild( _label );
			}
		}
	}
}