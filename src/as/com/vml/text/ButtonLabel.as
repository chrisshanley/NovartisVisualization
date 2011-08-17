package com.vml.text
{
	import com.vml.font.FormatController;
	
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class ButtonLabel extends TextField
	{
		
		private var _formatController:FormatController;
		private var _formatType:String;
		private var _format:TextFormat;
		private var _label:String;
		
		public function ButtonLabel( label:String , formatType:String , multiple:Boolean = false )
		{
			super();
			
			_formatType = formatType;
			_formatController = FormatController.getInstance();
			_format = _formatController.getFormat( _formatType );
			
			_label = label;			
			defaultTextFormat = _format;
			autoSize = TextFieldAutoSize.LEFT;
			antiAliasType = AntiAliasType.ADVANCED;
			multiline = true;
			htmlText = _label;
			selectable = false;
			mouseEnabled = false;
			embedFonts = true;
		}
		
	
		
	}
}