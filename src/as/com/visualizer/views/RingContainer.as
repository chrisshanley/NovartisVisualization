package com.visualizer.views
{
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	import com.visualizer.data.IdeaData;
	import com.visualizer.data.IdeaGroup;
	import com.vml.utils.SpriteFactory;
	import com.vml.views.AbstractView;
	
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.osmf.metadata.IFacet;
	
	public class RingContainer extends AbstractView
	{
		private var _displayReady:Boolean;
		private var _model:Model;
		private var _rings:Array;
		
		public function RingContainer()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE , handleOnStage );
			_model = Model.getInstance();
			_displayReady = false;
		}
		
		private function handleOnStage( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleOnStage );
			init();
		}
		
		override public function init():void
		{
			var ring:Ring;
			var i:int = 0;
			var group:IdeaGroup;
			
			if( _rings )
			{
				clearRings();
				return;
			}
			
			_rings = new Array();
			var time:Number = 1;
			var delay:Number = 0.1;
			
			for( i; i < _model.ideaGroups.length; i ++ )
			{
				group = _model.ideaGroups[ i ];
				ring = new Ring( group.radius, group.ideas );
				ring.id = i;
				ring.name = "ring_"+i.toString();
				ring.init();
				ring.x = stage.stageWidth * 0.5;
				ring.y = stage.stageHeight;
				addChild( ring );	
				
				TweenLite.from( ring, time, { rotation:-180, scaleX:0, scaleY:0 , delay:i * delay } );
				_rings.push( ring );
			}
						
			setDates();
			initTopTen();
			if( !_displayReady )
			{
				TweenLite.delayedCall( time + delay, updateView );	
				_displayReady = true;
			}
			
			dispatchEvent( new Event( Event.COMPLETE ));
		}
		
		private function setDates():void
		{
			_rings[0].addDate( "July 1" );
			_rings[ _rings.length - 1].addDate( "June 1" );
		
		}
		
		private function updateView(  ):void
		{
			drawBackground();
			drawLine();
		}
		
		private function initTopTen():void
		{
			var view:IdeaView;
			var ring:Ring;
			var temp:Array = new Array();
			for each( ring in _rings )
			{
				for each( view in ring.views )
				{
					temp.push( view );
				}
			}
			
			temp.sortOn( "size", Array.NUMERIC );
			temp.reverse();
			var i:int = 0;
			var max:int = 10;
			for( i ; i < max ; i ++ )
			{
				view = temp[i];
				if( view )
				{
					view.topTen = true;
				}
			}
			temp = null;
		}
		
		private function drawBackground():void
		{
			var bg:Sprite = this.getChildByName( "bg" ) as Sprite;
			if( bg )
			{
				bg.graphics.clear();
				removeChild( bg );
				bg = null;
			}
	
			var colors:Array  = [0xebebe8, 0xf7f7ea];
			var radius:Number =  height * 0.5 - 7;
			
			bg = SpriteFactory.getGradientCircleSprite( radius, colors, 0 );
			addChildAt( bg, 0 ) as Sprite;
			bg.name = "bg";
			bg.x = stage.stageWidth * 0.5;
			bg.y = stage.stageHeight;
			
			TweenLite.from( bg, 1, { scaleX:0, scaleY:0 } );
		}			
		
		private function drawLine():void
		{
			var line:Sprite = getChildByName( "line" ) as Sprite;
			if( line )
			{
				line.graphics.clear();
				removeChild( line );
				line = null;
			}
			line = new Sprite();
			
			var ring:Ring;
			var indicator:Sprite;
			line.graphics.lineStyle( 2, 0xe2e2d9 );
			line.graphics.lineTo(0,   height * 0.5 - 7  );
			line.name = "line";
			line.x = stage.stageWidth * 0.5;
			line.y = stage.stageHeight;
			
			for each( ring in _rings )
			{
				indicator = SpriteFactory.getCircleSprite( 3, 0xff0000 );
				indicator.y = ring.radius;
				indicator.visible = false
				line.addChild( indicator );
			}
			
			addChildAt( line,1  );
			addEventListener( Event.ENTER_FRAME, animateLine );
		}
		
		private function animateLine( event:Event ):void
		{
			var ring:Ring;
			var view:IdeaView;
			var line:Sprite = getChildByName( "line" ) as Sprite;
			var hit:Sprite;
			var i:int = 0;
			var viewBounds:Rectangle; 
			var hitBounds:Rectangle;
			line.rotation += 1;
			
		
			var numRings:int= 0;
			var dots:int = 0;
			for each( ring in _rings )
			{
				for each( view in ring.views )
				{
					viewBounds = view.getBounds( this );
					if( checkBoundCollision( viewBounds ) )
					{
						if( view.topTen )
						{
							view.indicate();
						}
					}	
				}
			}
		}
		
		private function checkBoundCollision( rect:Rectangle ):Boolean
		{
			var isColliding:Boolean = false;
			var line:Sprite = getChildByName( "line" ) as Sprite;
			var i:int = 0;
			var hitBounds:Rectangle;
			var hit:Sprite;
			for( i; i < line.numChildren; i++ )
			{
				hit = line.getChildAt( i ) as Sprite;	
				hitBounds = hit.getBounds( this )
				if( hitBounds.intersects( rect ) )
				{
					isColliding = true;
				}
			}
			return isColliding;
		}
		
	
		
		private function clearRings():void
		{
			var ring:Ring;
			var i:int = 0;
			var time:Number = 1;
			var delay:Number = 0.1;
			_rings = _rings.reverse()
			for each( ring in _rings )
			{
				TweenLite.to( ring, time, { rotation:180, scaleX:0, scaleY:0 , delay:i * delay, onComplete:removeChild, onCompleteParams:[ring] } );
				i++;
			}
			TweenLite.delayedCall(  time + delay, init );
			_rings = null;
		}
		
		public function sort( type:String ):void
		{
			var ring:Ring;
			for each( ring in _rings )
			{
				ring.sort( type );
			}
		}
		
		
	}
}