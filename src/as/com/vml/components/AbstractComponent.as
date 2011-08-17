package  com.vml.components
{
	import com.vml.interfaces.IComponent;
	
	import flash.display.Sprite;

	
	public class AbstractComponent extends Sprite implements IComponent
	{
		
		protected var _id:int;
		protected var _active:Boolean;
		
		public function AbstractComponent()
		{
			super();
		}
		
		public function init():void
		{
			
		}
		
		public function show():void
		{
		}
		
		public function hide():void
		{
		}
		
		public function addEvents():void
		{
			
		}
		
		public function removeEvents():void
		{
			
		}
		
		public function destroy():void
		{
			
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
		
		public function get active():Boolean
		{
			return _active;
		}
		
		public function set active(value:Boolean):void
		{
			_active = value;
		}
		
	
		
		
		
	}
}