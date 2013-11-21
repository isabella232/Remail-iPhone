//
//  DBAccessorSetup.h
//  ReMailIPhone
//
//  Created by Black, Gavin S. on 8/28/13.
//
//

#import <Foundation/Foundation.h>
#import <SecureFoundation/SecureFoundation.h>
#import "sqlite3.h"
#import "IMSMemoryManager.h"

//*********************************
//*********************************
//**
//** iMas SQLCipher key management
//**
//*********************************
//*********************************

inline void problemDetected() __attribute__((always_inline));

@interface DBAccessorSetup : NSObject
+(void) passwordSetup :  (sqlite3*) database;
+(void) setPragmaKey : (NSString *) value;
+(void) stopCommands;
+(void) startCommands;
@end