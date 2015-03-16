package classes{
	import flash.display.*;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.FileFilter;
	public class fileselect extends Sprite {
		private var file:FileReference;
		public var parent_mc:MovieClip = new MovieClip();
		public function fileselect(this_mc) {
			parent_mc =this_mc;
			var imagesFilter:FileFilter = new FileFilter("PlayLists", "*.m3u;*.txt;*.pl");
			file = new FileReference();
			file.addEventListener(Event.SELECT, selectHandler);
			file.addEventListener(Event.CANCEL, cancelHandler);
			file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			file.addEventListener(Event.COMPLETE, completeHandler);
			file.browse([imagesFilter]);
		}		
		private function selectHandler(event:Event):void {
			var file:FileReference = FileReference(event.target);
			parent_mc.mutebtn.openPlaylistFile(file.name)
			parent_mc.saveFileName(file.name);
			parent_mc.gotoAndStop(2);
			parent_mc.blocker_mc.gotoAndStop(1);			
		}
		private function cancelHandler(event:Event):void {
			if (parent_mc.playListFile == null) {
				parent_mc.blocker_mc.gotoAndStop(2);
			}
		}
		private function progressHandler(event:ProgressEvent):void {
			var file:FileReference = FileReference(event.target);
		}
		private function completeHandler(event:Event):void {
		}
	}
}