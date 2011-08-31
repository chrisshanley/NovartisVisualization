package com.visualizer.views
{
	import com.vml.views.AbstractView;
	
	public class SummaryView extends AbstractView
	{
		private var _model:Model;
		public function SummaryView()
		{
			super();
			_model = Model.getInstance();
		}
		
		override public function init():void
		{
			var list:Array = [
								{title:"ideas",    value:_model.ideas.length},
								{title:"comments", value:_model.comments},
								{title:"users",    value:_model.users}
						     ];
			var obj:Object;
			var view:StatView;
			var ypos:Number = 0;
			
			for each( obj in list )
			{
				view = new StatView( obj );
				view.y = ypos;
				ypos += view.height + 15;

				addChild( view );
			}
		}
		
		
		
		
	}
}