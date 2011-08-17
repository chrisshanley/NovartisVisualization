package com.visualizer.views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quart;
	import com.visualizer.ui.CloseButton;
	import com.vml.events.ButtonEvent;
	import com.vml.text.VMLTextField;
	import com.vml.utils.SpriteFactory;
	import com.vml.views.AbstractView;
	
	import flash.display.Sprite;
	
	import org.osmf.layout.PaddingLayoutFacet;
	
	public class KeyView extends AbstractView
	{
		
		private static const width:int = 230;
		private var _model:Model;
		private var _fill:Sprite;
		private var _content:Sprite;
		private var _closeButton:CloseButton;
		
		public function KeyView( )
		{
			super();
			_content = new Sprite();
			_model = Model.getInstance();
			
			_fill = SpriteFactory.getRectSprite( KeyView.width, 10, 0x8d8375 );
			_fill.alpha = 0.75;
			
			_closeButton = new CloseButton();
			_closeButton.label = _model.configData.display.closebutton;
			_closeButton.x = 230 - ( _closeButton.width + 10 );
			_closeButton.addEventListener(ButtonEvent.ON_CLICK, handleCloseClick );
			
			
			addChild( _fill );
			addChild( _closeButton );
			
		}
		
		public function show():void
		{
			TweenLite.to( mask, 0.7, { y:0, ease:Quart.easeInOut } );	
		}
		
		public function hide():void
		{
			TweenLite.to( mask, 0.7, { y:height * -1, ease:Quart.easeInOut } );
		}
		
		private function handleCloseClick( event:ButtonEvent ):void
		{
			dispatchEvent( event.clone() );
		}
		
		override public function set height(value:Number):void
		{
			_fill.height = value;
			_closeButton.y = _fill.height - ( _closeButton.height + 10 );
			
			mask = SpriteFactory.getRectSprite( width, height );
			mask.y = height * -1;
			addChild( mask );
		}
		
		public function get content( ):Sprite
		{
			return _content;
		}
		
		override public function init():void
		{
			var txt:VMLTextField;
			var child:XML;
			var i:int = 0;
			const padding:int = 20;
			for each( child in _model.configData.display.key.children() )
			{
				txt = new VMLTextField( child.toString(), child.@format );
				txt.y = i * ( txt.height + padding );
				i ++;
				_content.addChild( txt );
			}
			addChild( _content );
		}
		
		
	}
}