//
//  NSBundle+Tools.h
//
//  Created by Nicolas Robin on 18/04/12.
//  Copyright (c) 2012 MyStudioFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Tools)

- (id)firstObjectInNibNamed:(NSString*)name owner:(id)owner options:(NSDictionary*)options;
+ (id)firstObjectInNibFromMainBundle:(NSString*)name owner:(id)owner;
+ (id)firstObjectInNibFromMainBundle:(NSString*)name;

@end
