package classes{
	import flash.display.Sprite;
	import flash.display.*;
	import flash.events.*;
	import flash.events.Event;
	import flash.media.Sound; 
	import flash.media.SoundMixer; 
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	public class SoundSpectrum extends Sprite {   
		public var gr:Sprite; 
		private var ba:ByteArray=new ByteArray;
		public var parent_mc:MovieClip = new MovieClip();
		public function SoundSpectrum(this_mc,sx,sy) {
			parent_mc = this_mc;  
			gr=new Sprite();
			gr.x=sx;
			gr.y=sy;
			parent_mc.map3.addChild(gr);
			parent_mc.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		} 
		private function onEnterFrameHandler(event:Event):void {
			SoundMixer.computeSpectrum(ba,true);
			var fillType:String="linear";
			var colors:Array=[parent_mc.colorPickers_mc.colorPickers.color1.selectedColor, parent_mc.colorPickers_mc.colorPickers.color2.selectedColor, parent_mc.colorPickers_mc.colorPickers.color3.selectedColor];
			var alphas:Array=[1,1,1];
			var ratios:Array=[0,125,125];
			var matr:Matrix=new Matrix;
			matr.createGradientBox(800,600,0,0,0);
			var spreadMethod:String="PAD";
			var i:int;
			gr.graphics.clear();
			gr.graphics.lineStyle(.5,0x000000,1,false,"normal","round","miter",8);
			gr.graphics.beginGradientFill(fillType,colors,alphas,ratios,matr,spreadMethod);
			gr.graphics.moveTo(0,0);
			var w:uint=10;
			for (i=0; i < 512; i+= w) {
				var t:Number=ba.readFloat();
				var n:Number=t * 300;
				gr.graphics.drawRect(i,0,w,- n);
			}
		}
	}
}