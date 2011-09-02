package com.visualizer.views
{
	import com.visualizer.data.Category;
	import com.visualizer.data.IdeaData;
	import com.vml.text.VMLTextField;
	import com.vml.utils.MathUtils;
	import com.vml.utils.SpriteFactory;
	import com.vml.views.AbstractView;
	
	import flash.display.Sprite;
	
	public class Ring extends AbstractView
	{
		private static const dateFormat:String = "date-format";
		
		private var _radius:int;
		private var _ideas:Array;
		private var _views:Array;
		private var _model:Model;
		
		public function Ring(radius:int, ideas:Array )
		{
			super();
			_views = new Array();
			_model = Model.getInstance();
			_radius = radius;
			_ideas = ideas;
		}
		
		override public function init():void
		{
			var view:IdeaView;
			var i:int = 0;
			var anglePer:Number = ( Math.PI ) / ( _ideas.length - 1 );
			var angle:Number = ( _ideas.length > 1 ) ? ( Math.PI * 0.5 ) :  Math.PI * Math.random();
			var size:Number;
			var data:IdeaData;
			
			
			var line:Sprite = new Sprite();
			line.graphics.beginFill( 0x000000, 0);
			if( _id % 2 == 0 || _id == 0 || _id == _model.ideaGroups.length -1)
			{
				line.graphics.lineStyle( 2, 0xe2e2d9, 1 );	
			}
			else
			{
				line.graphics.lineStyle( 2, 0xe2e2d9 , 0 );				
			}
			line.graphics.drawCircle( 0 , 0 , _radius - 0.5 );
			line.graphics.endFill();
			line.mouseChildren = line.mouseEnabled = false;
			
			
			
			for( i; i < _ideas.length; i ++ )
			{
				data = _ideas[ i ];
				size = ( ( data.comments + 1 ) / ( _model.maxActivity + 1 ) ) * Model.maxIdeaRadius;
				view = new IdeaView( size, _model.retrieveCategoryByName( data.category ).colors, data.category );
				view.x = Math.sin( angle  ) * _radius;
				view.y = Math.cos( angle * -1 ) * _radius;
				view.id = data.id;
				view.name = this.name + "_item_"+i.toString();
				angle += anglePer;
				addChildAt( view, 0 );
				_views.push( view );
			}
			addChildAt( line, 0 );
		}
		
		public function addDate( value:String ):void
		{
			var view:Sprite = SpriteFactory.getCircleSprite( 5, 0x525252 );
			var data:IdeaData = _model.getIdeaById( _views[0].id );
			var angle:Number = Math.PI;
			var label:VMLTextField = new VMLTextField( value, Ring.dateFormat );
		
			view.x = Math.sin( angle  ) * _radius;
			view.y = Math.cos( angle * -1 ) * _radius;
			
			label.x = view.x + 8;
			label.y = view.y + 10;
			label.rotation = 90;
			
			addChild( view );
			addChild( label );
		}
		
		
		public function sort( type:String ):void
		{
			var ideaView:IdeaView;
			var all:String = "all";
			for each( ideaView in _views )
			{
				trace( this, ideaView.category );
				if( ideaView.category != type && type != all )
				{
					ideaView.hide();
				}
				else if( type == all )
				{
					ideaView.show();
				}
				else
				{
					ideaView.show();
				}
			}
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function get views():Array
		{
			return _views;
		}
	}
}