//
//  SamplePluginTemplateField.h
//  SamplePluginFieldType
//
//  Created by Uli Kusterer on 22.10.06.
//  Copyright 2006 M. Uli Kusterer. All rights reserved.
//

// -----------------------------------------------------------------------------
//	Headers:
// -----------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>
#import "UKTemplateFieldProtocol.h"


// -----------------------------------------------------------------------------
//	Classes:
// -----------------------------------------------------------------------------

@interface SamplePluginTemplateField : NSObject <UKTemplateFieldPluginProtocol>
{
	UKTemplateField*	owningField;		// Use this object to talk to AngelTemplate.
	int					ourData;			// Whatever data this field read from the file.
}

-(id)	initWithTemplateField: (UKTemplateField*)inOwningField;

@end
