package classes{ 
	import fl.motion.*;
	import flash.filters.*;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.display.*;
	import flash.media.*;
	import flash.net.*;
	import flash.utils.ByteArray;
	import flash.events.*;
	import flash.geom.*;
	public class SpectrumBeam extends Sprite {
		// Settings  
		private var ba:ByteArray = new ByteArray();
		private var __x:uint;
		private var __y:uint;

		var mc:MovieClip=new MovieClip;

		var levels : Array = new Array();
		var i:uint = 0;
		var colors : Array = new Array();
		var toY:Number = 0;
		var colTrans:ColorTransform = new ColorTransform(1,1,1,1);
		var time:uint = 0;
		var angle:Number = 0;
		var bmp:BitmapData = new BitmapData(550, 400, false, 0x000000);//Visible BMP Data Object
		var buffer:BitmapData = new BitmapData(550, 400, false, 0x000000);//Used to save old image for transformation
		var trans_m : Matrix = new Matrix();
		var efxStageBmp:Bitmap =new Bitmap();
		var colorFilter: ColorMatrixFilter = new ColorMatrixFilter([1,0,0,0,0, 
		 0,1,0,0,0,
		 0,0,1,0,0,
		 0,0,0,1,1]);//Adds f to each color channel
		public var parent_mc:MovieClip = new MovieClip();
		public function SpectrumBeam(_x:uint, _y:uint,this_mc) {
			parent_mc = this_mc;
			__x = _x;
			__y = _y;
			x = __x;
			y = __y;
			mc.y = 200;
			mc.visible = false;//No need to be visible


			efxStageBmp =new Bitmap(bmp);
			efxStageBmp.x = 0;
			efxStageBmp.y = 0;
			parent_mc.map4.addChild(efxStageBmp);

			//Add Blur effect to the original MC
			mc.filters = [new BlurFilter(2,2,2)];



			trans_m.translate(-8,-6.5);
			trans_m.scale(1.03,1.03);

			//Fadeout Effect
			var f:Number = -2;

			addEventListener(Event.ENTER_FRAME, processSound);
		}
		private function RGB2Hex(r, g, b ) {
			var hex = r << 16 ^ g << 8 ^ b;
			return hex;
		}
		private function processSound(ev:Event):void {
			SoundMixer.computeSpectrum(ba,true);
			var i:int;
			var j:int;
			var tempValue : Number;
			for (i=0; i<512; i++) {
				levels[i] = ba.readFloat();
			}
			mc.graphics.clear();
			//
			for (i=0; i < 256; i++) {
				 colors[i] = RGB2Hex(255-i,i,time);
			}
			angle += Math.PI/600;
			//
			var showed:uint = 0;
			for (i=0; i < 256; i++) {
				var tempLevel_ : Number = (levels[i] + levels[i+256])/2;
				var level_ : Number = tempLevel_*70+60;
				var rad_ : Number = 2*Math.PI*i/256+angle;
				mc.graphics.lineStyle(5,colors[i],tempLevel_*1.3);
				// moving to first point so we don't have live from 0,0 point
				if (showed==0) {
					showed = 1;
					mc.graphics.moveTo(Math.cos(rad_)*level_+275,Math.sin(rad_)*level_+200);
				}
				// drawing line and moving it to last connected point
				mc.graphics.lineTo(Math.cos(rad_)*level_+275,Math.sin(rad_)*level_+200);
				mc.graphics.moveTo(Math.cos(rad_)*level_+275,Math.sin(rad_)*level_+200);

			}
			time++;
			if (time == 256) {
				time = 0;
			}
			//Draw original Image on BMP
			bmp.draw(mc, null, null, "add");
			buffer.draw(bmp, null, colTrans);//Save image to buffer
			var firstRect:Rectangle = new Rectangle(0,0,550,400);
			buffer.applyFilter(buffer, firstRect, new Point(0, 0), colorFilter);//Apply fadeout
			bmp.draw(buffer, trans_m);//Transform buffer and draw on BMP
		}
	}
}