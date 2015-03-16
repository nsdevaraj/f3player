package classes{ 
	import flash.display.*;
	import flash.media.*;
	import flash.net.*;
	import flash.utils.ByteArray;
	import flash.events.*;
	public class SpectrumAnalyzer extends Sprite {
		// Settings
		public var gr:Sprite; 
		private var lineThickness:Number = 2;
		private var lineColor:Number = 0x0191EE;
		private var circleSize:Number = 105;
		private var scaleOnBeat:Number = 1;// 100%
		private var reactToBeat:Number = 30;
		private var ba:ByteArray = new ByteArray();
		private var __x:uint;
		private var __y:uint;
		public var parent_mc:MovieClip = new MovieClip();
		public function SpectrumAnalyzer(_x:uint, _y:uint,this_mc) {
			parent_mc = this_mc; 
			__x = _x;
			__y = _y;
			gr=new Sprite();
			gr.x = __x;
			gr.y = __y;
			parent_mc.map2.addChild(gr);
			addEventListener(Event.ENTER_FRAME, processSound);
		}
		private function processSound(ev:Event):void {
			SoundMixer.computeSpectrum(ba, true, 0);
			gr.graphics.clear();
			gr.graphics.moveTo(0, -circleSize);
			gr.graphics.lineStyle(lineThickness, lineColor);
			var vol:Number = 0;
			for (var i:uint = 0; i <512; i++) {
				var lev:Number = ba.readFloat();
				vol += lev;
				var a:uint = i;
				if (i <256) {
					a += 256;
				}
				if (i == 256) {
					gr.graphics.moveTo(0, -circleSize);
				}
				gr.graphics.lineTo(-Math.sin(i/256*Math.PI)*circleSize*(lev+1), Math.cos(a/256*Math.PI)*circleSize*(lev+1));
			}
			if (vol> reactToBeat) {
				scaleX = scaleY = scaleOnBeat;
			} else {
				scaleX = scaleY = 1;
			}
		}
	}
}