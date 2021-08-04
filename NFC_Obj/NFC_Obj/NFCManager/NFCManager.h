//
//  NFCManager.h
//  NFC_Obj
//
//  Created by leeyeon2 on 2021/08/02.
//

#import <Foundation/Foundation.h>
#import <CoreNFC/CoreNFC.h>

NS_ASSUME_NONNULL_BEGIN

@interface NFCManager : NSObject<NFCNDEFReaderSessionDelegate>{
}
//iOS11 Session
@property (nonatomic, strong) NFCNDEFReaderSession *ndefSession;
//iOS11 Session
//@property (nonatomic, strong) NFCTagReaderSession *tagReaderSession;
@property (nonatomic, strong) NSMutableArray<NFCNDEFMessage *> *nfcndefMessage;

/**
 *  Singleton Pattern
 *
 *  @return 클래스 인스턴스
 */
+(instancetype)shared;

/**
 *  NFC Scan 시작
 */
- (void)startNFCScan;
+ (NSString *)getTagIdFromSession:(NFCNDEFReaderSession *)session  API_AVAILABLE(ios(11.0));
@end

NS_ASSUME_NONNULL_END
