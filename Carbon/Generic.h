// abbreviations
#define null NULL

#if TARGET_API_MAC_CARBON
	#define qdb ScreenBounds()
	inline Rect ScreenBounds()
	{
		Rect rect;
		GetAvailableWindowPositioningBounds(GetMainDevice(), &rect);
		return rect;
	}
#else
	#define	qdb qd.screenBits.bounds
#endif

// Easier constants
#define RGBColour RGBColor

// Easier API call names
#define GetWindowRefCon(window)                     (long)      GetWRefCon(window)
#define SetWindowRefCon(window, refcon)                         SetWRefCon(window, refcon)
#define GetWindowTitle(window, string)                          GetWTitle(window, string)
#define SetWindowTitle(window, name)                            SetWTitle(window, name)
#define InvalidateRect(bounds)                                  InvalRect(bounds)
#define InvalidateWindowRect(window, bounds)        (OSStatus)  InvalWindowRect(window, bounds)
#define RectToRegion(region, rect)                              RectRgn(region, rect)
#define NewPoint()                                  (Point)     { 0, 0 }
#define SetPoint(point, x, y)                                   SetPt(point, x, y)
/* apperance.h */
#define SetThemeTextColour(c, d, cd)                (OSStatus)  SetThemeTextColor(c, d, cd)
#define IsThemeInColour(d, cd)                      (Boolean)   IsThemeInColor(d, cd)
#define GetThemeAccentColours(out)                  (OSStatus)  GetThemeAccentColors(out)
#define SetThemeTextColourForWindow(w, a, d, cd)    (OSStatus)  SetThemeTextColorForWindow(w, a, d, cd)
#define GetThemeBrushAsColour(b, d, cd, out)        (OSStatus)  GetThemeBrushAsColor(b, d, cd, out)
#define GetThemeTextColour(c, d, cd, out)           (OSStatus)  GetThemeTextColor(c, d, cd, out)
/* quickdraw.h */
#define HighlightColour(colour)                                 HiliteColor(colour)
#define GetPortHighlightColour(window, colour)                  GetPortHiliteColor(window, colour)
