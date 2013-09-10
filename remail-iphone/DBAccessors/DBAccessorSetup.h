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


@interface DBAccessorSetup : NSObject
+(void) passwordSetup :  (sqlite3*) database;
+(void) setPragmaKey : (NSString *) value;
@end