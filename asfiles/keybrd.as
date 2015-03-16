function keyUpHandler(event:KeyboardEvent):void {
	switch (event.keyCode) {
		case 27 :
			mutebtn.fnclosePop();
			break;
		case 32 :
			mutebtn.nextSong();
			break;
		case 33 :
			if (curPlaying!=0) {
				mutebtn.backSong();
			}
			break;
		case 34 :
			mutebtn.nextSong();
			break;
		case 35 :
			mutebtn.stopSong();
			break;
		case 36 :
			mutebtn.playpauseSong();
			break;
		case 45 :
			mutebtn.bookmarkSong();
			break;
		case 46 :
			mutebtn.delbookmarkSong();
			break;
		case 48 :
			mutebtn.removeSkin();
			skinSelected =0;
			mutebtn.changeSkin();
			break;
		case 49 :
			mutebtn.removeSkin();
			skinSelected =1;
			mutebtn.changeSkin();
			break;
		case 50 :
			mutebtn.removeSkin();
			skinSelected =2;
			mutebtn.changeSkin();
			break;
		case 51 :
			mutebtn.removeSkin();
			skinSelected =3;
			mutebtn.changeSkin();
			break;
		case 52 :
			mutebtn.removeSkin();
			skinSelected =4;
			mutebtn.changeSkin();
			break;
		case 53 :
			mutebtn.removeSkin();
			skinSelected =5;
			mutebtn.changeSkin();
			break;
		case 113 :
			mutebtn.fnclosePop();
			fnFavList();
			currentPop = favPop;
			favPop.gotoAndStop(2);
			break;
		case 118 :
			mutebtn.fnclosePop();
			currentPop = help_mc;
			help_mc.gotoAndStop(2);
			break;
		case 119 :
			mutebtn.fnclosePop();
			currentPop = searchPop;
			searchPop.gotoAndStop(2);
			removeChidFocus();
			srchFocus();
			break;
		case 120 :
			mutebtn.fnopenPL();
			break;
		case 123 :
			mutebtn.removeSkin();
			skinSelected = 0;
			mutebtn.changeSkin();
			mutebtn.fnclosePop();
			currentPop = aboutPop;
			aboutPop.gotoAndStop(2);
			if(!trialVer){
				aboutPop.instructions.text =""		
			}
			break;
		default :
			//trace(event.keyCode);
			break;
	}
}
function keydwnHandler(event:KeyboardEvent):void {
	switch (event.keyCode) {
		case 13 :
			mutebtn.fnTogglePl();
			break;
		case 37 :
			mp3Controls_mc.track_mc.value--;
			var Pos= ((mp3Controls_mc.track_mc.value *snf.totalplayTime)/100);
			snf.ChangePos(Pos);
			break;
		case 38 :
			mp3Controls_mc.slider_mc.value++;
			var uSliderVal = mp3Controls_mc.slider_mc.value/100;
			slider.SliderVal = uSliderVal;
			snf.setVolume(uSliderVal);
			break;
		case 39 :
			mp3Controls_mc.track_mc.value++;
			var pPos= ((mp3Controls_mc.track_mc.value *snf.totalplayTime)/100);
			snf.ChangePos(pPos);
			break;
		case 40 :
			mp3Controls_mc.slider_mc.value--;
			var SliderVal = mp3Controls_mc.slider_mc.value/100;
			slider.SliderVal = SliderVal;
			snf.setVolume(SliderVal);
			break;
		case 77 :
			if (event.ctrlKey ) {
				mutebtn.muteSong();
			}
			break;
		case 83 :
			if (event.ctrlKey ) {
				mutebtn.playMode();
			}
			break;
		default :
			break;
	}
}
function skeyUpHandler(event:KeyboardEvent):void {
	switch (event.keyCode) {
		case 27 :
			mutebtn.fnclosePop();
			break;
			/*case 40 :
			stage.focus = searchPop.resultlist;
			break;*/
		default :
			break;
	}
}
function removeChidFocus() {
	stage.removeEventListener(MouseEvent.MOUSE_OVER, SetfocusStage);
	child.removeEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
	child.removeEventListener(KeyboardEvent.KEY_DOWN,keydwnHandler);
	searchPop.search.addEventListener(KeyboardEvent.KEY_UP,skeyUpHandler);
}
function addChidFocus() {
	searchPop.search.addEventListener(KeyboardEvent.KEY_UP,skeyUpHandler); 
	child.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
	child.addEventListener(KeyboardEvent.KEY_DOWN,keydwnHandler);
	stage.addEventListener(MouseEvent.MOUSE_OVER, SetfocusStage);
}
function addChidComFocus() { 
	child.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
	child.addEventListener(KeyboardEvent.KEY_DOWN,keydwnHandler);
	stage.addEventListener(MouseEvent.MOUSE_OVER, SetfocusStage);
}
function srchFocus() {
	stage.focus=searchPop.search;
}
addChidFocus();