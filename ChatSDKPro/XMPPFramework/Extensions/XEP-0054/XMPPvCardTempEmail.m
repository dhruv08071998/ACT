//
//  XMPPvCardTempEmail.m
//  XEP-0054 vCard-temp
//
//  Created by Eric Chamberlain on 3/9/11.
//  Copyright 2011 RF.com. All rights reserved.
//  Copyright 2010 Martin Morrison. All rights reserved.
//


#import "XMPPvCardTempEmail.h"
#import "XMPPLogging.h"

#import <objc/runtime.h>

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#if DEBUG
  static const int xmppLogLevel = XMPP_LOG_LEVEL_ERROR;
#endif


@implementation XMPPvCardTempEmail

#if DEBUG

+ (void)initialize {
	// We use the object_setClass method below to dynamically change the class from a standard NSXMLElement.
	// The size of the two classes is expected to be the same.
	// 
	// If a developer adds instance methods to this class, bad things happen at runtime that are very hard to debug.
	// This check is here to aid future developers who may make this mistake.
	// 
	// For Fearless And Experienced Objective-C Developers:
	// It may be possible to support adding instance variables to this class if you seriously need it.
	// To do so, try realloc'ing self after altering the class, and then initialize your variables.
	
	size_t superSize = class_getInstanceSize([NSXMLElement class]);
	size_t ourSize   = class_getInstanceSize([XMPPvCardTempEmail class]);
	
	if (superSize != ourSize)
	{
		XMPPLogError(@"Adding instance variables to XMPPvCardTempEmail is not currently supported!");
		
		[DDLog flushLog];
		exit(15);
	}
}

#endif

+ (XMPPvCardTempEmail *)vCardEmailFromElement:(NSXMLElement *)elem {
	object_setClass(elem, [XMPPvCardTempEmail class]);
	
	return (XMPPvCardTempEmail *)elem;
}


#pragma mark -
#pragma mark Getter/setter methods


- (BOOL)isHome {
	return [self elementForName:@"HOME"] != nil;
}


- (void)setIsHome:(BOOL)home {
	XMPP_VCARD_SET_EMPTY_CHILD(home && ![self isHome], @"HOME");
}


- (BOOL)isWork {
	return [self elementForName:@"WORK"] != nil;
}


- (void)setIsWork:(BOOL)work {
	XMPP_VCARD_SET_EMPTY_CHILD(work && ![self isWork], @"WORK");
}


- (BOOL)isInternet {
	return [self elementForName:@"INTERNET"] != nil;
}


- (void)setIsInternet:(BOOL)internet {
	XMPP_VCARD_SET_EMPTY_CHILD(internet && ![self isInternet], @"INTERNET");
}


- (BOOL)isX400 {
	return [self elementForName:@"X400"] != nil;
}


- (void)setIsX400:(BOOL)x400 {
	XMPP_VCARD_SET_EMPTY_CHILD(x400 && ![self isX400], @"X400");
}


- (BOOL)isPreferred {
	return [self elementForName:@"PREF"] != nil;
}


- (void)setIsPreferred:(BOOL)pref {
	XMPP_VCARD_SET_EMPTY_CHILD(pref && ![self isPreferred], @"PREF");
}


- (NSString *)userid {
    return [[self elementForName:@"USERID"] stringValue];
}

- (void)setIsUserid:(NSString *)userid {
    XMPP_VCARD_SET_STRING_CHILD(userid, @"USERID");
}


@end
