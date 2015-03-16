function completeHandler(event:Event):void { 
	var newArr = new Array();		 
	var my_txts = new String();
	songListArr= new Array();	 	
	my_txts = event.currentTarget.data as String;
	my_txts = escape(my_txts);
	newArr = my_txts.split("%0A");
	my_txts = unescape(my_txts);
	for (var i=0; i<newArr.length; i++) {
		newArr[i] = unescape(newArr[i])		
	}  
	playList.emptySongs()
	for each (var mp3Path:String in newArr) {
		if ((mp3Path!="") && (mp3Path.indexOf("function")==-1) && (mp3Path.indexOf(".mp3")!=-1)){
			var tempXML:XML = new XML("<Song>"+mp3Path+"</Song>"); 
			songListArr.push(mp3Path)
			var tstr = tempXML.toString()
			tstr = tstr.slice(tstr.lastIndexOf("/")+1,tstr.lastIndexOf("."));
			playList.addSong(new Song(tstr, "", 2007,tempXML, ["mp3", "mp3"]));
		}		
	} 
	list_mc.list_mc.songList.dataProvider = new DataProvider(playList.songList); 
	sortedsongs = new Array()
	for (i=0; i<playList.songList.length; i++) {
		  sortedsongs.push(playList.songList[i].filename)
	}
	var tno
	if(shuffle){
		tno = Math.floor(Math.random() * songListArr.length);
	}else{
		list_mc.list_mc.songList.selectedIndex =0;
		var tsrch =songListArr.search(list_mc.list_mc.songList.selectedItem.filename)
		tno =tsrch[0]
	}
	playArr.push(tno) 
	mp3Controls_mc.back_btn.gotoAndStop(1);
	curSongInd = tno
	tempXML = new XML("<Song>"+songListArr[tno]+"</Song>"); 	
	list_mc.list_mc.songList.selectedIndex =  sortedsongs.searchExact(tempXML)
	list_mc.list_mc.songList.scrollToIndex(sortedsongs.searchExact(tempXML)) 
	if(snf==undefined){
		snf= new SoundFacade(tempXML,this); 
	}else{
		playNext(tempXML)
	}
	createSobjClass()
}
Array.prototype.search = function (searchElement):Array {
 	var searchResults:Array = new Array();
	var resultsFound:Boolean = false;
	for (var index:String in this){
		var strInd = this[index].toString()
		if (strInd.indexOf(searchElement)!=-1){
			resultsFound = true;
			searchResults.push(index);
		}
	}
	if (resultsFound) { 
		return(searchResults);
	}
	return(null);
}
Array.prototype.searchExact = function (searchElement):Array {
 	var searchResultsExact:Array = new Array();
	var resultsFoundExact:Boolean = false;
	for (var indexExact:String in this){
		var strIndExact = this[indexExact].toString()
		if (strIndExact==searchElement){
			resultsFoundExact = true;
			searchResultsExact.push(indexExact);
		}
	}
	if (resultsFoundExact) { 
		return(searchResultsExact);
	}
	return(null);
} 
var FavSo:SharedObject;
function createSobjClass() {
	favArr = new Array();
	FavSo = new SharedObject
	soEx = new SharedObjects(this,FavSo) ;
 	if (soEx.mySo.data.savedValue!=undefined) {
		favArr =soEx.mySo.data.savedValue;
	}  
}