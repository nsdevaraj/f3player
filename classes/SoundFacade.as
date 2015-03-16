package classes{
	import flash.display.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	public class SoundFacade extends EventDispatcher {
		public var s:Sound;
		public var sc:SoundChannel;
		public var url:String;
		public var bufferTime:int = 1000;
		public var stransform:SoundTransform;
		public var isLoaded:Boolean = false;
		public var isReadyToPlay:Boolean = false;
		public var isPlaying:Boolean = false;
		public var isStreaming:Boolean = true;
		public var autoLoad:Boolean = true;
		public var autoPlay:Boolean = true;
		public var progressInterval:int = 1000;
		public var playTimer:Timer;
		public var totalplayTime:Number;
		public var parent_mc:MovieClip = new MovieClip();
		public var totalDate:Date;
		public var PosDate:Date;
		public function SoundFacade(soundUrl:String,this_mc,autoLoad:Boolean = true,autoPlay:Boolean = true, streaming:Boolean = true,bufferTime:int = -1):void {
			parent_mc = this_mc;
			totalDate = new Date();
			PosDate= new Date();
			// Sets Boolean values that determine the behavior of this object
			this.autoLoad = autoLoad;
			this.autoPlay = autoPlay;
			this.isStreaming = streaming;
			// Defaults to the global bufferTime value
			if (bufferTime < 0) {
				bufferTime = SoundMixer.bufferTime;
			}
			this.sc = new SoundChannel();
			this.stransform= sc.soundTransform;
			// Keeps buffer time reasonable, between 0 and 30 seconds
			this.bufferTime = Math.min(Math.max(0, bufferTime), 30000);
			if (autoLoad) {
				loadurl(soundUrl);
			}
		}
		public function loadurl(soundUrl:String) {
			this.url = soundUrl;
			this.isLoaded = false;
			this.s = new Sound();
			this.s.addEventListener(Event.OPEN, onLoadOpen);
			this.s.addEventListener(Event.COMPLETE, onLoadComplete);
			parent_mc.artist.text ="";
			parent_mc.title.text ="";
			parent_mc.song.text ="";
			this.s.addEventListener(Event.ID3, onID3);
			var req:URLRequest = new URLRequest(this.url);
			var context:SoundLoaderContext = new SoundLoaderContext(this.bufferTime,true);
			this.s.load(req);
		}
		public function onID3(event:Event):void {
			AttachTextField(parent_mc.artist,this.s.id3.artist,100,400);
			AttachTextField(parent_mc.title,this.s.id3.album,200,400);
			AttachTextField(parent_mc.song,this.s.id3.songName,350,400);
		}
		public function AttachTextField(tfname:TextField,tfText:String,x:Number,y:Number) {
			tfname.autoSize = TextFieldAutoSize.LEFT;
			tfname.multiline = true;
			if (tfText == null ) {
				tfname.text = "";
			} else {
				tfname.htmlText = tfText;
			}
			tfname.textColor = 0xFFFFFF;
		}
		public function onLoadOpen(event:Event):void {
			if (this.isStreaming) {
				this.isReadyToPlay = true;
				if (autoPlay) {
					this.play();
				}
			}
		}
		public function onLoadComplete(event:Event):void {
			this.isReadyToPlay = true;
			this.isLoaded = true;
			totalplayTime = this.s.length;
			SectoMin(totalplayTime,totalDate);
			parent_mc.totalTime.text =totalDate.getMinutes()+":"+totalDate.getSeconds();
			if (autoPlay && !isPlaying) {
				play();
			}
		}
		public function play(pos:int = 0):void {
			if (!this.isPlaying) {
				if (this.isReadyToPlay) { 
					this.sc = this.s.play(pos);					
					this.sc.addEventListener(Event.SOUND_COMPLETE, onPlayComplete);
					this.isPlaying = true;  
					startTimer();
				}
			}
		}
		public function startTimer() {
			parent_mc.mp3Controls_mc.playpause_btn.play_mc.visible = false;
			if (parent_mc.mutebtn.audioOn) {
				setVolume(parent_mc.slider.SliderVal);
			} else {
				setVolume(0);
			}
			setPan(parent_mc.slider.PanSliderVal);
			playTimer = new Timer(progressInterval);
			playTimer.addEventListener(TimerEvent.TIMER,  onPlayTimer);
			playTimer.start();
		}
		public function onPlayTimer(event:TimerEvent):void {
			SectoMin(sc.position,PosDate);
			if(sc.position >=30000 && parent_mc.trialVer){
				PlayNxtSng()
			}
			parent_mc.curTime.text=PosDate.getMinutes()+":"+PosDate.getSeconds();
			parent_mc.mp3Controls_mc.track_mc.value = sc.position/totalplayTime*100;
		}
		public function onPlayComplete(event:Event):void {
			PlayNxtSng()
		}
		public function PlayNxtSng(){
			var tno;
			var tempXML:XML
			if(parent_mc.shuffle){
				tno = Math.floor(Math.random() * parent_mc.songListArr.length);
				tempXML = new XML("<Song>"+parent_mc.songListArr[tno]+"</Song>");
				parent_mc.playArr.push(tno);
			}else{ 
				if (parent_mc.list_mc.list_mc.songList.selectedIndex != parent_mc.list_mc.list_mc.songList.length-1) {
					parent_mc.list_mc.list_mc.songList.selectedIndex++;
				}else{
					parent_mc.list_mc.list_mc.songList.selectedIndex =0
				}
				tempXML= new XML("<Song>"+parent_mc.list_mc.list_mc.songList.selectedItem.filename+"</Song>");
				var tsrch =parent_mc.songListArr.search(url)
				parent_mc.playArr.push(tsrch[0]);
			}		
			parent_mc.curPlaying++;
			parent_mc.mp3Controls_mc.back_btn.gotoAndStop(2);
			parent_mc.playNext(tempXML);
		}
		public function setVolume(volume:Number):void {
			stransform.volume = volume;
			this.sc.soundTransform = stransform;
		}
		public function setPan(pan:Number):void {
			stransform.pan = pan;
			this.sc.soundTransform = stransform;
		}
		public function SectoMin(Sec:Number,newDate:Date) {
			Sec =Sec/1000;
			var mins = (Sec/60);
			var secs = (Sec%60).toFixed(0);
			mins = parseInt(mins);
			newDate.minutes = mins;
			newDate.seconds = secs;
		}
		public function ChangePos(pos:Number) {
			this.sc.stop();
			this.sc = new SoundChannel();
			this.isPlaying = false;
			this.play(pos);
			this.isPlaying = true;
		}
	}
}