// constants for the different "states" of the song form
var ADD_SONG:uint = 1;
var SONG_DETAIL:uint = 2;
var playList:PlayList = new PlayList();
// set the initial state of the song form, for adding a new song
var url:String;
var playArr = new Array();
var curPlaying:Number = 0;
//Load the text.
var loadit:URLLoader = new URLLoader();
loadit.addEventListener(Event.COMPLETE, completeHandler);
loadit.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
var songListArr = new Array();
function songSelectionChange(e:Event):void {
	playArr.push(list_mc.list_mc.songList.selectedIndex);
	curPlaying = playArr.length-1;
	if (curPlaying==0) {
		mp3Controls_mc.back_btn.gotoAndStop(1);
	} else {
		mp3Controls_mc.back_btn.gotoAndStop(2);
	}
	playNext(list_mc.list_mc.songList.selectedItem.filename);
}
function ioErrorHandler(event:IOErrorEvent):void { 
    openPlayList('c:\dir.txt') 
}
function playNext(url:String) {
	if(ismouseOver){
		filePath.text ="FilePath : "+url
	}
	var tsrch =songListArr.search(url)
	curSongInd = tsrch[0] 
	list_mc.list_mc.songList.selectedIndex =  sortedsongs.searchExact(url)
	list_mc.list_mc.songList.scrollToIndex(sortedsongs.searchExact(url)) 	
	var tSrArr = favArr.searchExact(curSongInd) 
	if(tSrArr==null){
		mp3Controls_mc.fav_mc.favon_btn.visible = true
	}else{
		mp3Controls_mc.fav_mc.favon_btn.visible = false
	}
	snf.playTimer.reset();
	snf.sc.stop();
	snf.loadurl(url);
	pausedPlay =false;
	snf.ChangePos(0);
}
function songListLabel(item:Object):String {
	SetStageFocus();
	return item.toString();
}
function openPlayList(url){  
	loadit.load(new URLRequest(url));
}
list_mc.list_mc.songList.addEventListener(Event.CHANGE, songSelectionChange);
list_mc.list_mc.songList.labelFunction = songListLabel;
