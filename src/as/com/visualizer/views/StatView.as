package com.visualizer.views
{
	import com.vml.text.VMLTextField;
	import com.vml.views.AbstractView;
	
	import flash.display.Sprite;
	
	public class StatView extends AbstractView
	{
		public function StatView( obj:Object )
		{
			super();
			
			trace( this, obj.title, obj.value );
			var prop:VMLTextField = new VMLTextField( obj.title , "summary-property" );
			var value:VMLTextField = new VMLTextField( obj.value , "summary-value" );
			var color:uint = 0xe6e6de;
			var line:Sprite = new Sprite();
			
			prop.y = value.height;
			line.graphics.lineStyle(1, 0xe6e6de );
			line.graphics.lineTo( 50 , 0 );
			line.y = prop.y + prop.height + 15;
			
			value.x = value.width * -0.5;
			prop.x  = prop.width * -0.5;
			line.x  = line.width * -0.5;
			
					
			 addChild( value );
			 addChild( prop );
			 addChild( line );
		}
	}
}