var hlpdp:DataProvider = new DataProvider();
hlpdp.addItem( { keys:"0-5", functions:"Visualizations" } );
hlpdp.addItem( { keys:"F2", functions:"Favourites" } );
hlpdp.addItem( { keys:"F7", functions:"Shortcuts" } );
hlpdp.addItem( { keys:"F8", functions:"Search" } );
hlpdp.addItem( { keys:"F9", functions:"Open playlist" } );
hlpdp.addItem( { keys:"F12", functions:"About F3" } );
hlpdp.addItem( { keys:"Enter", functions:"Toggle Playlist" } );
hlpdp.addItem( { keys:"Insert", functions:"Add to Favourites" } );
hlpdp.addItem( { keys:"Delete", functions:"Del from Favourites" } );
hlpdp.addItem( { keys:"Home", functions:"Play / Pause" } );
hlpdp.addItem( { keys:"End", functions:"Stop" } );
hlpdp.addItem( { keys:"PgUp", functions:"Back" } );
hlpdp.addItem( { keys:"PgDown / Space", functions:"Next Song" } );
hlpdp.addItem( { keys:"Left Arrow", functions:"Rewind" } );
hlpdp.addItem( { keys:"Right Arrow", functions:"Forward" } );
hlpdp.addItem( { keys:"Up Arrow", functions:"Volume +" } );
hlpdp.addItem( { keys:"Down Arrow", functions:"Volume -" } );
hlpdp.addItem( { keys:"Ctrl + S", functions:"Toggle Shuffle" } );
hlpdp.addItem( { keys:"Ctrl + M", functions:"Audio On/Off" } );
help_mc.hList1.dataProvider = help_mc.hList2.dataProvider= hlpdp
help_mc.hList1.labelField = "keys"
help_mc.hList2.labelField = "functions"