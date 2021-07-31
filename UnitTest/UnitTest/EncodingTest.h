//
//  EncodingTest.h
//  UnitTest
//
//  Created by leeyeon2 on 2021/07/05.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncodingTest : NSObject

/**
 *  URL 엔코딩
 *
 *  @param string CFURLCreateStringByAddingPercentEscapes
 *
 *  @return URL 엔코딩 문자열
 */
+ (NSString *)encodeURL:(NSString *)string;

/**
 *  Base64 인코딩
 *
 *  @param fromString  인코딩할 문자열
 *
 *  @return Base64 인코딩한 문자열
 */
+ (NSString*)encodeStringToBase64:(NSString*)fromString;

/**
 *  Base64 디코딩
 *
 *  @param base64String  디코딩할 문자열
 *
 *  @return decodedString 디코딩한 문자열
 */
+ (NSString*)decodeBase64ToString:(NSString*)base64String;

@end

NS_ASSUME_NONNULL_END
