package com.vml.text
{
	import com.vml.font.FormatController;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class Body extends TextField
	{
		
		public function Body( formatType:String )
		{
			super();
			
			var formatController:FormatController = FormatController.getInstance();
			var format:TextFormat = formatController.getFormat( formatType );			
			defaultTextFormat = format;
			
			autoSize = TextFieldAutoSize.LEFT;
			multiline = true;
			selectable = true;
			mouseEnabled = false;
			embedFonts = true;
		}
		
		override public  function set text( value:String ):void
		{
			super.htmlText = value;
		}
	}
}