package classes{
	import flash.display.*;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.events.Event;
	import flash.media.*;
	import flash.utils.ByteArray;
	public class SpectrumMc extends Sprite {
		private var ba:ByteArray = new ByteArray();
		var movieClipClass:Class = getDefinitionByName("VisLinkMC") as Class;
		public var parent_mc:MovieClip = new MovieClip();
		public var totalSpace:Number;
		var mcwidth :uint = 2;
		var ClipsArr:Array=new Array();
		var i:int;
		public function SpectrumMc(this_mc,tSpace) {
			parent_mc = this_mc;
			totalSpace = tSpace;
			for (i=10; i<totalSpace; i+=mcwidth) {
				var instance:Object = new movieClipClass();
				var mc=parent_mc.map5.addChild(DisplayObject(instance));
				ClipsArr[i]=mc;
				mc.x=i*10;
				mc.y=380;
				mc.alpha=0;
			}
			addEventListener(Event.ENTER_FRAME, fnRefresh);
		} 
		private function fnRefresh(ev:Event):void {
			SoundMixer.computeSpectrum(ba, true);
			var j:int;
			var mcwidth :uint = 2;
			for (j=10; j<totalSpace; j+=mcwidth) {
				var conversion_:Number = ba.readFloat();
				trace(conversion_)
				var displace:Number = (conversion_ * 2.5);
				var mc=ClipsArr[j];
				mc.scaleY=displace;
				mc.scaleX=displace;
				mc.alpha=10;
			}
		}
	}
}