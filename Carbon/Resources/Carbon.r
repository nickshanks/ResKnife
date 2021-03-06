#if defined(__MWERKS__)		// compiling with codewarrior
	#include <Carbon.r>
#else						// compiling with gcc (__APPLE_CC__)
	#include <Carbon/Carbon.r>
#endif

/*
#if defined(__APPLE_CC__)		// compiling with gcc
	#include <Carbon/Carbon.r>
#else							// compiling with CodeWarrior, __MWERKS__
	#include <Carbon.r>
#endif
*/

/*** CARBON RESOURCES ***/
data 'carb' ( 0 )
{
	$"00000000"
};

data 'plst' ( 0 )
{
	"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
	"<!DOCTYPE plist SYSTEM \"file://localhost/System/Library/DTDs/PropertyList.dtd\">\n"
	"<plist version=\"0.9\">\n"
	"<dict>\n"
	"	<key>CFBundleDevelopmentRegion</key>\n"
	"	<string>English</string>\n"
	"	<key>CFBundleDocumentTypes</key>\n"
	"	<array>\n"
	"		<dict>\n"
	"			<key>CFBundleTypeExtensions</key>\n"
	"			<array>\n"
	"				<string>rsrc</string>\n"
	"			</array>\n"
	"			<key>CFBundleTypeIconFile</key>\n"
	"			<string>129</string>\n"
	"			<key>CFBundleTypeName</key>\n"
	"			<string>Resource file</string>\n"
	"			<key>CFBundleTypeOSTypes</key>\n"
	"			<array>\n"
	"				<string>rsrc</string>\n"
	"				<string>RSRC</string>\n"
	"			</array>\n"
	"			<key>CFBundleTypeRole</key>\n"
	"			<string>Editor</string>\n"
	"		</dict>\n"
	"		<dict>\n"
	"			<key>CFBundleTypeExtensions</key>\n"
	"			<array>\n"
	"				<string>icns</string>\n"
	"			</array>\n"
	"			<key>CFBundleTypeIconFile</key>\n"
	"			<string>129</string>\n"
	"			<key>CFBundleTypeName</key>\n"
	"			<string>Icon file</string>\n"
	"			<key>CFBundleTypeOSTypes</key>\n"
	"			<array>\n"
	"				<string>icns</string>\n"
	"			</array>\n"
	"			<key>CFBundleTypeRole</key>\n"
	"			<string>Editor</string>\n"
	"		</dict>\n"
	"	</array>\n"
	"	<key>CFBundleExecutable</key>\n"
	"	<string>ResKnife (Carbon)</string>\n"
	"	<key>CFBundleGetInfoString</key>\n"
	"	<string>A resource editor for Mac OS X</string>\n"
	"	<key>CFBundleIconFile</key>\n"
	"	<string>128</string>\n"
	"	<key>CFBundleIdentifier</key>\n"
	"	<string>com.nickshanks.resknife</string>\n"
	"	<key>CFBundleInfoDictionaryVersion</key>\n"
	"	<string>6.0</string>\n"
	"	<key>CFBundleName</key>\n"
	"	<string>ResKnife</string>\n"
	"	<key>CFBundlePackageType</key>\n"
	"	<string>APPL</string>\n"
	"	<key>CFBundleShortVersionString</key>\n"
	"	<string>Development version 0.4d1</string>\n"
	"	<key>CFBundleSignature</key>\n"
	"	<string>ResK</string>\n"
	"	<key>CFBundleVersion</key>\n"
	"	<string>0.4d1</string>\n"
	"	<key>CSResourcesFileMapped</key>\n"
	"	<true/>\n"
	"</dict>\n"
	"</plist>"
};