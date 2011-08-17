package com.vml.utils
{
	import flash.net.LocalConnection;
	
	public class DomainUtils
	{
		public static var BASE_URL:String = "http://" + new LocalConnection().domain + "/#";
		
		public function DomainUtils()
		{
		}

	}
}