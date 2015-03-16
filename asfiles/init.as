import fl.data.DataProvider;
import flash.events.MouseEvent;
import flash.text.TextFormat;
import fl.controls.ColorPicker;
import fl.events.ColorPickerEvent;
import classes.md53;
import classes.PlayList;
import classes.Song;
import classes.SortProperty;
import classes.SpectrumAnalyzer;
import classes.SoundFacade;
import classes.SharedObjects;
import classes.sliderControl;
import classes.buttonControl;
import classes.XmlMenu;
stage.scaleMode = StageScaleMode.NO_SCALE;
var fs;
var snf;
var snd1;
var snd2;
var snd3;
var snd4;
var snd5;
var sortedsongs:Array;
var ismouseOver:Boolean;
var skinSelected:Number;
var curSongInd:Number;
var pausedPlay:Boolean = false;
var shuffle:Boolean = true;
var trialVer:Boolean =true;
var ListOpen:Boolean = true;
var playListFile:String;
var currentPop:MovieClip;
var systemId:Number;
var productId:String;
var userName:String;
var installTime:Date = new Date();
systemId =installTime.valueOf();
var mysIDSo:SharedObject;
var mypIDSo:SharedObject;
mysIDSo=SharedObject.getLocal("systemId");
function saveSystemId(systemId:Number) {
	mysIDSo.data.systemId=systemId;
}
if (mysIDSo.data.systemId==undefined) {
	saveSystemId(systemId);
}
mypIDSo=SharedObject.getLocal("pIdandName");
function saveProductId(productId:String,userName:String) {
	mypIDSo.data.productId=productId;
	mypIDSo.data.userName=userName;
}
function keepUnreg() {
	if (mypIDSo.data.productId==undefined) {
		mypIDSo.data.productId = "";
		mypIDSo.data.userName ="not registered";
	}
}
var child:Sprite=new Sprite;
addChild(child);
function SetStageFocus() {
	stage.focus=child;
}
function checkRegistration() {
	keepUnreg();
	userName=mypIDSo.data.userName;
	var pkey:String = mysIDSo.data.systemId;
	var out = new md53(userName,pkey);
	if (out.output == mypIDSo.data.productId) {
		trialVer =false;
		registerPop.instructions.text ="You have registered successfully";
		registerPop.uname.type = TextFieldType.DYNAMIC;
		registerPop.prodID.type = TextFieldType.DYNAMIC;
		registerPop.uname.text =userName;
		registerPop.prodID.text =mypIDSo.data.productId;
		registerPop.register_btn.visible =false;
	} else {
		trialVer =true;
		registerPop.gotoAndStop(1);
		SetStageFocus();
	}
}
checkRegistration();
aboutPop.sysID.text = mysIDSo.data.systemId;
registerPop.sysID.text = mysIDSo.data.systemId;
currentPop = aboutPop;
skinSelected = 4;
include "proto.as"
include "list.as"
include "btncntrls.as"
include "helptext.as"
include "ctxtmenu.as"
include "favourites.as"
include "search.as"
include "keybrd.as"
stop();