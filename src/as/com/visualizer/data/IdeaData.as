package com.visualizer.data
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class IdeaData extends EventDispatcher
	{
		
		private var _idea:String;
		private var _id:int;
		private var _category:String;
		private var _comments:Number;
		private var _memberName:String;
		private var _date:Date;
		private var _votes:int;
		
		private var _url:String;
		public function IdeaData(idea:String, id:int, category:String , memberName:String, comments:Number, date:String , url:String, votes:int )
		{
			super( null );
			_memberName = memberName;
			_comments = comments;
			_category = category;
			_id = id;
			_idea = idea;
			createDate( date );
			_url = url;	
			_votes = votes;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get time():Number
		{
			return _date.getTime();
		}
		
		public function get stringDate():String
		{
			var date:Array = _date.toString().split( " " );
			return 	date[1].toString() + " " + date[2].toString();
		}
		
		public function get imagePath():String
		{
			//debug only
			/**
			 * todo - add in param on constructor for image path property
			*/
			return 	"http://ww2.brightidea.com/novartis/fpo-face.jpg";
		}
		
		private function createDate( value:String ):void
		{
			_date = new Date();
			var groups:Array = value.split( " " );
			var mdy:Array = groups[0].split( "/" );
			
			_date.setMonth(  mdy[0] );
			_date.setDate( mdy[1] );
			_date.setFullYear( mdy[2]  );	
			
			if( mdy[2] == 2010 )
			{
				_date.setFullYear( 2011 );
			}
			
		}
		
		public function get date():Date
		{
			return _date;
		}
		
		public function get memeberName( ):String
		{
			return _memberName;	
		}
		
		
		public function get comments():Number
		{
			return _comments;
		}
		
		public function get category():String
		{
			return _category;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get idea():String
		{
			return _idea;
		}
		
		public function get votes():int
		{
			return _votes;
		}
	}
}