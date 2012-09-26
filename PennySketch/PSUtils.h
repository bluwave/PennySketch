//
// Created by slim on 9/25/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface PSUtils : NSObject

+(NSString *) dataDirectory;

+(void) createDataDirectory:(NSError **) error;
@end