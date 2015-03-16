var indArr:Array;
var resdpArr:Array;
searchPop.search.addEventListener(Event.CHANGE, stxtchanged); 
function stxtchanged(e:Event):void {
	indArr = new Array();
	resdpArr = new Array();
	if (searchPop.search.text.length>0) {
		fnsearch((searchPop.search.text).toLowerCase());
	} 
}
function fnsearch(srchstr:String) {
	indArr = songListArr.search(srchstr);
	for each (var index in indArr) {
		if (typeof (songListArr[index]) == "string") { 
		var tstr:String = songListArr[index]  
		tstr = tstr.slice(tstr.lastIndexOf("\\")+1,tstr.lastIndexOf("."));
		resdpArr.push(tstr);
		}
	}   
	if (resdpArr.length>0) {
		searchPop.resultList.dataProvider =  new DataProvider(resdpArr);
	} else {
		searchPop.resultList.dataProvider=  new DataProvider();
	}
	searchPop.resultList.addEventListener(Event.CHANGE, JumptoSong);
}
function JumptoSong(e:Event):void {
	playArr.push(indArr[searchPop.resultList.selectedIndex]);
	curPlaying = playArr.length-1;
	if (curPlaying==0) {
		mp3Controls_mc.back_btn.gotoAndStop(1);
	} else {
		mp3Controls_mc.back_btn.gotoAndStop(2);
	}
	var tempXML:XML = new XML("<song>"+songListArr[indArr[searchPop.resultList.selectedIndex]]+"</song>");
	playNext(tempXML);
	addChidFocus();
	searchPop.resultList.dataProvider=  new DataProvider();
	searchPop.search.text =""
	searchPop.gotoAndStop(1);
	addChidComFocus();
}