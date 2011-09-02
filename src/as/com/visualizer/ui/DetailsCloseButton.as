package com.visualizer.ui
{
	import com.visualizer.events.VisualizerEvent;
	import com.vml.text.VMLTextField;
	import com.vml.ui.AbstractButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class DetailsCloseButton extends AbstractButton
	{
		
		private var _fill:Sprite;

		public function DetailsCloseButton( color:uint, format:String )
		{
			super();
			var xbutton:VMLTextField = new VMLTextField( "X", format );
			
			_fill = new Sprite();
			_fill.graphics.beginFill( color, 0.8 );
			_fill.graphics.lineStyle( 1, uint( xbutton.format.color ) );
			_fill.graphics.drawCircle( 0, 0, 10 );
			_fill.graphics.endFill();
			
			xbutton.x = xbutton.width  * - 0.5 - 0.5;
			xbutton.y = xbutton.height * - 0.5 - 0.5;
				
				
			addChild( _fill );
			addChild( xbutton );
		}
		
		override protected function handleClick(event:MouseEvent):void
		{
			dispatchEvent( new VisualizerEvent( VisualizerEvent.CLOSE_DETAILS , true ) );
		}
	}
}