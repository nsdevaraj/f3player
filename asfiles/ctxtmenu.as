var myMenu:ContextMenu = new ContextMenu();
var menuObj:ContextMenu;
myMenu.hideBuiltInItems();
myMenu.addEventListener(ContextMenuEvent.MENU_SELECT, menuSelectHandler);
function menuSelectHandler(event:ContextMenuEvent):void {
	var obj:DisplayObject = event.contextMenuOwner as DisplayObject;
	menuObj = event.currentTarget as ContextMenu;
	EmptyContextMenu(menuObj);
	FillContextMenu(menuObj);
}
function FillContextMenu(menuObj) {
	menuObj.customItems.push(OpenItem);
	menuObj.customItems.push(SearchItem);
	menuObj.customItems.push(ShortcutKeysItem);
	menuObj.customItems.push(FavItem);
	menuObj.customItems.push(RegisterItem);
	menuObj.customItems.push(AboutItem);
}
function EmptyContextMenu(menuObj) {
	menuObj.customItems = [];
}
var OpenItem:ContextMenuItem = new ContextMenuItem("Open Playlist");
var AboutItem:ContextMenuItem = new ContextMenuItem("About ƒ3");
var RegisterItem:ContextMenuItem = new ContextMenuItem("Regsiter ƒ3");
var ShortcutKeysItem:ContextMenuItem = new ContextMenuItem("Shortcuts");
var SearchItem:ContextMenuItem = new ContextMenuItem("Search");
var FavItem:ContextMenuItem = new ContextMenuItem("Favourites");
RegisterItem.separatorBefore =true;
OpenItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
SearchItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
FavItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
AboutItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
RegisterItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
ShortcutKeysItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, menuItemSelectHandler);
function menuItemSelectHandler(event:ContextMenuEvent):void {
	handleMenuCommand(event.contextMenuOwner, event.currentTarget);
}
function handleMenuCommand(obj:Object, item:Object):void {
	switch (item.caption) {
		case "Open Playlist" :
			mutebtn.fnopenPL();
			break;
		case "Shortcuts" :
			mutebtn.fnclosePop();
			mainTimeline.currentPop = mainTimeline.help_mc;
			mainTimeline.help_mc.gotoAndStop(2);
			break;
		case "Search" :
			mutebtn.fnclosePop();
			mainTimeline.currentPop = mainTimeline.searchPop;
			mainTimeline.searchPop.gotoAndStop(2);
			mainTimeline.removeChidFocus();
			mainTimeline.srchFocus();
			break;
		case "Favourites" :
			mutebtn.fnclosePop();
			fnFavList();
			mainTimeline.currentPop = mainTimeline.favPop;
			mainTimeline.favPop.gotoAndStop(2);
			break;
		case "Regsiter ƒ3" :
			mutebtn.removeSkin();
			mainTimeline.skinSelected = 0;
			mutebtn.changeSkin();
			mutebtn.fnclosePop();
			mainTimeline.removeChidFocus(); 
			mainTimeline.currentPop = mainTimeline.registerPop;
			if(!mainTimeline.trialVer){
				mainTimeline.registerPop.instructions.text =""	
			}
			mainTimeline.registerPop.gotoAndStop(2);
			break;
		case "About ƒ3" :
			mutebtn.removeSkin();
			mainTimeline.skinSelected = 0;
			mutebtn.changeSkin();
			mutebtn.fnclosePop();
			mainTimeline.currentPop = mainTimeline.aboutPop;
			mainTimeline.aboutPop.gotoAndStop(2);
			if(!mainTimeline.trialVer){
				mainTimeline.aboutPop.instructions.text =""		
			}
			break;
	}
}
var mainTimeline:MovieClip = this;
mainTimeline.contextMenu = myMenu;