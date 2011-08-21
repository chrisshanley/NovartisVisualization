package
{
	import com.visualizer.data.Category;
	import com.visualizer.data.FauxIdeas;
	import com.visualizer.data.IdeaData;
	import com.visualizer.data.IdeaGroup;
	import com.visualizer.events.VisualizerEvent;
	import com.vml.data.AbstractModel;
	import com.vml.events.PercentEvent;
	import com.vml.events.ViewEvent;
	import com.vml.net.AbstractService;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.osmf.layout.AbsoluteLayoutFacet;
	
	public class Model extends AbstractModel
	{
	
		public static const maxIdeaRadius:int = 15;
		public static const minIdeaRadius:int = 5;
		
		private static const totalRings:int = 7;
		private static const startRadius:int = 125;
		private static const maxRadius:int = 500;
		
		
		private static var _instance:Model;
		
		private var _ideas:Array;
		private var _category:String;
		private var _maxActivity:Number;
		private var _categories:Array;
		private var _ideaGroups:Array;
		
		public function Model( key:Key )
		{
			_maxActivity = 0;
		}
		
		public function initCategories():void
		{
			_categories = new Array();
			
			var child:XML;
			var category:Category;
			var colors:Array;
	
			for each( child in _configData.categories.children() )
			{
				colors = child.@colors.toString().split(",");
				_categories.push( category = new Category( child.@id, colors, child.@display ) );
			}
		}
		
		
		/**
		 * Method assuems the ideas come in sorted by date index 0 being earlies cronologically
		 * 
		 * */
		public function createIdeaGroups(  ):void
		{
			
			var group:Array;
			var ideasInGroup:int;
			var raduisIncrement:int = ( Model.maxRadius - Model.startRadius ) / Model.totalRings;
			var i:int = 0;
			var radius:int = Model.startRadius;
			var ideaGroup:IdeaGroup;
			var removePercent:Number;
			var drawRaduis:int  = Model.maxRadius;
			var idea:IdeaData;
			
			_ideaGroups = new Array();
			
				
			for( i; i < Model.totalRings -1; i ++ )
			{
				removePercent = ( radius / Model.maxRadius ); 
			
				ideasInGroup  = Math.ceil( removePercent * _ideas.length );
				group = _ideas.splice( 0, ideasInGroup ); 		
			
				for each( idea in group )
				{
					if( idea.comments > _maxActivity )
					{
						_maxActivity = idea.comments;
					}
				}	
				radius += raduisIncrement;
				drawRaduis -= raduisIncrement;
				ideaGroup = new IdeaGroup( group.reverse(), drawRaduis );
				ideaGroups.push( ideaGroup );
			}
		}
		
		public function retrieveCategoryByName( name:String ):Category
		{
			var category:Category;
			var requested:Category;
			for each( category in _categories )
			{
				if( category.name == name )
				{
					requested = category;
				}
			}
			return requested;
		}
		
		public function get maxActivity():Number
		{
			return _maxActivity;
		}
		
		public function get ideaGroups():Array
		{
			return _ideaGroups;	
		}
		
		public function get categories():Array 
		{
			return _categories;	
		}
		
		public static function getInstance():Model
		{
			if( !_instance )
			{
				_instance = new Model( new Key() );
			}
			return _instance;
		}
		
		
		
		
		
		public function get category( ):String
		{
			return _category;
		}
		
		public function set category( value:String ):void
		{
			_category = value;
		}
		
		
		
		
		
		public function requestRecords():void
		{
			const accessor:String = "base"
			var params:Object = new Object();
			var url:String = _configData.services.service.(attribute( "id" ) == accessor ).attribute( "url" );
			var service:AbstractService = new AbstractService();
			
			params.c = "72692330-542E-49B9-ACCE-FAC0953AE3C1";
			params.event = "visualization";
			params.key = "F78847FE28854688B6C7F9CD79F6691D";		
			service.addEventListener( Event.COMPLETE, recordRequestComplete );
			service.loadService( url, params );
		}
		
		private function recordRequestComplete( event:Event ):void
		{
			var service:AbstractService = event.target as AbstractService;
			var child:XML;
			var idea:IdeaData;
			var i:int = 0;
			_ideas = new Array();
			
			trace( this, service.xml );
			
			for each( child in service.xml.children() )
			{
				idea = new IdeaData( child.TITLE, i, child.CATEGORY_ID, child.COMMENTS );
				_ideas.push( idea );
				i++
			}
			createIdeaGroups(  );
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function getRecordsByDate( dateIndex:int ):void
		{
			// code for webservice , debug only
			handleRecordsComplete( null );
		}
		
		private function handleRecordsComplete( event:Event ):void
		{
			dispatchEvent( new  VisualizerEvent( VisualizerEvent.IDEA_DATA_LOADED )  );
		}
		
		
		
	}
}

final internal class Key 
{
	function Key(){}
}