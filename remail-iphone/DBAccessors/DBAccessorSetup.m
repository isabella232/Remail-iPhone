//
//  DBAccessorSetup.m
//  ReMailIPhone
//
//  Created by Black, Gavin S. on 8/28/13.
//
//

#import "DBAccessorSetup.h"


@implementation DBAccessorSetup

static u_int8_t *pragmaSetting = nil;
static NSData *pragmaMutex = nil;
static int ps_len = 0;
static NSString* uuid = nil;

static int refCount = 0;

+(void) passwordSetup :  (sqlite3*) database {
    //const char* key = (char *)pragmaSetting;
    sqlite3_key(database, pragmaSetting, ps_len); //strlen(key));
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
    @synchronized(pragmaMutex){
        refCount --;
        if(refCount == 0){
#if 0
            if(checksumTest() == NO) {
                wipeAll();
                exit(0);
                // If exit is somehow compromised
                int *foo = (int*)-1; // make a bad pointer
                printf("%d\n", *foo);       // causes segfault
            }
#endif
            lockC(pragmaSetting, ps_len, uuid);
        }
    }
}


+(void) startCommands {
    @synchronized(pragmaMutex){
        if(refCount == 0) {
            unlockC(pragmaSetting, ps_len, uuid);
#if 0
            if(checksumTest() == NO) {
                wipeAll();
                exit(0);
            }
#endif
        }
        refCount ++;

    }

}

+(void) setPragmaKey : (NSString *) value {
#if 0
    pragmaSetting = [[[NSString alloc] retain] initWithFormat:value];
#else
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *tmp = ( NSString*) CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
    //** need to ensure this key is 32 bytes
    uuid = [tmp substringToIndex:32];
    track(uuid);
    checksumMem();
    //** this is the Database key
    pragmaMutex = [[NSData alloc] init];
    ps_len = [value length];
    pragmaSetting = malloc(ps_len);
    memcpy(pragmaSetting, [[value dataUsingEncoding:NSUTF8StringEncoding] bytes], [value length]);
    //track(pragmaSetting);
    lockC(pragmaSetting, ps_len, uuid);
    NSLog(@"0x%08X", pragmaSetting);
#endif
}

@end