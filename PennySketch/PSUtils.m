//
// Created by slim on 9/25/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PSUtils.h"


@implementation PSUtils
+(NSString*) dataDirectory
{
    NSString * folderName =[NSString stringWithFormat:@"%@Images", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:folderName];
    return dataPath;

}

+(void) createDataDirectory:(NSError **) error
{

    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dataDirectory]])
        [[NSFileManager defaultManager] createDirectoryAtPath:[self dataDirectory] withIntermediateDirectories:NO attributes:nil error:error];
}
@end