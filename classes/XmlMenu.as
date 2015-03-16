package classes{
	import flash.system.fscommand;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class XmlMenu {
		private var menu_xml:XML;
		// typically the variable, m_parent_mc, will point to the main timeline. 
		// This MovieClip will end up being a container for the entire menu, 
		// and where you'll attach your various navigation menu MovieClip instances.
		private var m_parent_mc:MovieClip;
		// the m_menu_array Array holds the references to the main menu movie clips. 
		// This allows you to loop through each main navigation link and hide the dropdown sub-navigation if it is open.
		private var m_menu_array:Array;
		public var thisObj=this;
		public var thisX:Number;
		public var thisY:Number;
		public var subHit:Boolean;
		public var menuHit:Boolean;

		// Constructor, this method takes two parameters, xmlpath_str 
		// (which is the path to the XML file containing the navigation), 
		// and parent_mc (which is a reference to a movie clip/timeline 
		// where you'll attach your various menu items).
		public function XmlMenu(xml_str:XML,parent_mc:MovieClip,mX:Number,mY:Number) {
			this.m_parent_mc=parent_mc;
			this.m_menu_array=new Array  ;
			thisX=mX;
			thisY=mY;
			// call this class' initXML function which parses your XML navigation file.
			menu_xml=xml_str;
			completeXMLHandler();
		}
		// define your function which will be triggered when the XML file has completed loading.
		//private function completeHandler(event:Event):void {
		private function completeXMLHandler() {
			//menu_xml=XML(event.currentTarget.data);
			var menuXMLList:XMLList=menu_xml.menu;
			var nodeXML:XML;
			// create an array which contains the main navigation as well as each menu's sub-navigation links.
			var menu_array:Array=new Array;
			// if the XML file was successfully loaded and parsed,
			// convert it into an array of objects which we can pass to the XmlMenu class' initMenu method.
			var i:Number;
			// for each child node in the XML file (the child nodes here are the main menu navigation items.
			for each (nodeXML in menuXMLList) {
				// create an empty array for sub-navigation items.
				var submenu_array:Array=new Array;
				// for each child node of the main menu items, append the values to our submenu_array.
				var subNodeXML:XML;
				for each (subNodeXML in nodeXML.children()) {
					// append each sub-navigation item to our submenu_array Array.
					// Our XML file specifies the navigation's label and url in attributes rather than child nodes,
					// so if you modify the layout of the navigation XML file this code will need to be modified.
					submenu_array.push({caption:subNodeXML.@name,href:subNodeXML.@href});
				}
				// append each menu items, and it's array of submenu items.
				menu_array.push({caption:nodeXML.@name,href:nodeXML.@href,subnav_array:submenu_array});
			}
			// call the XmlMenu class' initMenu method.
			initMenu(menu_array);
		}
		// this method, initMenu, loops through the menu items and their respective 
		// sub navigation items and builds the movie clips.
		private function initMenu(nav_array:Array):void {
			// create variables which we will use to position the menu items.
			var menuIndex:Number;
			for (menuIndex=0; menuIndex < nav_array.length; menuIndex++) {
				// for each main menu item attach the menu_mc symbol from the library and position it along the x-axis.
				var menuMC:MovieClip=new menu_mc;
				menuMC.buttonMode=true;
				m_parent_mc.addChild(menuMC);
				menuMC.x=thisX;
				menuMC.y=thisY;
				// store the current menu item's information within the MovieClip so you
				// always have a reference to the sub navigation and the current menu item's link
				menuMC.data=nav_array[menuIndex];
				// add a reference to the current menu movie clip in the class' m_menu_array Array.
				m_menu_array.push(menuMC);
				// set the caption on the main menu button.
				menuMC.label_txt.htmlText=menuMC.data.caption;
				menuMC.label_txt.selectable=false;
				menuMC.label_txt.mouseEnabled=false;
				// create a new movie clip on the Stage which will be used to hold the submenu items.
				var subMC:MovieClip=new MovieClip;
				//subMC.buttonMode = true;
				m_parent_mc.addChild(subMC);
				// set the sub menu's X and Y position on the Stage.
				subMC.x=thisX;
				subMC.y=thisY;//menuMC.height;
				// set a variable in the submenu movie clip which stores whether the current sub menu item is visible
				subMC.subMenuVisible=true;
				// call the hideSubMenu method which hides the sub menu item.
				hideSubMenu(subMC);
				// within the sub menu movie clip store a reference to the menu movie clip
				subMC.parentMenu=menuMC;
				// hide the sub menu movie clip on the Stage.
				subMC.visible=false;
				// set a variable which we will use to track the current y-position of the sub-navigation items.
				var yPos:Number=thisY;
				var xPos:Number=- menuMC.data.subnav_array.length * 36;
				var temp_subnav_array:Array=menuMC.data.subnav_array;
				// for each sub menu item, attach a new instance of the link_mc MovieClip from the Library, 
				// set the text for the link and increment the yPos counter.
				var i:Number;
				for (i=0; i < temp_subnav_array.length; i++) {
					var linkMC:MovieClip=new link_mc;
					linkMC.buttonMode=true;
					subMC.addChild(linkMC);
					linkMC.x=0;
					linkMC.y=yPos;
					linkMC.data=temp_subnav_array[i];
					linkMC.label_txt.text=linkMC.data.caption;
					linkMC.label_txt.mouseEnabled=false;
					linkMC.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
					linkMC.addEventListener(MouseEvent.ROLL_OUT,mouseOutHandler);
					yPos+= linkMC.height;

				}
				// draw a slight 1 pixel drop shadow around the sub menu using the drawing API
				var thisWidth:Number=subMC.width + 1;
				var thisHeight:Number=subMC.height + 1;
				subMC.graphics.beginFill(0x000000,0);
				subMC.graphics.moveTo(0,0);
				subMC.graphics.drawRect(0,0,thisWidth,thisHeight);
				subMC.graphics.endFill();
				menuMC.childMenu=subMC;
				thisX+= menuMC.width;
			}
			// define the onRollOver and onRelease for each main menu item.
			var j:Number;
			for (j=0; j < this.m_menu_array.length; j++) {
				var thisMenuItem:MovieClip=m_menu_array[j];
				thisMenuItem.buttonMode=true;
				thisMenuItem.addEventListener(MouseEvent.ROLL_OVER,rollOverHandler);
				thisMenuItem.addEventListener(MouseEvent.MOUSE_UP,rollOverHandler);
				thisMenuItem.addEventListener(MouseEvent.MOUSE_DOWN,rollOverHandler);
			}
		}
		private function rollOverHandler(event:MouseEvent):void {
			showSubMenu(event.currentTarget.childMenu);
		}
		private function mouseOutHandler(event:MouseEvent):void {
			this.m_parent_mc.addEventListener(Event.ENTER_FRAME,EnterFrame);
			var thisMC:MovieClip=this.m_menu_array[0].childMenu as MovieClip;
			subHit=thisMC.hitTestPoint(event.stageX,event.stageY,true);
		}
		private function EnterFrame(event:Event):void {
			if (!subHit && !menuHit) {
				hideAllSubMenus();
				this.m_parent_mc.removeEventListener(Event.ENTER_FRAME,EnterFrame);
			}
		}
		private function mouseUpHandler(event:MouseEvent):void {
			switch (Number(event.currentTarget.data.href)) {
				case 1 :
					this.m_parent_mc.mutebtn.fnopenPL();
					break;
				case 2 :
					this.m_parent_mc.mutebtn.fnclosePop();
					this.m_parent_mc.currentPop=this.m_parent_mc.searchPop;
					this.m_parent_mc.searchPop.gotoAndStop(2);
					this.m_parent_mc.srchFocus();
					this.m_parent_mc.removeChidFocus();
					break;
				case 3 :
					this.m_parent_mc.mutebtn.fnclosePop();
					this.m_parent_mc.currentPop=this.m_parent_mc.help_mc;
					this.m_parent_mc.help_mc.gotoAndStop(2);
					break;
				case 4 :
					this.m_parent_mc.mutebtn.fnclosePop();
					this.m_parent_mc.fnFavList();
					this.m_parent_mc.currentPop=this.m_parent_mc.favPop;
					this.m_parent_mc.favPop.gotoAndStop(2);
					break;
				case 5 :
					this.m_parent_mc.mutebtn.removeSkin();
					this.m_parent_mc.skinSelected = 0;
					this.m_parent_mc.mutebtn.changeSkin();
					this.m_parent_mc.mutebtn.fnclosePop();
				  this.m_parent_mc.removeChidFocus(); 
					this.m_parent_mc.currentPop = this.m_parent_mc.registerPop;
					this.m_parent_mc.registerPop.gotoAndStop(2);
					if (!this.m_parent_mc.trialVer) {
						this.m_parent_mc.registerPop.instructions.text ="";
						this.m_parent_mc.registerPop.register_btn.visible =false
					}
					break;
				case 6 :
					this.m_parent_mc.mutebtn.removeSkin();
					this.m_parent_mc.skinSelected = 0;
					this.m_parent_mc.mutebtn.changeSkin();
					this.m_parent_mc.mutebtn.fnclosePop();
					this.m_parent_mc.currentPop=this.m_parent_mc.aboutPop;
					this.m_parent_mc.aboutPop.gotoAndStop(2);
					if (!this.m_parent_mc.trialVer) {
						this.m_parent_mc.aboutPop.instructions.text ="";
					}
					break;
				case 7 :
					fscommand("quit");
					break;
			}
			hideAllSubMenus();
		}
		// the showSubMenu method displays the specified sub menu movie clip
		private function showSubMenu(target_mc:MovieClip):void {
			// create a reference to the current class.
			var thisObj=this;
			if (! target_mc.subMenuVisible) {
				target_mc.visible=true;
				target_mc.subMenuVisible=true;
				target_mc.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			}
		}
		private function mouseMoveHandler(event:MouseEvent):void {
			var thisMC:MovieClip=event.currentTarget  as  MovieClip;
			// hit test both the main menu item, and the submenu to see if the mouse is over either one of them.
			subHit=thisMC.hitTestPoint(event.stageX,event.stageY,true);
			menuHit=thisMC.parentMenu.hitTestPoint(event.stageX,event.stageY,true);
		}
		// hide the specified sub menu Movie Clip, if it is visible.
		private function hideSubMenu(target_mc:MovieClip):void {
			if (target_mc.subMenuVisible) {
				target_mc.visible=false;
				target_mc.subMenuVisible=false;
			}
		}
		// hide the sub menu for each menu item in the m_menu_array Array.
		public function hideAllSubMenus():void {
			var i:int;
			for (i=0; i < this.m_menu_array.length; i++) {
				hideSubMenu(this.m_menu_array[i].childMenu);
			}
		}
		// toggle a specific menu's visibility.
		private function toggleSubMenu(target_mc:MovieClip):void {
			target_mc.subMenuVisible?hideSubMenu(target_mc):showSubMenu(target_mc);
		}
	}
}