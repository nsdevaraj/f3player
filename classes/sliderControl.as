package classes{
	import flash.display.*;
	import fl.events.SliderEvent; 
	import fl.events.SliderEventClickTarget;
	public class sliderControl {
		public var parent_mc:MovieClip = new MovieClip();
		public var SliderVal:Number;
		public var PanSliderVal:int;
		public function sliderControl(Slider, this_mc) {
			parent_mc =this_mc;
			switch (Slider.name) {
				case "slider_mc" :
					Slider.addEventListener(SliderEvent.CHANGE, SliderInput);
					Slider.addEventListener(SliderEvent.THUMB_DRAG, SliderInput);
					SliderVal = Slider.value/100;
					break;
				case "panslider_mc" :
					Slider.addEventListener(SliderEvent.CHANGE, PANSliderInput);
					Slider.addEventListener(SliderEvent.THUMB_DRAG, PANSliderInput); 
					break;
				case "track_mc" :
					Slider.addEventListener(SliderEvent.CHANGE, trackSliderInput);
					Slider.addEventListener(SliderEvent.THUMB_DRAG, trackSliderInput); 
					break;
			}			
		}		
		private function SliderInput(e:SliderEvent):void {
			SliderVal = e.value/100;
			ChangeVolume(SliderVal);
			parent_mc.SetStageFocus();
		}
		private function PANSliderInput(e:SliderEvent):void {
			var input:Number = e.value/10;
			input = (input*2-100);
			PanSliderVal = input/100;
			ChangePan(PanSliderVal);
			parent_mc.SetStageFocus();
		}
		private function trackSliderInput(e:SliderEvent):void {
			var Pos= ((e.value *parent_mc.snf.totalplayTime)/100)		
			parent_mc.snf.ChangePos(Pos);
			parent_mc.SetStageFocus();
			parent_mc.pausedPlay = false
		}
		private function ChangePan(pan:Number) {
			parent_mc.snf.setPan(pan);
		}
		private function ChangeVolume(volume:Number) {
			parent_mc.snf.setVolume(volume);
		}
	}
}