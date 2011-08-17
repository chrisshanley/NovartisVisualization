/**
 * A scrolling text field component
 * 
 * 
 * PUBLIC
 * m - a Sprite ( data typed MovieClip in library but sense there is no timeline, Sprite is used) that is the mask for the text field
 * textField - the TextField that text is set to
 * slider - a AbstractSlider component that dispacthes a PercentEvent, the textField 's "y" property is set based on percentage from that event
 * 
 * PROTECTED
 * _copy - a String which is the text for the textField
 * _format - a TextFormat, a set method is used , if is null, no text formatting is applied
 * _easing - a number value greater then 0 and less then or equal to 1, the lower the value the more easing, defaults to 1, a setter method is used for this value
 *   
 * */


package com.vml.components
{
	import com.vml.events.PercentEvent;
	import com.vml.ui.AbstractSlider;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ScrollingTextField extends AbstractComponent
	{
		
		public var m:Sprite;
		public var textField:TextField;
		public var slider:AbstractSlider;
		
		protected var _copy:String;
		protected var _format:TextFormat;
		protected var _easing:Number = 1;
		
		public function ScrollingTextField()
		{
			super();
			slider.visible = false;
		}
		
		override public function addEvents():void
		{
			slider.addEventListener(PercentEvent.PERCENT, handleScroll );
		}
		
		private function handleScroll( event:PercentEvent ):void
		{
			var scrolldist:Number = textField.height - m.height;
			var ytarg:Number = scrolldist * event.percent * -1;
			textField.y += ( ytarg - textField.y ) * _easing;
		}
		
		public function set format( value:TextFormat ):void
		{
			_format = value;
		}
		
		public function set text( value:String ):void
		{
			if( _copy )
			{
				slider.reset();
				textField.y = 0;
			}
			
			_copy = value;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.text = _copy;
			textField.mask = m;
			
			checkScroller();
			if( _format )
			{
				textField.setTextFormat( _format );
			}	
		}
		
		/**
		 * setter for easing value, takes number greater then 0 to 1;
		 *   */
		
		public function set easing( value:Number ):void
		{
			_easing = value;
			if( _easing > 1 || _easing <= 0 )
			{
				_easing = 1;
			}
		}
		
		protected function checkScroller():void
		{
			
			if( textField.height > m.height )
			{
				slider.visible = true;
				slider.addEvents();
				textField.mask = m;
				addEvents();
			}
		}
		
		
		
		
		
		
	}
}