#import "RKDocumentController.h"
#import "ApplicationDelegate.h"
#import "OpenPanelDelegate.h"

#import "ResourceDocument.h"

@implementation RKDocumentController

- (nullable Class)documentClassForType:(NSString *)typeName
{
	return [ResourceDocument class];
}

- (int)runModalOpenPanel:(NSOpenPanel *)openPanel forTypes:(NSArray *)extensions
{
	// set-up open panel (this happens every time, but no harm done)
	ApplicationDelegate *appDelegate = [NSApp delegate];
	OpenPanelDelegate *openPanelDelegate = [appDelegate openPanelDelegate];
	NSView *openPanelAccessoryView = [openPanelDelegate openPanelAccessoryView];
	[openPanel setDelegate:openPanelDelegate];
	[openPanel setAccessoryView:openPanelAccessoryView];
	[openPanel setAllowsOtherFileTypes:YES];
	[openPanel setTreatsFilePackagesAsDirectories:YES];
	[openPanelAccessoryView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
	
	// run panel
	int button = [super runModalOpenPanel:openPanel forTypes:nil/*extensions*/];
	if(button == NSOKButton)
		[openPanelDelegate setReadOpenPanelForFork:YES];
	return button;
}

@end
