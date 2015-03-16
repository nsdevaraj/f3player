focus_mc.addEventListener(MouseEvent.CLICK, focusHandler);
focus_mc.addEventListener(MouseEvent.MOUSE_OVER, focusDetHandler);
focus_mc.addEventListener(MouseEvent.MOUSE_OUT, focusOutHandler);
nextarrow_btn.addEventListener(MouseEvent.CLICK, nextSkinHandler);
backarrow_btn.addEventListener(MouseEvent.CLICK, backSkinHandler);
function nextSkinHandler(event:MouseEvent):void {
	mutebtn.removeSkin();
	if (skinSelected==5) {
		skinSelected =0;
	} else {
		skinSelected++;
	}
	mutebtn.changeSkin();
	SetStageFocus();
}
function backSkinHandler(event:MouseEvent):void {
	mutebtn.removeSkin();
	if (skinSelected==0) {
		skinSelected =5;
	} else {
		skinSelected--;
	}
	mutebtn.changeSkin();
	SetStageFocus();
}
function focusHandler(event:MouseEvent):void {
	mutebtn.removeSkin();
	if (skinSelected==5) {
		skinSelected =0;
	} else {
		skinSelected++;
	}
	mutebtn.changeSkin();
	SetStageFocus();
}
function focusDetHandler(event:MouseEvent):void {
	filePath.text ="FilePath : "+snf.url
}
function focusOutHandler(event:MouseEvent):void {
	filePath.text =""
}
mutebtn.changeSkin();
