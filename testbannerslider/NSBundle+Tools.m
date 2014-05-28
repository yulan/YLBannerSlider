//
//  NSBundle+Tools.m
//
//  Created by Nicolas Robin on 18/04/12.
//  Copyright (c) 2012 MyStudioFactory. All rights reserved.
//

#import "NSBundle+Tools.h"

@implementation NSBundle (Tools)

- (id)firstObjectInNibNamed:(NSString*)name owner:(id)owner options:(NSDictionary*)options
{
    NSArray *objs = [self loadNibNamed:name owner:owner options:options];
    return (objs.count > 0) ? [objs objectAtIndex:0] : nil;
}

+ (id)firstObjectInNibFromMainBundle:(NSString*)name owner:(id)owner
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    return [mainBundle firstObjectInNibNamed:name owner:owner options:nil];
}

+ (id)firstObjectInNibFromMainBundle:(NSString*)name
{
    return [NSBundle firstObjectInNibFromMainBundle:name owner:nil];
}


@end
