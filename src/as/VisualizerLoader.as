package
{
	import com.vml.views.AbstractLoader;
	
	public class VisualizerLoader extends AbstractLoader
	{
		public function VisualizerLoader()
		{
			super();
			_swfpath = root.loaderInfo.parameters.swfPath;
			loadSWF();
		}
	}
}