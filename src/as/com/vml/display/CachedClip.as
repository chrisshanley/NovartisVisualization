package com.vml.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public class CachedClip extends Sprite
	{
		
		protected var _cache:Array;
		protected var _currentFrame:int;
		protected var _totalFrames:int;
		protected var _display:Bitmap;		
		protected var _targetFrame:int;
		
		public function CachedClip( movieClip:MovieClip = null)
		{
			super();
			_cache = new Array();
			_currentFrame = 0;
			_targetFrame = -1;
		}
		
		public function cacheMC( mc:MovieClip, playForward:Boolean = true ):void
		{
			var startFrame:uint = ( playForward == true ) ? 1 : mc.totalFrames;
			var i:int = startFrame;
			var bmd:BitmapData;
			
			// cache it moving forward
			if ( startFrame == 1 ) {
				for( i; i < mc.totalFrames; i++ )
				{
					mc.gotoAndStop( i );
					bmd = new BitmapData( mc.width, mc.height, true, 0 );
					bmd.lock();
					bmd.draw( mc );
					bmd.unlock();
					_cache.push( bmd );
				}
			// cache it moving backward
			} else {
				for( i; i >= 1; i-- )
				{
					mc.gotoAndStop( i );
					bmd = new BitmapData( mc.width, mc.height, true, 0 );
					bmd.lock();
					bmd.draw( mc );
					bmd.unlock();
					_cache.push( bmd );
				}
			}
		}
		
		public function processMC():void
		{
			_display = new Bitmap( _cache[ _currentFrame ] );
			_totalFrames = _cache.length;
			addChild( _display );
			dispatchEvent( new Event( Event.COMPLETE ));
		}
		
		public function play():void
		{
			_targetFrame = _totalFrames - 1;
			addEventListener( Event.ENTER_FRAME, handlePlay );
		}
		
		protected function handlePlay( event:Event ):void
		{
			_currentFrame = ( _currentFrame == _totalFrames - 1 ) ? 0 : _currentFrame + 1;
			updateView();
		
			if( _currentFrame == _targetFrame )
			{
				removeEventListener( Event.ENTER_FRAME, handlePlay );
				_targetFrame = -1;
				dispatchEvent( new Event( Event.COMPLETE ));
			}
		}
		
		
		public function stop():void
		{
			removeEventListener( Event.ENTER_FRAME, handleRewind );
			removeEventListener( Event.ENTER_FRAME, handlePlay );
		}
		
		public function rewind():void
		{
			addEventListener( Event.ENTER_FRAME, handleRewind );
		}
		
		protected function handleRewind( event:Event ):void
		{
			_currentFrame = ( _currentFrame == 0 ) ? _totalFrames -1 : _currentFrame - 1;
			updateView();	
			
			if( _currentFrame == _targetFrame )
			{
				removeEventListener( Event.ENTER_FRAME, handleRewind );
				_targetFrame = -1;
				dispatchEvent( new Event( Event.COMPLETE ));
			}
		}
		
		
		public function playToFrame( frame:int ):void
		{
			_targetFrame = frame;
			if( _currentFrame < _targetFrame )
			{
				play();
			}
			else
			{
				rewind();
			}
		}
		
		public function gotoAndStop( frame:int ):void
		{
			_currentFrame = frame;
			updateView();
		}
		
	
		
		protected function updateView():void
		{
			_display.bitmapData = _cache[ _currentFrame ];
		}
		
		public function set frame( value:uint ):void
		{
			_currentFrame = value;
			if(  _currentFrame  > _totalFrames )
			{
				_currentFrame = _totalFrames;
			}
			updateView();
		}
		
		public function destroy():void
		{
			
		}	
		
	}
}