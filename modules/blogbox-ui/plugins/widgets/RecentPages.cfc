﻿/**
* A cool basic widget that shows N recent pages
*/
component extends="blogbox.model.ui.BaseWidget" singleton{
	
	RecentPages function init(controller){
		// super init
		super.init(controller);
		
		// Widget Properties
		setPluginName("RecentPages");
		setPluginVersion("1.0");
		setPluginDescription("A cool basic widget that shows N recent pages");
		setPluginAuthor("Luis Majano");
		setPluginAuthorURL("www.ortussolutions.com");
		setForgeBoxSlug("bbwidget-recentpages");
		
		return this;
	}
	
	/**
	* Show n recent pages
	* @max The number of recent pages to show. By default it shows 5
	* @title An optional title to display using an H2 tag.
	* @titleLevel The H{level} to use, by default we use H2
	* @searchTerm The search term to filter on
	*/
	any function renderIt(numeric max=5,title="",titleLevel="2",searchTerm=""){
		var event 			= getRequestContext();
		var bbSettings 		= event.getValue(name="bbSettings",private=true);
		var pageResults 	= pageService.findPublishedPages(max=arguments.max,
											   				 searchTerm=arguments.searchTerm);
		var rString			= "";
		
		// iteration cap
		if( pageResults.count lt arguments.max){
			arguments.max = pageResults.count;
		}
		
		// generate recent pages
		saveContent variable="rString"{
			// title
			if( len(arguments.title) ){ writeOutput("<h#arguments.titleLevel#>#arguments.title#</h#arguments.titleLevel#>"); }
			// UL start
			writeOutput('<ul id="recentPages">');
			// iterate and create
			for(var x=1; x lte arguments.max; x++){
				writeOutput('<li class="recentPages"><a href="#bb.linkPage(pageResults.pages[x])#">#pageResults.pages[x].getTitle()#</a></li>');
			}
			// close ul
			writeOutput("</ul>");
		}
		
		return rString;
	}
	
}