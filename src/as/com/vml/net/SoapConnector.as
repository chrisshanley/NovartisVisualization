/**
 * Generic Soap 1.2 connector. Sends soap1.2 complaint xml. Returns xml clean from namespaces.
 * 
 * @author: pcthomatos.com
 */
package com.vml.net{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.*;	
	
	public class SoapConnector{
		private var _urlLoader:URLLoader;
		private var _soapStr:String = "http://www.w3.org/2003/05/soap-envelope";
		private var _xsiStr:String = "http://www.w3.org/2001/XMLSchema-instance";
		private var _xsdStr:String = "http://www.w3.org/2001/XMLSchema";
		private var _soap:Namespace = new Namespace(_soapStr);
		private var _xsi:Namespace = new Namespace(_xsiStr);
		private var _xsd:Namespace = new Namespace(_xsdStr);
		private var _onCompleteFunction:Function;
		private var _feedNs:String;
		private var _method:String;

		public function SoapConnector(){
		}

		public function loadWebService(method:String, feedURL:String, feedNs:String, bodyObj:Object, onCompleteFunction:Function) :void {
			_method = method;
			_feedNs = feedNs;
			_onCompleteFunction = onCompleteFunction;

			var urlRequest:URLRequest = new URLRequest(feedURL);
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.requestHeaders.push(new URLRequestHeader("Content-Type", "application/soap+xml"));
			urlRequest.data = returnXMLFromObj(method, feedNs, bodyObj);
			
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_urlLoader.addEventListener(Event.COMPLETE, onServiceLoaded);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ifServiceFailed);
			_urlLoader.load(urlRequest);
		}
		
		private function onServiceLoaded(e:Event):void {
			_urlLoader.removeEventListener(Event.COMPLETE, onServiceLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ifServiceFailed);
			var returnedXML:XML = XML(_urlLoader.data);
			var ns:Namespace = new Namespace(_feedNs);
			_onCompleteFunction(XML("<result>" + returnedXML..ns::[_method+"Result"] + "</result>"));
			
			_urlLoader.data = null;
		}
		
		private function ifServiceFailed(e:ErrorEvent):void {
			_urlLoader.removeEventListener(Event.COMPLETE, onServiceLoaded);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ifServiceFailed);				
			trace("Could not complete because: " + e);
		}
		
		private function returnXMLFromObj(method:String, feedNs:String, bodyObj:Object):XML {
			var rXML:XML = 
			<soap12:Envelope xmlns:xsi={_xsiStr} xmlns:xsd={_xsdStr} xmlns:soap12={_soapStr}>
			<soap12:Body/>
			</soap12:Envelope>
			;

			rXML._soap::Body[method].@xmlns = feedNs;

			for(var i:String in bodyObj) rXML._soap::Body[method][i] = bodyObj[i];				

			return rXML;
		}
	}
}





