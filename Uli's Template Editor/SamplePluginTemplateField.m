//
//  SamplePluginTemplateField.m
//  SamplePluginFieldType
//
//  Created by Uli Kusterer on 22.10.06.
//  Copyright 2006 M. Uli Kusterer. All rights reserved.
//

// -----------------------------------------------------------------------------
//	Headers:
// -----------------------------------------------------------------------------

#import "SamplePluginTemplateField.h"


@implementation SamplePluginTemplateField

// -----------------------------------------------------------------------------
//	load:
//		Register our field type(s) with AngelTemplate:
// -----------------------------------------------------------------------------

+(void)	load
{
	[UK_TEMPLATEFIELD_CLASS registerTemplateFieldClass: [self class] forType: @"Sample"];
}

// -----------------------------------------------------------------------------
//	* CONSTRUCTOR:
// -----------------------------------------------------------------------------

-(id)	initWithTemplateField: (UKTemplateField*)inOwningField
{
	if( (self = [super init]) ) 
	{
		// Save away the owning field so we can later ask it for info:
		owningField = inOwningField;	// Don't retain, it's our owner, so we'd get a retain circle.
	}
	
	return self;
}


// -----------------------------------------------------------------------------
//	Read from file:
// -----------------------------------------------------------------------------

-(void)	readFromData: (NSData*)data offset: (int*)offs
{
	if( ([data length] -(*offs)) >= sizeof(ourData) )	// Still have enough data in file for this?
	{
		[data getBytes: &ourData range: NSMakeRange(*offs,sizeof(ourData))];
		if( [owningField isBigEndian] )
			ourData = EndianS32_BtoN(ourData);
		else
			ourData = EndianS32_LtoN(ourData);
	}
	else
		[self loadDefaults];	// Not enough data? Just use default (would be cooler to try to read what data we have and pad the rest with zeroes if that made sense for your data type).
	*offs += sizeof(ourData);	// Append our size anyway, so AngelTemplate knows we need more data and can tell user.
}


// -----------------------------------------------------------------------------
//	Append to file (save):
// -----------------------------------------------------------------------------

-(void)	writeToData: (NSMutableData*)data offset: (int*)offs
{
	int		i = ourData;
	if( [owningField isBigEndian] )
		i = EndianS32_NtoB(ourData);
	else
		i = EndianS32_NtoL(ourData);
	
	[data appendBytes: &i length: sizeof(i)];
	*offs += sizeof(i);
}


// -----------------------------------------------------------------------------
//	Provide our value in a way suitable for display:
// -----------------------------------------------------------------------------

-(id)	fieldValue
{
	return [NSNumber numberWithInt: ourData];
}


// -----------------------------------------------------------------------------
//	Accept changes from the user:
// -----------------------------------------------------------------------------

-(void)	setFieldValue: (id)newValue forKey: (NSString*)key
{
	if( [key isEqualToString: @"value"] )
		ourData = [newValue intValue];
	else
		[owningField reportChangeOfUnknownKey: key];
}


// -----------------------------------------------------------------------------
//	Return our item in some property list representation for Plist-Export:
// -----------------------------------------------------------------------------

-(id)	plistRepresentation
{
	return [NSNumber numberWithInt: ourData];
}


// -----------------------------------------------------------------------------
//	Apply a sensible default value for new files:
// -----------------------------------------------------------------------------

-(void)	loadDefaults
{
	ourData = 7;
}

@end
