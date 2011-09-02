package
{
	import com.greensock.TweenLite;
	import com.visualizer.data.FauxIdeas;
	import com.visualizer.data.IdeaData;
	import com.visualizer.data.IdeaGroup;
	import com.visualizer.events.VisualizerEvent;
	import com.visualizer.ui.DateSlider;
	import com.visualizer.ui.DualDateSlider;
	import com.visualizer.views.DetailsView;
	import com.visualizer.views.IdeaView;
	import com.visualizer.views.MainView;
	import com.visualizer.views.Ring;
	import com.visualizer.views.RingContainer;
	import com.vml.events.ViewEvent;
	import com.vml.font.FontController;
	import com.vml.font.FormatController;
	import com.vml.views.AbstractApplication;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.system.Security;
	import flash.text.engine.TabAlignment;
	import flash.utils.Dictionary;
	
	
	public class Visualizer extends AbstractApplication
	{
		
		public static var debug:Boolean = true;
		
		private var _model:Model
		private var _ringView:RingContainer;
		private var _mainView:MainView;
		private var _details:DetailsView;
		
		public function Visualizer()
		{
		}
		
		override public function init(info:LoaderInfo):void
		{		
			_model = Model.getInstance();
			_model.addEventListener( Event.INIT , handleModelInit );
			_model.init( info );
		}
		
		private function handleModelInit( event:Event ):void
		{
			var fontController:FontController = FontController.getInstance();
			fontController.init( _model.configData.fonts );
			
			var formatController:FormatController = FormatController.getInstance();
			formatController.init( _model.configData.formats );
			_model.addEventListener( Event.COMPLETE, handleServiceReady )
			_model.removeEventListener( Event.INIT , handleModelInit );
			_model.initCategories();
			_model.requestRecords();
		}
		
		private function handleServiceReady( event:Event ):void
		{
			_model.removeEventListener( Event.COMPLETE, handleServiceReady );
			super.init( _model.loaderInfo );
		}
		
		override public function initView():void
		{
			
			addEventListener( VisualizerEvent.CATEGORY_SELECTED, handleCategorySelected );
			
			_mainView = new MainView();
			addChild( _mainView  );
			
			_ringView = new RingContainer();
			_ringView.addEventListener( Event.COMPLETE , handleRingsReady );
			addChildAt( _ringView , 0);

			_ringView.y = _mainView.footerHeight * -1 - 5;
			
			addEventListener( VisualizerEvent.IDEA_CLICK, handleObjectClick );
			addEventListener( VisualizerEvent.IDEA_OVER, handleObjectOver );
			addEventListener( VisualizerEvent.IDEA_OUT, handleObjectOut );
			addEventListener( VisualizerEvent.DATE_SELECTED, handleDateSeleceted );
			addEventListener( Event.CHANGE, handleDateChange );
			addEventListener( VisualizerEvent.CLOSE_DETAILS, handleCloseDetails );
		}
		
		private function handleCategorySelected( event:VisualizerEvent ):void
		{
			_ringView.sort( _model.category );
		}
		
		private function handleObjectOver( event:VisualizerEvent ):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
			
			var view:IdeaView  = event.target as IdeaView;
			var point:Point = new Point( this.x, this.y );	
			
			if( _details )
			{
				trace( this, " backing over same object , ",  _details, _details.active );
				
			}
			if( _details && view.name == _details.name && _details.active )
			{
				trace( this, " same name as active variable " );
				return 
			}
			
			if( _details && _details.active )
			{
				_details.active = false;
				_details.addEventListener(ViewEvent.ANIMATE_OUT_COMPLETE, handlDetailsClosed );
				_details.close();
			}
			
			_details = new DetailsView( _model.getIdeaById( view.id ) );
			_details.init();
			_details.active = true;
			_details.buttonMode = true;
			_details.colors = view.colors;
			_details.name = view.name;
			_details.x = view.localToGlobal( point ).x;
			_details.y = view.localToGlobal( point ).y;
			_details.addEventListener(VisualizerEvent.DETAILS_UPDATE, handleUpdateDetailsPosition );
			_details.filters = [ new DropShadowFilter( 4, 45, 0x000000, 0.4 ) ];
			var xoffset:Number;
			var yoffset:Number;
			if( _details.x + _details.width > stage.stageWidth )
			{
				xoffset = _details.x + _details.width - stage.stageWidth;
				_details.x -= xoffset;
			}
			
			if(  _details.y + _details.height > stage.stageHeight )
			{				
				yoffset = _details.y + _details.height - ( stage.stageHeight );
				_details.y -= yoffset;
			}
			
			addChild( _details );
		}
		
		private function handleObjectOut( event:VisualizerEvent ):void
		{
		//	_details.addEventListener(ViewEvent.ANIMATE_OUT_COMPLETE, handlDetailsClosed );
		//	_details.close();	
		}
		
		private function handleUpdateDetailsPosition( event:Event ):void
		{
			var xoffset:Number;
			var yoffset:Number;
			if( _details.x + _details.width > stage.stageWidth )
			{
				xoffset = _details.x + _details.width - stage.stageWidth;
				_details.x -= xoffset;	
			}
			
			if(  _details.y + _details.height > stage.stageHeight )
			{				
				yoffset = _details.y + _details.height - ( stage.stageHeight );
				_details.y -= yoffset;
			}
		}
		
		private function handlDetailsClosed( event:ViewEvent ):void
		{
			var details:DetailsView = event.target as DetailsView;
			details.removeEventListener(ViewEvent.ANIMATE_OUT_COMPLETE, handlDetailsClosed );
			details.destroy();
			removeChild( details );
			details = null;
		}
		
		private function handleObjectClick( event:VisualizerEvent ):void
		{
			_details.state = DetailsView.CLICK_STATE;
		}
		
		private function handleCloseDetails( event:VisualizerEvent ):void
		{
			_details.addEventListener(ViewEvent.ANIMATE_OUT_COMPLETE, handlDetailsClosed );
			_details.active = false;
			_details.close();
		}
		
		private function handleDateChange( event:Event ):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
			
			var slider:DualDateSlider =  event.target as DualDateSlider;	
			var maxDif:Number  = _model.endDate.getTime() - _model.startDate.getTime();
			var endDate:Date   = new Date();	
			var startDate:Date = new Date( );
			startDate.setTime( _model.startDate.getTime() );
			
			endDate.setTime( _model.startDate.getTime() + maxDif * slider.rightPercent );
			startDate.setTime( _model.startDate.getTime() + maxDif * slider.leftPercent )
			

			slider.dates = [ startDate, endDate ];
		}
		
		private function handleDateSeleceted( event:VisualizerEvent ):void
		{
			event.stopImmediatePropagation();
			event.stopPropagation();
			
			var slider:DualDateSlider =  event.target as DualDateSlider;	
			var maxDif:Number  = _model.endDate.getTime() - _model.startDate.getTime();
			var endDate:Date   = new Date( );	
			var startDate:Date = new Date();  
			endDate.setTime( _model.startDate.getTime() + maxDif * slider.rightPercent );
			startDate.setTime( _model.startDate.getTime() + maxDif * slider.leftPercent );
			
			_model.addEventListener( Event.COMPLETE , handleSetLoaded );
			_model.requstRecordsByDates( [ startDate, endDate ] );
		}
		
		private function handleSetLoaded( event:Event ):void
		{
			_model.removeEventListener( Event.COMPLETE , handleSetLoaded );
			_ringView.init();
		}
		
	
		
		private function handleRingsReady( event:Event ):void
		{
			_ringView.removeEventListener( Event.COMPLETE , handleRingsReady );
			_mainView.enableSlider();
			
			trace( this, " rings ready " );
		}
		
	}
}