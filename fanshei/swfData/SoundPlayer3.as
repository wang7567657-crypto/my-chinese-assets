package {
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.display.MovieClip;

	public class SoundPlayer3 extends Sprite {

		private static var snd:Sound;
		private static var sndChannel:SoundChannel;
		public static var urlArr:Array;
		public static var urlArrPos:int;
		public static var dispatcher:Sprite=new Sprite();
		public static var sndDir:String="../soundData";
		public static var count:int=0;
		public static var target:MovieClip;
		
 

		public static function play(inputVal:*):void {
			urlArr=new Array();
			urlArrPos=0;
			if (inputVal is String) {				
				urlArr.push(inputVal);
			} else if (inputVal is Array) {
				urlArr=inputVal;
			} else {
				
			}		
			
			try{
				sndChannel.stop();
			}catch(err:Error){
				
			}
			
			try{
				realPlay();
			}catch(err:Error){
				throw err;
			}
			
			
		}
		
		private static function realPlay(){						
			//Sound物件要重新建構的原因是因為它無法同時load進不同的聲音						
			snd=new Sound();			
			snd.addEventListener(Event.COMPLETE,sndLoadHandler);
			snd.addEventListener(ProgressEvent.PROGRESS,onProgress);
			snd.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);			
			snd.load(new URLRequest(sndDir+"\\"+urlArr[urlArrPos]+".mp3"),new SoundLoaderContext(0));					
		}
		
		private static function onProgress(e:Event){
			
			dispatcher.dispatchEvent(new Event("playOnProgress"));
		}
		
		private static function ioErrorHandler(e:IOErrorEvent){			
			//trace(e);
			
			dispatcher.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
		}
		
		private static function sndLoadHandler(e:Event):void {	
			//trace(urlArr[urlArrPos]);						
			//dispatcher.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
			sndChannel=snd.play(1);
			//trace(urlArr[count]);
			count++;
			sndChannel.addEventListener(Event.SOUND_COMPLETE,sndChannelComplete);
		}
		
		private static function sndChannelComplete(e:Event):void {			
			dispatcher.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
			if ((urlArrPos+1)==urlArr.length) {
				dispatcher.dispatchEvent(new Event("playCompleted"));
				urlArrPos=0;
				//snd.removeEventListener(Event.COMPLETE,sndLoadHandler);
				sndChannel.removeEventListener(Event.SOUND_COMPLETE,sndChannelComplete);
				//this.dispatchEvent(new Event(Event.COMPLETE));
			} else {
				snd=new Sound();
				urlArrPos ++;
				realPlay();
			}
		}
		
		public static function stop(){	
			if(!snd.hasEventListener(Event.COMPLETE)){
				throw new Error("沒有聲音何需stop?!");
				return;
			}
			snd.removeEventListener(Event.COMPLETE,sndLoadHandler);
			sndChannel.removeEventListener(Event.SOUND_COMPLETE,sndChannelComplete);
			sndChannel.stop();
			snd=null;
			sndChannel=null;
		}		
		
		public static function continuePlay(){
			urlArrPos--;
			sndChannelComplete(null);
		}
	}
}