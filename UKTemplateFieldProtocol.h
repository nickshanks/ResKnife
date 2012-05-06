/*
 *  UKTemplateFieldProtocol.h
 *  AngelTemplate
 *
 *  Created by Uli Kusterer on 22.10.06.
 *  Copyright 2006 M. Uli Kusterer. All rights reserved.
 *
 */

/* This is the main header for writing plugin template field types for
	AngelTemplate. Sorry that it ended up looking a tad convoluted and full.
	You may want to skip reading this and just check out the
	SamplePluginTemplateField project that you should have received with
	AngelTemplate. It will show that it's really ridiculously easy. */

// -----------------------------------------------------------------------------
//	Headers:
// -----------------------------------------------------------------------------

#import <Foundation/Foundation.h>


// -----------------------------------------------------------------------------
//	Data Types:
// -----------------------------------------------------------------------------

@class UKTemplateField;


// -----------------------------------------------------------------------------
//	Macros:
// -----------------------------------------------------------------------------

// Use this to call class methods on the template field protocol:
#define UK_TEMPLATEFIELD_CLASS	NSClassFromString( @"UKTemplateField" )


// -----------------------------------------------------------------------------
//	Protocols:
// -----------------------------------------------------------------------------

/* These are the externally visible methods that you can use on the actual
	template field object handed to the plugin's constructor and used for
	built-in template fields: */

@protocol UKTemplateFieldProtocol

// Creating/Setting up a template field:
+(void)         registerTemplateFieldClass: (Class)cl forType: (NSString*)type; // Call this from your +load method to register your class for each of its types.
+(id)           fieldWithSettingsDictionary: (NSDictionary*)dict;				// Will look up the correct class for the "type" in the dictionary and give you a new UKTemplateField for that.

-(void)			dataChanged: (id)sender;					// Action for checkboxes etc. that marks the document dirty.
-(void)			updateDocumentGUI;							// Cause our table view GUI to reload because we added fields or whatever.
-(void)			reportChangeOfUnknownKey: (NSString*)key;	// Tells document to report about unknown value change.

-(id)			objectForSettingsKey: (NSString*)key;		// Tries to inherit unset properties from document (i.e. template-wide setting).

-(BOOL)			isBigEndian;								// These use objectForSettingsKey.
-(BOOL)			isLittleEndian;								// These use objectForSettingsKey.

@end


/* These are methods that the template field implements but forwards to your
	plugin controller. The plugin controller is expected to override these and
	provide its own functionality: */

@protocol UKTemplateFieldOverridableMethods

-(void)				readFromData: (NSData*)data offset: (int*)offs;			// Must add read amount to offs. Must be prepared for not enough data being present.
-(void)				writeToData: (NSMutableData*)data offset: (int*)offs;	// Must add written amount to offs.

-(id)				plistRepresentation;                    // Field's value as a property list type.

// You also have to provide -fieldValue or -fieldValueForKey: to provide a value to be displayed by AngelWeb for your field (see below).

@end


/* Optional or almost-optional methods for your plugin object: */

@protocol UKTemplateFieldOptionalMethods

// You must provide exactly *one* of the following two:
//	These return plist-type values that our NSOutlineView knows how to display.
-(id)				fieldValue;									// Override this to show your value. Called by the default implementation of fieldValueForKey: to provide the actual value (as opposed to label etc., which we can pull from the template).
-(id)				fieldValueForKey: (NSString*)key;			// Value/Label etc. of this field to display in the document's outline view.

// The rest are completely optional:
-(void)				loadDefaults;								// Called instead of readFromData:offset: when creating a new file.

// The following is needed if you want your field to be editable:
-(void)				setFieldValue: (id)newValue forKey: (NSString*)key;		// Key is currently always "value". If it's something else, call reportChangeOfUnknownKey:.
-(BOOL)				fieldValueIsEditableForKey: (NSString*)key;
-(BOOL)				isSelectable;

// These are if you have sub-fields in your field:
-(BOOL)				canHaveSubFields;						// May have sub fields (but it's maybe empty right now). Defaults to NO.
-(int)				countSubFields;							// # of subfields. Defaults to 0.
-(UKTemplateField*)	subFieldAtIndex: (int)index;			// Return the subfield with specified (zero-based) index.
-(void)				addNewField: (id)sender;				// Action of the "New Field" menu item. You can also implement other selectors like delete:, copy: etc.

-(void)				openFieldEditor: (id)sender;			// Open the field (editor or preview or whatever). Handy for more complex fields.

@end


/* The following protocol is what your plugin field type should implement at
	the least. Note that this includes all of the overridable methods above
	as well as fieldValue or fieldValueForKey:. */

@protocol UKTemplateFieldPluginProtocol <UKTemplateFieldOverridableMethods,NSObject>

-(id)	initWithTemplateField: (UKTemplateField*)owningField;	// Initializer AngelTemplate calls on your class to create a new object. Save away a nonretained pointer to owningTemplate. It's your lifeline to AngelTemplate.

// May also implement UKTemplateFieldOptionalMethods.

@end
