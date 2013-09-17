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
static NSString* uuid;

static int refCount = 0;

+(void) passwordSetup :  (sqlite3*) database {
    const char* key = [pragmaSetting UTF8String];
    sqlite3_key(database, key, strlen(key));
}

+(void) stopCommands {
    @synchronized(pragmaSetting){
        refCount --;
        if(refCount == 0) lock(pragmaSetting, uuid);
    }
}

+(void) startCommands {
    @synchronized(pragmaSetting){
        if(refCount == 0)  unlock(pragmaSetting, uuid);
        refCount ++;
    }
}

+(void) setPragmaKey : (NSString *) value {
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    uuid = ( NSString*) CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    pragmaSetting = [value copy];
    lock(pragmaSetting, uuid);
}

@end