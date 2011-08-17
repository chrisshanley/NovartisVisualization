package  com.vml.font
{
	import com.vml.core.VMLObject;
	
	import flash.text.TextFormat;
	
	
	public class FormatController
	{
		private static const ERROR:String = "The format data is not set in the XML or init method has not been called. There are no formats in the _formats object"
		private static var _instance:FormatController;
		
		private var _formats:VMLObject;
		
		public function FormatController( key:Key )
		{
			_formats = new VMLObject();	
		}
		
		public function init( xml:XMLList ):void
		{
			
			var child:XML;
			var grandChild:XML;
			var format:TextFormat;
			for each( child in xml.children() )
			{
				
				format = new  TextFormat();
				format.font = FontController.getInstance().getFontById( child.@font ).fontName;
				
				for each( grandChild in child.children() )
				{ 
					format[ grandChild.name().toString() ] = grandChild;
				}
			
				_formats.push( child.@id, format ); 
			}
		}
		
		public function getFormat( id:String ):TextFormat
		{
			return _formats[ id ] as TextFormat;
		}
		
		public static function getInstance():FormatController
		{
			if( !_instance )
			{
				_instance = new FormatController( new Key() );
			}
			return _instance;
		}
		
		
		
		
	}
}

final internal class Key{}