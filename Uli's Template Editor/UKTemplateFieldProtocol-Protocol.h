/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

@protocol UKTemplateFieldProtocol
+ (void)registerTemplateFieldClass:(Class)arg1 forType:(id)arg2;
+ (id)fieldWithSettingsDictionary:(id)arg1;
- (void)dataChanged:(id)arg1;
- (void)updateDocumentGUI;
- (void)reportChangeOfUnknownKey:(id)arg1;
- (id)objectForSettingsKey:(id)arg1;
- (BOOL)isBigEndian;
- (BOOL)isLittleEndian;
@end
