package com.visualizer.ui
{
	import com.vml.text.VMLTextField;
	import com.vml.ui.AbstractButton;
	
	public class KeyButton extends AbstractButton
	{
		private static const format:String = "key-button";
		private var _label:VMLTextField;
		
		public function KeyButton()
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
				
				_label = new VMLTextField( value,  KeyButton.format );
				addChild( _label );
			}
		}
	}
}