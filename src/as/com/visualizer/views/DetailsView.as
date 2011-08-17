package com.visualizer.views
{
	import com.greensock.TweenLite;
	import com.visualizer.data.Category;
	import com.visualizer.events.VisualizerEvent;
	import com.visualizer.states.DetailsDisplayState;
	import com.visualizer.ui.ViewButton;
	import com.vml.net.AbstractDisplayLoader;
	import com.vml.text.VMLTextField;
	import com.vml.utils.SpriteFactory;
	import com.vml.views.AbstractView;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	import org.osmf.net.dynamicstreaming.INetStreamMetrics;
	
	public class DetailsView extends AbstractView
	{
		
		public static const OVER_STATE:String = "overState";
		public static const CLICK_STATE:String = "clickState";
		
		private static const padding:int = 10;
		private static const textWidth:int = 200;
		
		private var _image:Sprite;
		private var _teaser:VMLTextField;
		private var _details:VMLTextField;
		private var _footer:VMLTextField;
		private var _fill:Sprite;
		private var _colors:Array;
		private var _viewButton:ViewButton;
		private var _contentContainer:Sprite;
		private var _state:String;
		private var _model:Model;
		
		public function DetailsView()
		{
			super();
			_model = Model.getInstance();
			var faux:FakeData = new FakeData();
			data = faux.data;	
		}
		
		override public function init():void
		{
			_contentContainer = new Sprite();
			addChild( _contentContainer );
			mouseEnabled = false;
			mouseChildren = false;
			var textHelper:GlowFilter = new GlowFilter(0x000000, 0.4, 2, 2 );
			
			_details = new VMLTextField( _data.details, _data.details.@format );
			_details.width = 200;
			_details.wordWrap = true;
			_details.name = "details"
			_details.scaleX = _details.scaleY = 0.85;
			_details.filters = [ textHelper ];
			_contentContainer.addChild( _details );
			
			_viewButton = new ViewButton();
			_viewButton.label = _model.configData.display.viewButton;
			_viewButton.x = _details.x + _details.width - ( _viewButton.width );
			_viewButton.y = _details.y + _details.height +  DetailsView.padding;
			_viewButton.filters = [ textHelper ];
			_viewButton.alpha = 0;
			_viewButton.visible = false;
			_contentContainer.addChild( _viewButton );
			
			
			_footer = new VMLTextField( _data.footer, _data.footer.@format );
			_footer.x = DetailsView.padding,
			_footer.y = _viewButton.height + _viewButton.y + DetailsView.padding;
			_footer.alpha = 0;
			_footer.filters = [ textHelper ];
			_contentContainer.addChild( _footer );
			
			var loader:AbstractDisplayLoader = new AbstractDisplayLoader();
			loader.addEventListener( Event.COMPLETE, handleImageLoaded );
			loader.load( _data.@image );
		}
		
		private function handleImageLoaded( event:Event ):void
		{

			var loader:AbstractDisplayLoader = event.target as AbstractDisplayLoader;
			var bm:Bitmap = loader.content as Bitmap;
			bm.x = bm.width * -0.5;
			bm.y = bm.height * -0.5;
			bm.mask = SpriteFactory.getCircleSprite( bm.height * 0.5, 0 );
	
			_image = new Sprite();
			_image.addChild( SpriteFactory.getCircleSprite(  bm.height * 0.5 + 2, _colors[ 0 ] ) );
			_image.addChild( bm.mask );
			_image.addChild( bm )
			_image.scaleX = _image.scaleY = 0;
			_contentContainer.addChild( _image );
		}
		
		private function updateDisplay():void
		{
			_details.x = DetailsView.padding * 0.5;
			_details.y = DetailsView.padding * 0.5;
		}
		
		public function set colors( value:Array ):void
		{
			var color:uint;
			var array:Array = new Array(  );
			for each( color in value )
			{
				array.push( color );
			}
			array.reverse();
			array.push( array[0] );
			
			_colors = value;
			_fill = new Sprite();
			
			var fillType:String = GradientType.LINEAR;
			var alphas:Array = [1,1, 1];
			var ratios:Array = [1, 127, 255]; 
			var matr:Matrix = new Matrix();
			var spreadMethod:String = SpreadMethod.PAD;
			
			matr.createGradientBox(_details.width + DetailsView.padding, _details.height + DetailsView.padding, Math.PI * 0.5, 0, 0);
			
			_fill.graphics.beginGradientFill(fillType, array, alphas, ratios, matr, spreadMethod);  
			_fill.graphics.drawRect(0,0, _details.width+ DetailsView.padding, _details.height + DetailsView.padding);
			_fill.graphics.endFill();
			_fill.mask = new DetailsFillMask();
			_fill.mask.width = _fill.width;
			_fill.mask.height = _fill.height;
			_fill.addChild( _fill.mask );
			_fill.alpha = 0.85;
			
			addChildAt( _fill, 0 );
			updateDisplay();
		}
		
		public function set state( value:String ):void
		{
			_state = value;
			switch( _state )
			{
				case DetailsView.OVER_STATE :
					break;
				case DetailsView.CLICK_STATE :
					animateClickState();
					break;
			}
		}
		
		override public function set data( value:XMLList ):void
		{
			_data = value;
		}
		
		private function animateClickState():void
		{  
			
			_viewButton.visible = true;
			addEventListener( MouseEvent.MOUSE_OUT, handleMouseOut );
			mouseEnabled = true;
			mouseChildren = true;
			TweenLite.to( _details,     0.7, { scaleX:1, scaleY:1 } );
			TweenLite.to( _image,       0.7, { scaleX:1, scaleY:1, onUpdate:onAnimateClick } );
			TweenLite.to( _fill ,       0.7, { alpha:1,  height:_contentContainer.height + DetailsView.padding } );
			TweenLite.to( _footer ,     0.7, { alpha:1,  delay:0.7 } );
			TweenLite.to( _viewButton,  0.7, { alpha:1,  delay:0.7 } );
		} 
		
		private function handleMouseOut( event:MouseEvent ):void
		{
		}
		
		private function animateOverState():void
		{
			
		}
		
		public function onAnimateClick():void
		{
			_details.x = _image.width * 0.5 + DetailsView.padding;
			_fill.width = _details.x + _details.width + DetailsView.padding * 0.5;
			_viewButton.x = _details.x + _details.width - ( _viewButton.width + DetailsView.padding );
			dispatchEvent( new VisualizerEvent( VisualizerEvent.DETAILS_UPDATE ) );
		}
		
		private function handleLink():void
		{
			
		}
		
		public function close():void
		{
			TweenLite.to( this, 0.7, { alpha:0, onComplete:super.notifyAnimateOutComplete } );			
		}
		
		override public function get height():Number 
		{
			return _fill.height;
		}
		
		override public function destroy():void
		{
				
		}
		
 
	}
}

final internal class FakeData
{
	private  var _data:XMLList;
	function FakeData()
	{
		_data = new XMLList( <details image="/imgs/fpo-face.jpg" url="http://google.com">
								<details format="details"><![CDATA[The most innovative companies in the world use Brightidea software.]]></details>
								<footer  format="details-footer"><![CDATA[Submitted Jul 01 by Mark Christensen<br>10 votes  |  55 comments  |  Subcategory]]></footer>
							</details>);
			
	}
	
	public function get data():XMLList
	{
		return _data;	
	}
	
	
}