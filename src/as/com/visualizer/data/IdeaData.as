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
		
		public function IdeaData(idea:String, id:int, category:String , memberName:String, comments:Number, date:String )
		{
			super( null );
			_memberName = memberName;
			_comments = comments;
			_category = category;
			_id = id;
			_idea = idea;
			
			createDate( date );
		}
		
		private function createDate( value:String ):void
		{
			_date = new Date();
			var groups:Array = value.split( " " );
			var mdy:Array = groups[0].split( "/" );
			_date.setMonth(  mdy[0] );
			_date.setDate( mdy[1] );
			_date.setFullYear( mdy[2]  );
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
	}
}