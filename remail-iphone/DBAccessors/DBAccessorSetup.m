//
//  DBAccessorSetup.m
//  ReMailIPhone
//
//  Created by Black, Gavin S. on 8/28/13.
//
//

#import "DBAccessorSetup.h"


@implementation DBAccessorSetup

+(void) passwordSetup :  (sqlite3*) database {
  //  return;
    const char* key = [@"FOOBAR" UTF8String];
    sqlite3_key(database, key, strlen(key));
}
@end