package com.visualizer.ui
{
	import com.vml.text.VMLTextField;
	import com.vml.ui.AbstractButton;
	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class ViewButton extends AbstractButton
	{
		
		private static const format:String = "close-button";
		private var _label:VMLTextField;
		private var _url:String;
		
		public function ViewButton()
		{
			super();
		}
		
		public function set url( value:String ):void
		{
			_url = value;
		}
		
		override protected function handleClick(event:MouseEvent):void
		{
			navigateToURL( new URLRequest( _url ), "_blank" );
		}
		
		public function get textField():VMLTextField
		{
			return _label;
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