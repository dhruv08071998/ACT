//
//  BXMPPUserWrapper.h
//  XMPPChat
//
//  Created by Benjamin Smiley-andrews on 19/08/2016.
//  Copyright © 2016 deluge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ChatSDK/PUser.h>

@interface BXMPPUserWrapper : NSObject {
    id<PUser> _user;
}

+(BXMPPUserWrapper *) wrapperWithUser: (id<PUser>) user;
-(id) initWithUser: (id<PUser>) user;

-(NSString *) locality;
-(void) setLocality: (NSString *) locality;

-(NSString *) country;
-(void) setCountry: (NSString *) country;

@end
