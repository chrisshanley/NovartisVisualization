package  com.vml.text
{
	import com.vml.text.ButtonLabel;
	import com.vml.utils.SpriteFactory;
	
	import flash.display.Sprite;
	
	public class GradientLabel extends Sprite
	{
				
		public static const GREEN:String = "green";

		private var _gradient:Sprite;
		private var _label:ButtonLabel;
		
		public function GradientLabel(label:String, formatType:String, gradient:String = GradientLabel.GREEN, multiline:Boolean = false )
		{
			
			_label = new ButtonLabel( label, formatType, multiline );
			
			switch( gradient )
			{
				case GradientLabel.GREEN :
					_gradient  = new GreenGradient() as Sprite;
				break;
			}
			
			_gradient.width = _label.width;
			_gradient.height = _label.height;
			_gradient.mask = _label;
			
			addChild( _gradient );
			addChild( _label );
		}
		
		public function set gradient( sprite:Sprite ):void
		{
			if( _gradient )
			{
				_gradient.mask = null;
				removeChild( _gradient );
				_gradient = null;
			}
			_gradient = sprite;
			_gradient.mask = _label;
			addChild( _gradient );
		}
		
		public function set text( value:String ):void
		{
			_label.htmlText = value;
			_gradient.width = _label.width;
			_gradient.height = _label.height;
		}
		
		
		
	}
}