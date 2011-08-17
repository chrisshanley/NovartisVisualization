package com.vml.debug
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;	

	public class Stats extends Sprite
	{	
		private var xml : XML;

		private var text : TextField;
		private var style : StyleSheet;

		private var timer : uint;
		private var fps : uint;
		private var ms : uint;
		private var ms_prev : uint;
		private var mem : Number;
		private var mem_max : Number;
		
		private var graph : BitmapData;
		private var rectangle : Rectangle;
		
		private var fps_graph : uint;
		private var mem_graph : uint;
		private var mem_max_graph : uint;

		public function Stats() : void
		{
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
		}

		private function init(e : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			graphics.beginFill(0x33);
			graphics.drawRect(0, 0, 70, 50);
			graphics.endFill();

			mem_max = 0;

			xml = <xml><fps>FPS:</fps><ms>MS:</ms><mem>MEM:</mem><memMax>MAX:</memMax></xml>;
		
			style = new StyleSheet();
			style.setStyle("xml", {fontSize:'9px', fontFamily:'_sans', leading:'-2px'});
			style.setStyle("fps", {color: '#FFFF00'});
			style.setStyle("ms", {color: '#00FF00'});
			style.setStyle("mem", {color: '#00FFFF'});
			style.setStyle("memMax", {color: '#FF0070'});
			
			text = new TextField();
			text.width = 70;
			text.height = 50;
			text.styleSheet = style;
			text.condenseWhite = true;
			text.selectable = false;
			text.mouseEnabled = false;
			addChild(text);
			
			var bitmap : Bitmap = new Bitmap( graph = new BitmapData(70, 50, false, 0x33) );
			bitmap.y = 50;
			addChild(bitmap);
			
			rectangle = new Rectangle( 0, 0, 1, graph.height );			
			
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}

		private function destroy( e : Event ) : void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(Event.ENTER_FRAME, update);			
		}

		private function update( e : Event ) : void
		{
			timer = getTimer();
			
			if( timer - 1000 > ms_prev )
			{
				ms_prev = timer;
				mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				mem_max = mem_max > mem ? mem_max : mem;
				
				fps_graph = Math.min( 50, ( fps / stage.frameRate ) * 50 );
				mem_graph =  Math.min( 50, Math.sqrt( Math.sqrt( mem * 5000 ) ) ) - 2;
				mem_max_graph =  Math.min( 50, Math.sqrt( Math.sqrt( mem_max * 5000 ) ) ) - 2;
				
				graph.scroll( 1, 0 );
				
				graph.fillRect( rectangle , 0x33 );
				graph.setPixel( 0, graph.height - fps_graph, 0xFFFF00);
				graph.setPixel( 0, graph.height - ( ( timer - ms ) >> 1 ), 0x00FF00 );
				graph.setPixel( 0, graph.height - mem_graph, 0x00FFFF);
				graph.setPixel( 0, graph.height - mem_max_graph, 0xFF0070);
				
				xml.fps = "FPS: " + fps + " / " + stage.frameRate;
				xml.mem = "MEM: " + mem;
				xml.memMax = "MAX: " + mem_max;
				
				fps = 0;
			}

			fps++;
			
			xml.ms = "MS: " + (timer - ms);
			ms = timer;
			
			text.htmlText = xml;
		}
		
		private function onClick(e : MouseEvent) : void
		{
			mouseY / height > .5 ? stage.frameRate-- : stage.frameRate++;
			xml.fps = "FPS: " + fps + " / " + stage.frameRate;
			text.htmlText = xml;
		}
	}
}