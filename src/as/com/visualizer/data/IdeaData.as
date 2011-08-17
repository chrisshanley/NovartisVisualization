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
		
		
		public function IdeaData(idea:String, id:int, category:String , comments:Number )
		{
			super( null );
			_comments = comments;
			_category = category;
			_id = id;
			_idea = idea;
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