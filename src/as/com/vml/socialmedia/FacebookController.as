package com.vml.socialmedia
{
	import com.facebook.graph.Facebook;
	import com.facebook.graph.core.FacebookURLDefaults;
	import com.facebook.graph.data.FacebookSession;
	import com.facebook.graph.net.FacebookRequest;
	import com.facebook.graph.utils.FacebookDataUtils;
	import com.vml.events.FacebookEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.sampler.NewObjectSample;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	
	import mx.rpc.mxml.Concurrency;
	
	import org.osmf.events.ViewEvent;
	import org.osmf.media.LoadableMediaElement;
	
	import sk.yoz.events.FacebookOAuthGraphEvent;
	import sk.yoz.net.FacebookOAuthGraph;
	
	
	[Event(name="dataLoaded", type="com.vml.events.FacebookEvent")]
	[Event(name="requestLogin", type="com.vml.events.FacebookEvent")]
	public class FacebookController extends EventDispatcher
	{
		
		private static const secret:String = "796a0aa3325c841b438bdbfa92d031a2";
		private static const id:String     = "146375105419248";
		private static const apikey:String = "66e62fd5bf3fc9a71c44b436e926960d";
		
		protected var _successObject:Object;
		
		public function FacebookController( )
		{		
		}
	
		public function init():void
		{
			Facebook.init( FacebookController.id, handleInit, {perms:"publish_stream,read_stream"}); 
		}	
		
		
		private function handleInit( success:Object , fail:Object ):void
		{
			if( success )
			{
				dispatchEvent( new Event( Event.INIT ));
			}
			else
			{
				dispatchEvent( new FacebookEvent(FacebookEvent.REQUEST_LOGIN) );
			}
		}
		
		public function callLoginWindow():void
		{
			Facebook.login( handleLogin ,{perms:"publish_stream,read_stream"});
		}
		
		private function handleLogin( success:Object , fail:Object ):void
		{
			trace( this, " logged in " );
		}
				
		public function getFriendsPictures():void
		{
			Facebook.api( "/me/friends", handleFriendsComplete  );
		}
	
		private function handleFriendsComplete( success:Object, fail:Object ):void
		{
			var prop:String
			var path:String;
			var person:Object;
			
			_successObject = success;
			dispatchEvent( new FacebookEvent( FacebookEvent.DATA_LOADED ));
			
		}
		
		public function loadImageFromFacebook( memberID:String ):void
		{
			var loader:Loader = new Loader();
			var contenxt:LoaderContext = new LoaderContext();
			contenxt.securityDomain = SecurityDomain.currentDomain;
			contenxt.checkPolicyFile = true;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImageLoaded );
			loader.load( new URLRequest( Facebook.getImageUrl( memberID ) ) );			
		}
									
		
		private function handleImageLoaded( event:Event ):void
		{
			var loaderInfo:LoaderInfo = event.target as LoaderInfo
			dispatchEvent( new FacebookEvent(FacebookEvent.DATA_LOADED, false, loaderInfo ) );
		}
		
		
		public function postImage( bmd:BitmapData ):void
		{
			Facebook.api( "/me/photos", handlePostSuccess,{ fileName:"someImage", picture:bmd }, "POST" );
		}
		
		private function handlePostSuccess( success:Object, fail:Object ):void
		{
			_successObject = success;
			dispatchEvent( new FacebookEvent( FacebookEvent.DATA_LOADED ));
		}
		
		
		public function get successObject():Object
		{
			return _successObject;
		}
		
	
								
	}
}