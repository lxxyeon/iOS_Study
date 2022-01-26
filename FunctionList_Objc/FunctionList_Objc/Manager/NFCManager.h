//
//  NFCManager.h
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2022/01/26.
//

#import <Foundation/Foundation.h>
#import <CoreNFC/CoreNFC.h>

NS_ASSUME_NONNULL_BEGIN

@interface NFCManager : NSObject

+ (NSString *)getStringTagIdentifierWithTag:(id<NFCTag>)tag  API_AVAILABLE(ios(13.0));
+ (NSString *)getTagIdFromSession:(NFCNDEFReaderSession *)session  API_AVAILABLE(ios(11.0));

@end

NS_ASSUME_NONNULL_END
