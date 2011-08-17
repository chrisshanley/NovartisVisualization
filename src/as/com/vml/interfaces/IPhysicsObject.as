package  com.vml.interfaces
{
	public interface IPhysicsObject
	{
		
		function update():void
		
		function get active():Boolean;
		function set active( value:Boolean ):void;
		
		
		function get vx():Number;
		function set vx( value:Number ):void
		
		function get vy():Number;
		function set vy( value:Number ):void
		
		function get angle():Number;
		function set angle( value:Number ):void
		
		function get spped():Number;
		function set speed( value:Number ):void
		
		
	}
}