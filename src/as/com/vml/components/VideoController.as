package  com.vml.components
{
	import com.vml.events.ButtonEvent;
	import com.vml.events.PercentEvent;
	import com.vml.events.VideoEvent;
	import com.vml.ui.ToggleButton;
	import com.xerox.ui.SkipButton;
	import com.xerox.ui.VideoSlider;
	
	
	[Event(name="muteVideo", type="com.vml.events.media.VideoEvent")]
	[Event(name="unmuteVideo", type="com.vml.events.media.VideoEvent")]
	[Event(name="playVideo", type="com.vml.events.media.VideoEvent")]
	[Event(name="pauseVideo", type="com.vml.events.media.VideoEvent")]
	[Event(name="restartVideo", type="com.vml.events.media.VideoEvent")]
	[Event(name="seekVideo", type="com.vml.events.media.VideoEvent")]

	public class VideoController extends AbstractComponent
	{

		public var playButton:ToggleButton;
		public var scrubber:VideoSlider;
		
		public function VideoController()
		{
			super();
			addEvents();
		}
		
		
		override public function addEvents():void
		{
			scrubber.addEventListener(PercentEvent.PERCENT, handleScrub );
			playButton.addEventListener(ButtonEvent.ON_CLICK, handlePlayToggle );
		}
		
		override public function removeEvents():void
		{
			scrubber.removeEventListener(PercentEvent.PERCENT, handleScrub );
			playButton.removeEventListener(ButtonEvent.ON_CLICK, handlePlayToggle );
			
		}
		
		
	
		
		protected function handlePlayToggle( event:ButtonEvent ):void 
		{
			switch( event.data.value )
			{
				case 1 :
					dispatchEvent( new VideoEvent( VideoEvent.PAUSE_VIDEO ));
				break
				case 2 :
					dispatchEvent( new VideoEvent( VideoEvent.PLAY_VIDEO ));
				break;
			}
		}
		
		protected function handleScrub( event:PercentEvent ):void
		{
			dispatchEvent( new VideoEvent( VideoEvent.SEEK_VIDEO, false, {percent:event.percent} ) );
		}
		
		public function updatePlayHead( percent:Number ):void
		{
			scrubber.percent = percent;
		}
	}
}