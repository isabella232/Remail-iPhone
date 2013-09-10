//
//  DBAccessorSetup.m
//  ReMailIPhone
//
//  Created by Black, Gavin S. on 8/28/13.
//
//

#import "DBAccessorSetup.h"


@implementation DBAccessorSetup

static NSString* pragmaSetting;

+(void) passwordSetup :  (sqlite3*) database {
  //  return;
    NSLog(@">>>>>>>>>>>>>%@", pragmaSetting);
    const char* key = [pragmaSetting UTF8String];
    sqlite3_key(database, key, strlen(key));
}

+(void) setPragmaKey : (NSString *) value {
    pragmaSetting = [value copy];
    lock(pragmaSetting, @"TEST");
//    wipe(value);
}

@end