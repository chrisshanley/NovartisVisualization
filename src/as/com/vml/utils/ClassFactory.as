package com.vml.utils{
	import flash.utils.getDefinitionByName;
	
	public class ClassFactory{
		public function ClassFactory(){
		}
		
		public static function generate(className:String):Class{
			return getDefinitionByName(className) as Class;
		}
	}
}