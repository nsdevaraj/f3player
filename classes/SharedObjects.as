package classes{
	import flash.display.MovieClip;
	import flash.display.Sprite; 
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus; 
	import flash.events.*;
	public class SharedObjects extends Sprite {
		public var mySo:SharedObject;
		public var parent_mc:MovieClip =new MovieClip();
		public function SharedObjects(this_mc:MovieClip, FavSo:SharedObject) {
			parent_mc =this_mc;
			mySo = FavSo
			var sobj = String(parent_mc.playListFile); 
			mySo= SharedObject.getLocal("sobj");	
		} 
		public function saveValue(savarr:Array) {
			mySo.data.savedValue=savarr;
			var flushStatus:String=null;
			try {
				flushStatus=mySo.flush(10000);
			} catch (error:Error) {
			}
			if (flushStatus != null) {
				switch (flushStatus) {
					case SharedObjectFlushStatus.PENDING :
						mySo.addEventListener(NetStatusEvent.NET_STATUS,onFlushStatus);
						break;
					case SharedObjectFlushStatus.FLUSHED :
						break;
				}
			}
		}
		private function onFlushStatus(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "SharedObject.Flush.Success" :
					break;
				case "SharedObject.Flush.Failed" :
					break;
			}
			mySo.removeEventListener(NetStatusEvent.NET_STATUS,onFlushStatus);
		}
	}
}