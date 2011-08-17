﻿package com.vml.events {	import flash.events.Event;	public class CustomEvent extends Event {		private var _data:Object; 				/**		* Constructor.		* @param  pType  The event name.		* @param  pBubbles  Whether the event bubbles up through the display list.		* @param  pCancelable  Whether the event can be canceled as it bubbles.		*/		public function CustomEvent ($type:String, $data:Object, $bubbles:Boolean=false, $cancelable:Boolean=false) {			_data = $data;			super($type, $bubbles, $cancelable);		}		/**		* Returns a copy of the event instance.		* @returns  A copy of the event.		*/		override public function clone():Event {			return new CustomEvent(type, bubbles, cancelable);		}		public function get data():Object {			return _data;		}	}}