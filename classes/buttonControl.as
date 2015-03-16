package classes{
	import classes.fileselect;
	import classes.SpectrumAnalyzer;
	import classes.Spectrum;
	import classes.SoundSpectrum;
	import classes.SpectrumBeam;
	import classes.SpectrumMc;
	import fl.data.DataProvider;
	import flash.display.*;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.net.URLRequest; 
	public class buttonControl {
		public var parent_mc:MovieClip = new MovieClip();
		public var audioOn:Boolean = true;
		var hideX = 1000;
		var holdY = 55;
		public var bgLoader:Loader=new Loader;
		public function buttonControl(Button, this_mc) {
			parent_mc =this_mc;
			switch (Button.name) {
				case "register_btn" :
					Button.addEventListener(MouseEvent.CLICK, registerHandler);
					break;
				case "shuffleon_btn" :
					Button.addEventListener(MouseEvent.CLICK, shuffleonHandler);
					break;
				case "shuffleoff_btn" :
					Button.addEventListener(MouseEvent.CLICK, shuffleoffHandler);
					break;
				case "logo_btn" :
					Button.addEventListener(MouseEvent.CLICK, LogoOpenHandler);
					break;
				case "open_btn" :
					Button.addEventListener(MouseEvent.CLICK, plistOpenHandler);
					break;
				case "uparrow_btn" :
					Button.addEventListener(MouseEvent.CLICK, listOpenHandler);
					break;
				case "dwnarrow_btn" :
					Button.addEventListener(MouseEvent.CLICK, listOpenHandler);
					break;
				case "scls_btn" :
					Button.addEventListener(MouseEvent.CLICK, sClsHandler);
					break;
				case "fcls_btn" :
					Button.addEventListener(MouseEvent.CLICK, fClsHandler);
					break;
				case "openBtn" :
					Button.addEventListener(MouseEvent.CLICK, openPLHandler);
					break;
				case "focus_mc" :
					Button.addEventListener(MouseEvent.CLICK, focusHandler);
					break;
				case "nextarrow_btn" :
					Button.addEventListener(MouseEvent.CLICK, nextSkinHandler);
					break;
				case "backarrow_btn" :
					Button.addEventListener(MouseEvent.CLICK, backSkinHandler );
					break;
				case "playpause_btn" :
					Button.addEventListener(MouseEvent.CLICK, playpauseHandler);
					break;
				case "audio_mute_btn" :
					Button.addEventListener(MouseEvent.CLICK, muteHandler);
					break;
				case "next_btn" :
					Button.addEventListener(MouseEvent.CLICK, nextHandler);
					break;
				case "stop_btn" :
					Button.addEventListener(MouseEvent.CLICK, stopHandler);
					break;
				case "back_btn" :
					Button.addEventListener(MouseEvent.CLICK, backHandler);
					break;
				case "favon_btn" :
					Button.addEventListener(MouseEvent.CLICK, favonHandler);
					break;
				case "favoff_btn" :
					Button.addEventListener(MouseEvent.CLICK, favoffHandler);
					break;
				case "searchBtn" :
					Button.addEventListener(MouseEvent.CLICK, srchpopHandler);
					break;
				case "FavBtn" :
					Button.addEventListener(MouseEvent.CLICK, favpopHandler);
					break;
			}
		}
		public function playMode() {
			if (parent_mc.shuffle) {
				parent_mc.mp3Controls_mc.shuffle_mc.shuffleon_btn.visible =true;
				parent_mc.mp3Controls_mc.shuffle_mc.shuffleoff_btn.visible =false;
				parent_mc.shuffle = false;
			} else {
				parent_mc.mp3Controls_mc.shuffle_mc.shuffleon_btn.visible =false;
				parent_mc.mp3Controls_mc.shuffle_mc.shuffleoff_btn.visible =true;
				parent_mc.shuffle = true;
			}
		}
		public function fnopenAbout() {
			parent_mc.mutebtn.removeSkin();
			parent_mc.skinSelected = 0;
			parent_mc.mutebtn.changeSkin();
			parent_mc.mutebtn.fnclosePop();
			parent_mc.currentPop = parent_mc.aboutPop;
			parent_mc.aboutPop.gotoAndStop(2);
			if (!parent_mc.trialVer) {
				parent_mc.aboutPop.instructions.text ="";
			}
		}
		public function openPlaylistFile(fileName:String) {
			parent_mc.playListFile = fileName;
			parent_mc.openPlayList(parent_mc.playListFile);
		}
		public function fnTogglePl() {
			parent_mc.list_mc.play();
			if (parent_mc.list_mc.currentFrame !=1) {
				parent_mc.ListOpen =true;
			} else {
				parent_mc.ListOpen =false ;
			}
			parent_mc.mutebtn.changeSkin();
		}
		public function fnclosePop() {
			if (parent_mc.currentPop == parent_mc.searchPop) {
				parent_mc.addChidFocus();
				parent_mc.searchPop.resultList.dataProvider=  new DataProvider();
				parent_mc.searchPop.search.text =""  ;
			}
			parent_mc.currentPop.gotoAndStop(1);
			parent_mc.addChidComFocus();
		}
		public function fnopenPL() {
			fnclosePop();
			parent_mc.fs = new fileselect(parent_mc);
		}
		public function bookmarkSong() {
			if (parent_mc.mp3Controls_mc.fav_mc.favon_btn.visible) {
				parent_mc.favArr.push(parent_mc.curSongInd);
				parent_mc.soEx.saveValue(parent_mc.favArr);
				parent_mc.mp3Controls_mc.fav_mc.favon_btn.visible = false;
				//parent_mc.fnFavList()
			}
		}
		public function delbookmarkSong() {
			if (!parent_mc.mp3Controls_mc.fav_mc.favon_btn.visible) {
				var tSrArr = parent_mc.favArr.searchExact(parent_mc.curSongInd);
				var tmpArr = parent_mc.favArr.splice(tSrArr,1);
				parent_mc.soEx.saveValue(parent_mc.favArr); 
			}
		}
		private function handleComplete(event:Event):void {
			var Page_mc:* =bgLoader.content;
			Page_mc.gotoAndPlay(1);
		}
		public function changeSkin() {
			switch (parent_mc.skinSelected) {
				case 0 :
					parent_mc.map0.x= 0;
					parent_mc.map0.y= 120;
					parent_mc.visText.text = "The F3";
					bgLoader.load(new URLRequest("logo.swf"));
					parent_mc.map0.addChild(bgLoader);
					bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,handleComplete);
					break;
				case 1 :
					if (parent_mc.snd1 == undefined) {
						parent_mc.snd1 =new Spectrum(parent_mc,512,400);
						parent_mc.maps.addChild(parent_mc.snd1);
						parent_mc.snd1.gradient = parent_mc.snd1.createRainbowGradientArray();
					} else {
						parent_mc.snd1.x=0;
						parent_mc.snd1.y=holdY;
						parent_mc.maps.x= 0;
						parent_mc.maps.y= holdY;
					}
					if (!parent_mc.ListOpen) {
						parent_mc.maps.width = 700;
					} else {
						parent_mc.maps.width = 512;
					}
					parent_mc.visText.text = "Color Spectrum";
					parent_mc.colorPickers_mc.visible =true;
					parent_mc.colorPickers_mc.colorPickers.color4.visible =true;
					break;
				case 2 :
					if (parent_mc.snd2 == undefined) {
						parent_mc.snd2 =new SpectrumAnalyzer(270,220,parent_mc);
						parent_mc.map2.addChild(parent_mc.snd2);
					} else {
						parent_mc.snd2.x=0;
						parent_mc.snd2.y=holdY;
						parent_mc.map2.x= 0;
						parent_mc.map2.y= holdY;
					}
					if (!parent_mc.ListOpen) {
						parent_mc.map2.x=100;
					} else {
						parent_mc.map2.x= 0;
					}
					parent_mc.visText.text = "Spikes";
					break;
				case 3 :
					if (parent_mc.snd3 == undefined) {
						parent_mc.snd3 =new SoundSpectrum(parent_mc,20,400);
						parent_mc.map3.addChild(parent_mc.snd3);
					} else {
						parent_mc.snd3.x=0;
						parent_mc.snd3.y=holdY;
						parent_mc.map3.x= 0;
						parent_mc.map3.y= holdY;
						parent_mc.map3.addChild(parent_mc.snd3.gr);
					}
					if (!parent_mc.ListOpen) {
						parent_mc.map3.x= 80;
					} else {
						parent_mc.map3.x= 0;
					}
					parent_mc.visText.text = "Bars";
					parent_mc.colorPickers_mc.visible =true;
					parent_mc.colorPickers_mc.colorPickers.color4.visible =false;
					break;
				case 4 :
					if (parent_mc.snd4 == undefined) {
						parent_mc.snd4 =new SpectrumBeam(0,0,parent_mc);
						parent_mc.map4.addChild(parent_mc.snd4);
					} else {
						parent_mc.snd4.x=0;
						parent_mc.snd4.y=holdY;
						parent_mc.map4.x= 0;
						parent_mc.map4.y= holdY;
						parent_mc.map4.addChild(parent_mc.snd4.efxStageBmp);
					}
					if (!parent_mc.ListOpen) {
						parent_mc.map4.width= 700;
					} else {
						parent_mc.map4.width =550;
					}
					parent_mc.visText.text = "Ambience";
					break;
				case 5 :
					if (parent_mc.snd5 == undefined) {
						parent_mc.snd5 =new SpectrumMc(parent_mc,52);
						parent_mc.map5.addChild(parent_mc.snd5);
					} else {
						parent_mc.snd5.x=0;
						parent_mc.snd5.y=holdY;
						parent_mc.map5.x= 0;
						parent_mc.map5.y= -100;
						//parent_mc.map5.addChild(parent_mc.snd5.efxStageBmp);
					}
					if (!parent_mc.ListOpen) {
						parent_mc.map5.width= 600;
					} else {
						parent_mc.map5.width = 450;
					}
					parent_mc.visText.text = "Beats";
					break;
			}
		}
		public function removeSkin() {
			switch (parent_mc.skinSelected) {
				case 0 :
					bgLoader.unload();
					parent_mc.map0.x= hideX;
					parent_mc.map0.y= hideX;
					break;
				case 1 :
					parent_mc.snd1.x= hideX;
					parent_mc.snd1.y= hideX;
					parent_mc.maps.x= hideX;
					parent_mc.maps.y= hideX;
					parent_mc.colorPickers_mc.visible =false;
					break;
				case 2 :
					parent_mc.snd2.x= hideX;
					parent_mc.snd2.y= hideX;
					parent_mc.map2.x= hideX;
					parent_mc.map2.y= hideX;
					break;
				case 3 :
					parent_mc.snd3.x= hideX;
					parent_mc.snd3.y= hideX;
					parent_mc.map3.x= hideX;
					parent_mc.map3.y= hideX;
					parent_mc.colorPickers_mc.visible =false;
					parent_mc.map3.removeChild(parent_mc.snd3.gr);
					break;
				case 4 :
					parent_mc.snd4.x= hideX;
					parent_mc.snd4.y= hideX;
					parent_mc.map4.x= hideX;
					parent_mc.map4.y= hideX;
					parent_mc.map4.removeChild(parent_mc.snd4.efxStageBmp);
					break;
				case 5 :
					parent_mc.snd5.x= hideX;
					parent_mc.snd5.y= hideX;
					parent_mc.map5.x= hideX;
					parent_mc.map5.y= hideX;
					//parent_mc.map5.removeChild(parent_mc.snd5.efxStageBmp);
					break;
			}
		}
		public function backSong() {
			if (parent_mc.curPlaying==0) {
				parent_mc.mp3Controls_mc.back_btn.gotoAndStop(1);
			} else {
				trace(parent_mc.curPlaying);
				parent_mc.curPlaying--;
				var tempXML:XML = new XML("<Song>"+parent_mc.songListArr[parent_mc.playArr[parent_mc.curPlaying]]+"</Song>");
				parent_mc.playNext(tempXML);
				if (parent_mc.curPlaying==0) {
					parent_mc.mp3Controls_mc.back_btn.gotoAndStop(1);
				}
			}
		}
		public function stopSong() {
			parent_mc.pausedPlay = true;
			parent_mc.mp3Controls_mc.stop_mc.stop_btn.visible =false;
			parent_mc.snf.sc.stop();
			parent_mc.mp3Controls_mc.playpause_btn.play_mc.visible = true;
			parent_mc.snf.isPlaying = false;
			parent_mc.mp3Controls_mc.track_mc.value= 0;
			parent_mc.snf.sc.stop();
			parent_mc.snf.sc = new SoundChannel();
		}
		public function muteSong() {
			if (audioOn) {
				parent_mc.snf.setVolume(0);
				audioOn = false;
				parent_mc.mp3Controls_mc.audio_mute_btn.on_mc.visible =audioOn;
			} else {
				parent_mc.snf.setVolume(parent_mc.slider.SliderVal);
				audioOn = true;
				parent_mc.mp3Controls_mc.audio_mute_btn.on_mc.visible =audioOn;
			}
		}
		public function playpauseSong() {
			if (parent_mc.snf.isPlaying) {
				parent_mc.pausedPlay = true;
				parent_mc.snf.sc.stop();
				parent_mc.mp3Controls_mc.playpause_btn.play_mc.visible = true;
				parent_mc.snf.isPlaying = false;
			} else {
				parent_mc.pausedPlay = false;
				var pos = parent_mc.snf.sc.position;
				if (!audioOn) {
					parent_mc.snf.play(pos);
					parent_mc.snf.setVolume(0);
				} else {
					parent_mc.snf.play(pos);
				}
				parent_mc.mp3Controls_mc.playpause_btn.play_mc.visible = false;
				parent_mc.snf.isPlaying = true;
			}
			parent_mc.mp3Controls_mc.stop_mc.stop_btn.visible =true;
		}
		public function nextSong() {
			var tempXML:XML;
			if (parent_mc.curPlaying==parent_mc.playArr.length-1) {
				var tno;
				if (parent_mc.shuffle) {
					tno = Math.floor(Math.random() * parent_mc.songListArr.length);
					tempXML= new XML("<Song>"+parent_mc.songListArr[tno]+"</Song>");
					parent_mc.playArr.push(tno);
				} else {
					if (parent_mc.list_mc.list_mc.songList.selectedIndex != parent_mc.list_mc.list_mc.songList.length-1) {
						parent_mc.list_mc.list_mc.songList.selectedIndex++;
					} else {
						parent_mc.list_mc.list_mc.songList.selectedIndex =0;
					}
					tempXML= new XML("<Song>"+parent_mc.list_mc.list_mc.songList.selectedItem.filename+"</Song>");
					var tsrch =parent_mc.songListArr.search(parent_mc.list_mc.list_mc.songList.selectedItem.filename);
					parent_mc.playArr.push(tsrch[0]);
				}
				parent_mc.curPlaying = parent_mc.playArr.length-1;
			} else {
				parent_mc.curPlaying++;
				tempXML = new XML("<Song>"+parent_mc.songListArr[parent_mc.playArr[parent_mc.curPlaying]]+"</Song>");
			}
			if (parent_mc.curPlaying==0) {
				parent_mc.mp3Controls_mc.back_btn.gotoAndStop(1);
			} else {
				parent_mc.mp3Controls_mc.back_btn.gotoAndStop(2);
			}
			parent_mc.playNext(tempXML);
		}
		private function muteHandler(event:MouseEvent):void {
			muteSong();
			parent_mc.SetStageFocus();
		}
		private function playpauseHandler(event:MouseEvent):void {
			playpauseSong();
			parent_mc.SetStageFocus();
		}
		private function nextHandler(event:MouseEvent):void {
			nextSong();
			parent_mc.SetStageFocus();
		}
		private function stopHandler(event:MouseEvent):void {
			stopSong();
			parent_mc.SetStageFocus();
		}
		private function backHandler(event:MouseEvent):void {
			backSong();
			parent_mc.SetStageFocus();
		}
		private function favonHandler(event:MouseEvent):void {
			bookmarkSong();
			parent_mc.SetStageFocus();
		}
		private function favoffHandler(event:MouseEvent):void {
			delbookmarkSong();
			parent_mc.SetStageFocus();
		}
		private function nextSkinHandler(event:MouseEvent):void {
			parent_mc.mutebtn.removeSkin();
			if (parent_mc.skinSelected==5) {
				parent_mc.skinSelected =0;
			} else {
				parent_mc.skinSelected++;
			}
			parent_mc.mutebtn.changeSkin();
			parent_mc.SetStageFocus();
		}
		private function backSkinHandler(event:MouseEvent):void {
			parent_mc.mutebtn.removeSkin();
			if (parent_mc.skinSelected==0) {
				parent_mc.skinSelected =5;
			} else {
				parent_mc.skinSelected--;
			}
			parent_mc.mutebtn.changeSkin();
			parent_mc.SetStageFocus();
		}
		private function focusHandler(event:MouseEvent):void {
			parent_mc.mutebtn.removeSkin();
			if (parent_mc.skinSelected==5) {
				parent_mc.skinSelected =0;
			} else {
				parent_mc.skinSelected++;
			}
			parent_mc.mutebtn.changeSkin();
			parent_mc.SetStageFocus();
		}
		public function focusDetHandler(event:MouseEvent):void {
			parent_mc.ismouseOver = true;
			if (parent_mc.snf!= undefined) {
				parent_mc.filePath.text ="FilePath : "+parent_mc.snf.url;
			}
			parent_mc.SetStageFocus();
		}
		public function focusOutHandler(event:MouseEvent):void {
			parent_mc.ismouseOver = false;
			parent_mc.filePath.text ="";
			parent_mc.SetStageFocus();
		}
		private function openPLHandler(event:MouseEvent):void {
			fnopenPL();
			parent_mc.SetStageFocus();
		}
		private function fClsHandler(event:MouseEvent):void {
			fnclosePop();
		}
		private function sClsHandler(event:MouseEvent):void {
			fnclosePop();
		}
		private function srchpopHandler(event:MouseEvent):void {
			fnclosePop();
			parent_mc.currentPop = parent_mc.searchPop;
			parent_mc.searchPop.gotoAndStop(2);
			parent_mc.removeChidFocus();
			parent_mc.srchFocus();
		}
		private function favpopHandler(event:MouseEvent):void {
			fnclosePop();
			parent_mc.fnFavList();
			parent_mc.currentPop = parent_mc.favPop;
			parent_mc.favPop.gotoAndStop(2);
		}
		private function listOpenHandler(event:MouseEvent):void {
			fnTogglePl();
		}
		private function plistOpenHandler(event:MouseEvent):void {
			fnopenPL();
		}
		private function LogoOpenHandler(event:MouseEvent):void {
			fnopenAbout();
		}
		private function shuffleonHandler(event:MouseEvent):void {
			playMode();
		}
		private function shuffleoffHandler(event:MouseEvent):void {
			playMode();
		}
		public function registerHandler(event:MouseEvent):void {
			var productId =parent_mc.registerPop.prodID.text;
			var userName=parent_mc.registerPop.uname.text;
			parent_mc.saveProductId(productId,userName);
			parent_mc.checkRegistration();
		}
	}
}