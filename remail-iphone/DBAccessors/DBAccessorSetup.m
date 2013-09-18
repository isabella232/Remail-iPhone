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


//*********************************
//*********************************
//**
//** iMAS memory security additions
//**
//*********************************
//*********************************

+(void) stopCommands {
    //lock(uuid, @"FAIL");
    @synchronized(pragmaSetting){
        refCount --;
        if(refCount == 0){
            if(checksumTest() == NO) {
                wipeAll();
                exit(0);
                // If exit is somehow compromised
                int *foo = (int*)-1; // make a bad pointer
                printf("%d\n", *foo);       // causes segfault
            }
            lock(pragmaSetting, uuid);
        }
    }
}

+(void) startCommands {
    @synchronized(pragmaSetting){
        if(refCount == 0) {
            unlock(pragmaSetting, uuid);
            if(checksumTest() == NO) {
                wipeAll();
                exit(0);
            }        }
        refCount ++;
    }
}

+(void) setPragmaKey : (NSString *) value {
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    uuid = ( NSString*) CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    track(uuid);
    track(pragmaSetting);
    checksumMem();
    pragmaSetting = [value copy];
    lock(pragmaSetting, uuid);
}

@end