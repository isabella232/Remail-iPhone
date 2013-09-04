//
//  DBAccessorSetup.h
//  ReMailIPhone
//
//  Created by Black, Gavin S. on 8/28/13.
//
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"


@interface DBAccessorSetup : NSObject
+(void) passwordSetup :  (sqlite3*) database ;
@end