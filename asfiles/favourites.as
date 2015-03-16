var favdpArr:Array;
var favArr:Array = new Array()
var soEx 
function JumptoFavSong(e:Event):void {
	playArr.push(favArr[favPop.favList.selectedIndex]);
	curPlaying = playArr.length-1;
	if (curPlaying==0) {
		mp3Controls_mc.back_btn.gotoAndStop(1);
	} else {
		mp3Controls_mc.back_btn.gotoAndStop(2);
	}
	var tempXML:XML = new XML("<song>"+songListArr[favArr[favPop.favList.selectedIndex]]+"</song>");
	playNext(tempXML);
	favPop.gotoAndStop(1);
	SetStageFocus();
}
function fnFavList() {
	favdpArr = new Array();
	for each (var index in favArr) {
		if (typeof (songListArr[index]) == "string") {
			var tstr:String = songListArr[index];
			tstr = tstr.slice(tstr.lastIndexOf("\\")+1,tstr.lastIndexOf("."));
			favdpArr.push(tstr);
		}
	}
	if (favdpArr.length>0) {
		favPop.favList.dataProvider =  new DataProvider(favdpArr);
	} else {
		favPop.favList.dataProvider=  new DataProvider();
	}
	favPop.favList.addEventListener(Event.CHANGE, JumptoFavSong);
}