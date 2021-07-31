//
//  EncodingTest.m
//  UnitTest
//
//  Created by leeyeon2 on 2021/07/05.
//

#import "EncodingTest.h"

@implementation EncodingTest
/**
 *  엔코딩
 *
 *  @param string CFURLCreateStringByAddingPercentEscapes
 *
 *  @return 엔코딩 문자열
 */
+ (NSString *)encodeURL:(NSString *)string
{
    NSString *newString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    if (newString)
    {
        return newString;
    }
    
    return @"";
}


/**
 *  Base64 인코딩
 *
 *  @param fromString  인코딩할 문자열
 *
 *  @return Base64 인코딩한 문자열
 */
+ (NSString*)encodeStringToBase64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];
    } else {
        base64String = [plainData base64Encoding];
    }

    return base64String;
}

/**
 *  Base64 디코딩
 *
 *  @param base64String  디코딩할 문자열
 *
 *  @return decodedString 디코딩한 문자열
 */
+ (NSString*)decodeBase64ToString:(NSString*)base64String
{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    
    //uri 디코딩
    decodedString = [decodedString stringByRemovingPercentEncoding];
    
    return decodedString;
}



@end
