package classes{
	import flash.display.*;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.display.Shape;
	import flash.display.Bitmap;
	public class Spectrum extends Sprite {
		private var bytes: ByteArray;
		private var output: BitmapData;
		private var peaks: BitmapData;
		private var displace: Matrix;
		private var rect: Rectangle;
		public var gradient: Array;
		private var darken: ColorTransform;
		public var parent_mc:MovieClip = new MovieClip();
		public var pBMP:Bitmap;
		public var oBMP:Bitmap; 
		public function Spectrum(this_mc,swidth,sheight) {
			parent_mc = this_mc;
			bytes = new ByteArray();
			output = new BitmapData( swidth, sheight, true, 0 );
			peaks = new BitmapData( swidth, sheight, true, 0 );
			displace = new Matrix();
			displace.tx = 2;
			displace.ty = -1;
			darken = new ColorTransform( 1, 1, 1, 1, -2, -2, -2, 0 );
			rect = new Rectangle( 0, 0, 1, 0 );
			oBMP = new Bitmap(output);
			pBMP = new Bitmap(peaks);
			parent_mc.maps.addChild(oBMP);
			parent_mc.maps.addChild(pBMP);
			parent_mc.addEventListener( Event.ENTER_FRAME, onEnterFrameHandler); 
		}
		private function onEnterFrameHandler( event: Event ):void {
			peaks.fillRect(peaks.rect,0);
			SoundMixer.computeSpectrum(bytes, true, 0);
			var value: Number;
			var height: Number;
			var smooth: Number;
			for (var i: int = 0; i < 256; i++) {
				value = bytes.readFloat();
				if ( i == 0 ) {
					smooth = value;
				} else {
					smooth += (value - smooth)/8;
				}
				height = 2 + smooth * 0xf0;
				rect.x = 8 + i;
				rect.y = 320 + ( i >> 2 ) - height;
				rect.height = height;
				peaks.setPixel32(rect.x, rect.y, 0xffffffff);
				output.fillRect(rect, 0xff000000 | gradient[i]);
			}
			if (!parent_mc.pausedPlay) {
				output.draw( output, displace, darken, null, null, true );
			}
		}
		public function createRainbowGradientArray():Array {
			var gradient: Array = new Array();
			var shape: Shape = new Shape();
			var bmp: BitmapData = new BitmapData(256,1,false,0);
			var colors: Array = [ 0, parent_mc.colorPickers_mc.colorPickers.color1.selectedColor, parent_mc.colorPickers_mc.colorPickers.color2.selectedColor, parent_mc.colorPickers_mc.colorPickers.color3.selectedColor, parent_mc.colorPickers_mc.colorPickers.color4.selectedColor ];
			var alphas: Array = [ 100, 100, 100, 100, 100 ];
			var ratios: Array = [ 0, 16, 128, 192, 255 ];
			var matrix: Matrix = new Matrix();
			matrix.createGradientBox(256,1,0,0,0);
			shape.graphics.beginGradientFill('linear',colors,alphas,ratios,matrix);
			shape.graphics.drawRect(0,0,256,1);
			shape.graphics.endFill();
			bmp.draw(shape);
			for (var i: int = 0; i < 256; i++) {
				gradient[i] = bmp.getPixel(i,0);
			}
			return gradient;
		}
	}
}