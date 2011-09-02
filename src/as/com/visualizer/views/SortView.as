package com.visualizer.views
{
	import com.visualizer.data.Category;
	import com.visualizer.events.VisualizerEvent;
	import com.visualizer.ui.CategoryButton;
	import com.vml.events.ButtonEvent;
	import com.vml.text.VMLTextField;
	import com.vml.views.AbstractView;
	
	public class SortView extends AbstractView
	{
		public static const format:String = "footer-italic";
		private var _model:Model;
		private var _current:VMLTextField;
		private var _buttons:Array;
		
		public function SortView()
		{
			super();
			_buttons = new Array();
			_model = Model.getInstance();
		}
		
		override public function init():void
		{
			var category:Category;
			var label:VMLTextField = new VMLTextField( _model.configData.display.categorysearcher,_model.configData.display.categorysearcher.@format ); 
			var i:int = 0;
			var button:CategoryButton;
			

			addChild( label );
			
			for each( category in _model.categories )
			{
				button = new CategoryButton(category.name, category.colors);
				button.x = label.width + 10 + ( i * (button.width + 10) );
				button.y = button.height * 0.5 + 5;
				button.addEventListener(ButtonEvent.ON_CLICK, handleButtonClick );
				addChild( button );
				_buttons.push( button );
				i++;
			}
			_current = new VMLTextField( "all", SortView.format );
			_current.x = button.x + 10;
			button.active = false;
			addChild( _current );
		}
		
		private function handleButtonClick( event:ButtonEvent ):void
		{
			var button:CategoryButton = event.target as CategoryButton;
			_model.category = button.category;
			_current.text = _model.configData..category.(attribute("id") == _model.category ).@name;
			setActive( button );
			dispatchEvent( new VisualizerEvent( VisualizerEvent.CATEGORY_SELECTED, true ) );
		}
		
		private function setActive( target:CategoryButton ):void
		{
			var button:CategoryButton;
			target.active = false;
			
			for each( button in _buttons )
			{
				if( button != target )
				{
					button.active = true;
				}
			}
		}

	}
}