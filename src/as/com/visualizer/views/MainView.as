package com.visualizer.views
{
	import com.visualizer.ui.DateSlider;
	import com.visualizer.ui.DualDateSlider;
	import com.visualizer.ui.KeyButton;
	import com.visualizer.ui.PostButton;
	import com.vml.events.ButtonEvent;
	import com.vml.views.AbstractView;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import org.osmf.metadata.KeyValueFacet;
	
	public class MainView extends AbstractView
	{
		
		private var _postButton:PostButton;
		private var _keyButton:KeyButton;
		
		private var _model:Model;
		private var _keyView:KeyView;
		private var _footerFill:FootFill;
		private var _sortView:SortView;
		private var _dateView:DualDateSlider;
		
		public function MainView()
		{
			super();
			
			_model = Model.getInstance();
			
			addEventListener(Event.ADDED_TO_STAGE, handleOnStage );
		}
		
		private function handleOnStage( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleOnStage );
			_postButton = new PostButton();
			_postButton.addEventListener(ButtonEvent.ON_CLICK, handlePostClick );
			_postButton.x = stage.stageWidth - ( _postButton.width + 20 );
			_postButton.y = 45;

			_postButton.label = _model.configData.display.postbutton;
			
			
			_keyButton = new KeyButton();
			_keyButton.addEventListener(ButtonEvent.ON_CLICK, handleShowKey );
			_keyButton.label = _model.configData.display.keybutton;
			_keyButton.x = stage.stageWidth - ( _keyButton.width + 20 );
			_keyButton.y = 5;
			
			_keyView = new KeyView();
			_keyView.init();
			_keyView.x = stage.stageWidth  - _keyView.width;
			_keyView.y = _keyButton.y + _keyButton.height + 10;
			_keyView.height = stage.stageHeight - ( _keyButton.y + _keyButton.height + 5 );
			_keyView.content.x = _postButton.x - _keyView.x;
			_keyView.content.y = ( _postButton.y + _postButton.height + 20 ) - _keyView.y;
			
			_footerFill = new FootFill();
			_footerFill.y = stage.stageHeight - (_footerFill.height -1);
			
			_sortView = new SortView();
			_sortView.init();
			_sortView.x = 15;
			_sortView.y = _footerFill.y + 5;
			
			_dateView = new DualDateSlider();
			
			addChild( _footerFill );
			addChild( _keyView );
			addChild( _postButton );
			addChild( _keyButton );
			addChild( _sortView );
			addChild( _dateView );
			
			_dateView.x = stage.stageWidth - ( _dateView.width + 15 );
			_dateView.y = _footerFill.y + 5;
		}
		
		private function handlePostClick( event:ButtonEvent ):void
		{
			
		}
		
		public function get footerHeight():Number
		{
			return _footerFill.height;
		}
		
		private function handleShowKey( event:ButtonEvent ):void
		{
			_keyView.addEventListener( ButtonEvent.ON_CLICK, handleCloseKey );
			_keyView.show();
		}
		
		private function handleCloseKey( event:ButtonEvent ):void
		{
			_keyView.removeEventListener( ButtonEvent.ON_CLICK, handleCloseKey );
			_keyView.hide();
		}
		
		private function handleHideKey( event:ButtonEvent ):void
		{
		
		}
		
		public function enableSlider():void
		{
			_dateView.mouseEnabled = true;
			_dateView.mouseChildren = true;
		}
		
	}
}