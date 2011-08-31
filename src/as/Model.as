package
{
	import com.greensock.easing.Sine;
	import com.visualizer.data.Category;
	import com.visualizer.data.FauxIdeas;
	import com.visualizer.data.IdeaData;
	import com.visualizer.data.IdeaGroup;
	import com.visualizer.data.RingData;
	import com.visualizer.events.VisualizerEvent;
	import com.visualizer.views.Ring;
	import com.vml.data.AbstractModel;
	import com.vml.events.PercentEvent;
	import com.vml.events.ViewEvent;
	import com.vml.net.AbstractService;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import flashx.textLayout.events.DamageEvent;
	

	
	public class Model extends AbstractModel
	{
	
		public static const maxIdeaRadius:int = 7;
		public static const minIdeaRadius:int = 2;
		
		private static const startRadius:int = 125;
		public static const maxRadius:int = 450;
		
		private static var totalRings:int;
		private static var _instance:Model;
		
		
		private var _requestedDates:Array;
		private var _startDate:Date;
		private var _endDate:Date;
		
		private var _startDateToString:String;
		private var _endDateToString:String;
		
		private var _ideas:Array;
		private var _category:String;
		private var _maxActivity:Number;
		private var _categories:Array;
		private var _ideaGroups:Array;
		private var _display:Array;

		
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
		private function createIdeaGroups( a:Array ):void
		{
			
			var data:IdeaData;
			var dayCount:int = 0;
			var radius:int;
			var currentDate:Date = a[0].date;
			var ideas:Array;
			var group:IdeaGroup;
			var i:int = 0;	
			var startIndex:int = 0;
			var endIndex:int = 0;
			
			_ideaGroups = null;
			_ideaGroups = new Array();
			
			for( i; i < a.length; i++ )
			{
				data = a[ i ];
				if( data.date.getTime() > currentDate.getTime() + TimeUtils.getOneDayAsMiliseconds() * 3 )
				{
					endIndex = a.indexOf( data );
					ideas = a.slice( startIndex,  endIndex );
					startIndex = endIndex;
					currentDate = data.date;
				
					_ideaGroups.push( new IdeaGroup( ideas ) );
				}
				
				if( data.comments > _maxActivity )
				{
					_maxActivity = data.comments;
				}
			}
			
			var anglePer:Number = Math.PI * 0.5 / _ideaGroups.length;
			var percent:Number = 0;
			var radian:Number = 0;
			
			i = 1;
			for each( group in _ideaGroups )
			{
				percent = i/_ideaGroups.length;
				radius = Model.startRadius +  percent * ( Model.maxRadius - Model.startRadius );
				group.radius = radius;	
				i++;
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
			const accessor:String 		= "base"
			const url:String        	= _configData.services.service.(attribute( "id" ) == accessor ).attribute( "url" );
			var params:Object     		= new Object();
			var service:AbstractService = new AbstractService();
			
			params.c     = "72692330-542E-49B9-ACCE-FAC0953AE3C1";
			params.event = "visualization";
			params.key   = "F78847FE28854688B6C7F9CD79F6691D";		
			
			service.postVars = {q:unescape("ORDER BY date DESC")};
			service.addEventListener( Event.COMPLETE, recordRequestComplete );

			service.loadService( url, params );
		}
		
		public function requstRecordsByDates( dates:Array ):void
		{
			_requestedDates = dates;
			_display = _ideas.filter( filterByDate );
			if( _display.length == 0 )
			{
				return;
			}
			createIdeaGroups( _display );
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function get displayDates( ):Array
		{
			return _requestedDates;
		}
		
		
		private function recordRequestComplete( event:Event ):void
		{
			var service:AbstractService = event.target as AbstractService;
			var child:XML;
			var idea:IdeaData;
			var i:int = 0;
			var percent:Number;
			var divisable:int = 10;
			var radian:Number;
			
			_ideas = null;
			_ideas = new Array();
			
			
			for each( child in service.xml.children() )
			{
				trace( this, child );	
				idea = new IdeaData( child.TITLE, i, child.CATEGORY_ID, child.MEMBER_NAME, child.COMMENTS, child.DATE, child.URL, child.SCORE );
				_ideas.push( idea );
				i++
			}
			
			_ideas = _ideas.sortOn("time", Array.NUMERIC );
			
			if( !_startDate )
			{
				setAppDates();
				_requestedDates = [ _startDate, _endDate ];
				_display = _ideas.filter( filterByDate );
			}
			createIdeaGroups( _ideas );
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		private function setAppDates():void
		{
			_startDate = _ideas[0].date;
			_endDate   = _ideas[ _ideas.length - 1 ].date;
		}
			
		private function filterByDate( item:IdeaData, index:int, array:Array ):Boolean
		{
			var startDate:Date = _requestedDates[0];
			var endDate:Date   = _requestedDates[1];
			return ( item.date.getTime() >=  startDate.getTime() && item.date.getTime() <= endDate.getTime() ) ? true : false;
		}
	
		
		
		public function get display():Array
		{
			return _display;
		}
		
		public function get startDate( ):Date 
		{
			return _startDate;
		}
		
		public function get endDate( ):Date
		{
			return _endDate;
		}
		
		public function get displayEndDate():String
		{
			var date:Array = _requestedDates[1].toString().split( " " );
			return date[1] +" "+date[2]+ " ";
		}
		
		public function get displayStartDate():String
		{	
			var date:Array = _requestedDates[0].toString().split( " " );
		
			return date[1] +" "+date[2]+ " ";	
		}
		
		public function getIdeaById( value:int ):IdeaData
		{
			
			var data:IdeaData;
			var selected:IdeaData;
			for each( data in _ideas )
			{
				if( data.id == value )
				{
					selected = data;
					break;
				}
			}
			return data;
		}
		
		
		private function debug( array:Array , prop:String ): void
		{
			var idea:IdeaData;
			for each( idea in array )
			{
				trace( this, " debug prop : ", prop, idea[prop] );
			}
		}
		
	}
}

final internal class TimeUtils
{
	
	public function TimeUtils()
	{
	
	}
	
	
	
	public static function getOneDayAsMiliseconds():Number
	{
		return 1000 * 60 * 60 * 24;
	}
}

final internal class Key 
{
	function Key(){}
}





/*
 * 

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
var cue:int  = 0;  
var p:Number;
var ideasPer:Number = _ideas.length / Model.totalRings;
_ideaGroups = new Array();

for( i; i < Model.totalRings; i ++ )
{
p = ( ( 1+ i ) / Model.totalRings ) * 2;

ideasInGroup  = ideasPer * p 
cue += Math.ceil( ideasInGroup )
//	ideasInGroup  = Math.ceil( removePercent * _ideas.length )


//	group = _ideas.splice( 0, ideasInGroup ); 		


/*for each( idea in group )
{
if( idea.comments > _maxActivity )
{
_maxActivity = idea.comments;
}
}	
ideaGroup = new IdeaGroup( group.reverse(), drawRaduis );
drawRaduis -= raduisIncrement;
ideaGroups.push( ideaGroup );
radius += raduisIncrement;
}
}
*/

