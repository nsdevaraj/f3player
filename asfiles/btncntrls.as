var slider = new sliderControl(mp3Controls_mc.slider_mc,this);
var pslider = new sliderControl(mp3Controls_mc.panslider_mc,this);
var tslider = new sliderControl(mp3Controls_mc.track_mc,this);
var openBtn = new buttonControl(open_btn,this);
var plausebtn = new buttonControl(mp3Controls_mc.playpause_btn,this);
var nextbtn = new buttonControl(mp3Controls_mc.next_btn,this);
var stopbtn = new buttonControl(mp3Controls_mc.stop_mc.stop_btn,this);
var backbtn = new buttonControl(mp3Controls_mc.back_btn,this);
var favonbtn = new buttonControl(mp3Controls_mc.fav_mc.favon_btn,this);
var mutebtn = new buttonControl(mp3Controls_mc.audio_mute_btn,this);
var favoffbtn = new buttonControl(mp3Controls_mc.fav_mc.favoff_btn,this);
var foucsbtn = new buttonControl(focus_mc,this);
var nextskin = new buttonControl(nextarrow_btn,this);
var backskin = new buttonControl(backarrow_btn,this);
var favclose = new buttonControl(favPop.fcls_btn,this);
var abtclose = new buttonControl(aboutPop.fcls_btn,this);
var hlpclose = new buttonControl(help_mc.fcls_btn,this);
var regclose = new buttonControl(registerPop.fcls_btn,this);
var srcclose = new buttonControl(searchPop.scls_btn,this);
var srcBtn =  new buttonControl(searchBtn,this);
var favrBtn =  new buttonControl(FavBtn,this);
var plUpBtn =  new buttonControl(list_mc.uparrow_btn,this);
var plDwnBtn =  new buttonControl(list_mc.dwnarrow_btn,this);
var logoBtn =  new buttonControl(logo_btn,this);
var shuffleonbtn = new buttonControl(mp3Controls_mc.shuffle_mc.shuffleon_btn,this);
var shuffleoffbtn = new buttonControl(mp3Controls_mc.shuffle_mc.shuffleoff_btn,this);
var registerbtn = new buttonControl(registerPop.register_btn,this);
focus_mc.addEventListener(MouseEvent.MOUSE_OVER, mutebtn.focusDetHandler);
focus_mc.addEventListener(MouseEvent.MOUSE_OUT, mutebtn.focusOutHandler);
colorPickers_mc.visible =false;
colorPickers_mc.colorPickers.color1.addEventListener(ColorPickerEvent.CHANGE, colorHandler);
colorPickers_mc.colorPickers.color2.addEventListener(ColorPickerEvent.CHANGE, colorHandler);
colorPickers_mc.colorPickers.color3.addEventListener(ColorPickerEvent.CHANGE, colorHandler);
colorPickers_mc.colorPickers.color4.addEventListener(ColorPickerEvent.CHANGE, colorHandler);
colorPickers_mc.colorPickers.color1.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, colorsHandler); 
colorPickers_mc.colorPickers.color2.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, colorsHandler); 
colorPickers_mc.colorPickers.color3.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, colorsHandler); 
colorPickers_mc.colorPickers.color4.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, colorsHandler); 
function colorHandler(event:ColorPickerEvent):void { 
	snd1.gradient = snd1.createRainbowGradientArray();
	SetStageFocus();
}
function colorsHandler(event:Event):void {
	stage.removeEventListener(MouseEvent.MOUSE_OVER, SetfocusStage);
}
function SetfocusStage(event:MouseEvent):void {
	SetStageFocus();
}
focus_mc.useHandCursor = false;
var menuXML:XML = new XML("<navigation><menu name=''><submenu name='Open Playlist' href='1' /><submenu name='Search' href='2' /><submenu name='Shortcuts' href='3' /><submenu name='Favourites' href='4' /><submenu name='Register ƒ3' href='5' /><submenu name='About ƒ3' href='6' /><submenu name='Exit' href='7' /></menu></navigation>");
var xmenu = new XmlMenu(menuXML, this,10,10);
mutebtn.changeSkin(); 
var myfSo:SharedObject;
myfSo=SharedObject.getLocal("fileNames");
function saveFileName(fileName:String) {
	myfSo.data.fileName=fileName;
}
if (myfSo.data.fileName==undefined) {
	//fscommand("FFish_Run", "list") 
	openPlayList('c:\dir.txt')
	saveFileName('c:\dir.txt')
	//mutebtn.fnopenPL();
} else { 
	mutebtn.openPlaylistFile(myfSo.data.fileName)
} 