//
//  NFCViewController.m
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2022/01/26.
//

#import "NFCViewController.h"

@interface NFCViewController ()<NFCTagReaderSessionDelegate, NFCNDEFReaderSessionDelegate>

@property (nonatomic, strong) NFCTagReaderSession *tagSession NS_AVAILABLE_IOS(13.0);
@property (strong, nonatomic) NFCNDEFReaderSession *ndefSession NS_AVAILABLE_IOS(11.0);

@end

@implementation NFCViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(@available(iOS 13.0, *)) {
        if (NFCNDEFReaderSession.readingAvailable) {
            //세션 시작
            NFCPollingOption option = NFCPollingISO14443 | NFCPollingISO15693 | NFCPollingISO18092;
            self.tagSession = [[NFCTagReaderSession alloc] initWithPollingOption:option delegate:self queue:dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT)];
//            self.tagSession.alertMessage = HMPLocalizedString(@"nfc_ready_guide", nil);
            [self.tagSession beginSession];
        }
        // 지원안하는 기기인 경우
        else{
            [self scanFailResult: NFCReaderErrorUnsupportedFeature];
        }
    }
    
    else if (@available(iOS 11.0, *)) {
        if (NFCNDEFReaderSession.readingAvailable) {
            self.ndefSession = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:nil invalidateAfterFirstRead:NO];
//            self.ndefSession.alertMessage = HMPLocalizedString(@"nfc_ready_guide", nil);
            [self.ndefSession beginSession];
        }
        // 지원안하는 기기인 경우
        else {
//            [self scanFailResult: NFC_EXECUTE_ERROR_NOT_SUPPORT_DEVICE];
        }
    }
    // 지원안하는 iOS 버전인 경우
    else
    {
//        [self scanFailResult: NFC_EXECUTE_ERROR_NOT_SUPPORT_DEVICE];
    }
}


#pragma mark - NFCTagReaderSessionDelegate : iOS 13.0
/**
 *  iOS13 이상 NFCTagReaderSession  invalidate 에러 발생
 *
 *  @param session NFCTagReaderSession 정보
 *  @param error  실패 콜백
 */
- (void)tagReaderSession:(NFCTagReaderSession *)session didInvalidateWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    [self scanFailResult: error.code];
}

/**
 *  iOS13 이상 NFCTagReaderSession 활성화 상태 확인
 *
 *  @param session NFCTagReaderSession 정보
 */
- (void)tagReaderSessionDidBecomeActive:(NFCTagReaderSession *)session  API_AVAILABLE(ios(13.0)){
//    HMPLoggerDebug(@"DAPNfcRead tagReaderSessionDidBecomeActive");
}

/**
 *  iOS13 이상 태그를 성공적으로 읽은 경우
 *
 *  @param session NFCTagReaderSession
 *  @param tags  NFCNDEFTag
 */
- (void)tagReaderSession:(NFCTagReaderSession *)session didDetectTags:(NSArray<__kindof id<NFCTag>> *)tags  API_AVAILABLE(ios(13.0)){
    self.tagSession = session;
    
    if (tags.count > 0) {
        // tag가 2개 이상인 경우
        if (tags.count > 1){
//            [self scanFailResult: NFC_EXECUTE_NOT_SUPPORT_MULTI_TAGS];
            return;
        }
        
        [session connectToTag:tags.firstObject completionHandler:^(NSError * _Nullable error) {
            // 태그에 연결되지 않은 경우
            if (error) {
                [self scanFailResult: error.code];
                return;
            }
            
            [tags.firstObject queryNDEFStatusWithCompletionHandler:^(NFCNDEFStatus status, NSUInteger capacity, NSError * _Nullable error) {
                // 태그의 NDEF 상태를 조회 할 수 없는 경우
                if (error) {
                    [self scanFailResult: error.code];
                    return;
                }
                // 태그가 NDEF 포맷이 아닌 경우
                if (status == NFCNDEFStatusNotSupported) {
                    [self scanFailResult: error.code];
                    return;
                }
                
                [tags.firstObject readNDEFWithCompletionHandler:^(NFCNDEFMessage * _Nullable message, NSError * _Nullable error) {
                    // NDEF를 읽지 못한 경우
                    if (error) {
                        [self scanFailResult: error.code];
                        return;
                    }
                    // tag 값이 없는 경우
                    else if (message == nil){
                        [self scanFailResult: error.code];
                        return;
                    }
                    // 태그 성공
                    else {
//                        NSString *uid = [HMPNfcUtil getStringTagIdentifierWithTag:tags.firstObject];
//                        [self parsingMessage:message uid:uid];
                    }
                }];
            }];
        }];
    }
}

#pragma mark - NFCNDEFReaderSessionDelegate : iOS 11.0
/**
 *  iOS11 이상 NFCTagReaderSession  invalidate 에러 발생
 *
 *  @param session NFCNDEFReaderSession 정보
 *  @param error  실패 콜백
 */
- (void)readerSession:(nonnull NFCNDEFReaderSession *)session didInvalidateWithError:(nonnull NSError *)error  API_AVAILABLE(ios(11.0)){
    [self scanFailResult: error.code];
}

/**
 *  iOS11 이상 NFCNDEFReaderSession 활성화 상태 확인
 *
 *  @param session NFCNDEFReaderSession 정보
 */
- (void)readerSessionDidBecomeActive:(NFCNDEFReaderSession *)session NS_AVAILABLE_IOS(11.0) {
//    HMPLoggerDebug(@"DAPNfcRead readerSessionDidBecomeActive");
}

/**
 *  iOS11 이상에서 태그를 성공적으로 읽은 경우
 *
 *  @param session NFCNDEFReaderSession
 *  @param messages  NFCNDEFMessage
 */
- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages API_AVAILABLE(ios(11.0)) {
    self.ndefSession = session;
    
    if ([messages count] > 0) {
        if ([messages count] > 1) {
            [self scanFailResult: NFC_EXECUTE_NOT_SUPPORT_MULTI_TAGS];
            return;
        }
        for (NFCNDEFMessage *message in messages) {
//            NSString *uid = [HMPNfcUtil getTagIdFromSession:session];
//            [self parsingMessage:message uid:uid];
        }
    }
    // tag 값이 없는 경우
    else{
        [self scanFailResult: NFC_EXECUTE_INVALID_PARAMETER];
    }
}

/**
 *  NFCNDEFMessage 값 NSDictionary 형태로 parsing
 *
 *  @param message NFCNDEFMessage
 *  @param tagId  NFC uid
 */
- (void)parsingMessage:(NFCNDEFMessage * _Nullable)message uid:(NSString *)tagId API_AVAILABLE(ios(11.0)){
    NSString *uid = tagId;
    NSMutableArray *records = [NSMutableArray array];
    
    for (NFCNDEFPayload *payload in message.records) {
        NSString *type = [[NSString alloc] initWithData:payload.type encoding:NSASCIIStringEncoding];
        NSString *data = @"";

        if (payload.typeNameFormat == NFCTypeNameFormatNFCWellKnown) {
            if (@available(iOS 13.0, *)) {
                if ([type isEqualToString: @"T"]) {
                    data = [payload wellKnownTypeTextPayloadWithLocale: nil];
                } else if ([type isEqualToString: @"U"]) {
                    data = payload.wellKnownTypeURIPayload.absoluteString;
                } else {
                    data = [[NSString alloc] initWithData:payload.payload encoding:NSUTF8StringEncoding];
                }
            } else {
                data = [[NSString alloc] initWithData:payload.payload encoding:NSASCIIStringEncoding];
            }
        } else {
            data = [[NSString alloc] initWithData:payload.payload encoding:NSASCIIStringEncoding];
        }
        
//        NSDictionary *recode = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                AvoidNil(type), @"type",
//                                AvoidNil(data), @"data", nil];
//        [records addObject:recode];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:AvoidNil(uid), @"uid", records, @"records", nil];
//        [self scanSuccessResult:dic];
    });
}

/**
 *  성공 콜백
 *
 *  @param resultDict NFC 결과값
 */
-(void)scanSuccessResult: (NSDictionary*) resultDict{
    // NfcReadVCDelegate onSuccess 메소드 구현 확인
    if (self.delegate && [self.delegate respondsToSelector: @selector(onSuccess:)]){
        [self.delegate onSuccess:resultDict];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [[self presentingViewController] dismissViewControllerAnimated:NO completion:^{
            if (@available(iOS 13.0, *)) {
                [self.tagSession invalidateSession];
            } else if (@available(iOS 11.0, *)){
                [self.ndefSession invalidateSession];
            }
        }];
    });
}

/**
 *  실패  콜백
 *
 *  @param errorCodeFromTag 에러코드값
 */
-(void)scanFailResult: (NSInteger)errorCodeFromTag{
    
    NSString* errorCode;
    
    switch (errorCodeFromTag) {
        case NFCReaderSessionInvalidationErrorUserCanceled:
            errorCode = @"E12653";
            break;
        case NFCReaderSessionInvalidationErrorSessionTimeout:
            errorCode = @"E12654";
            break;
        case NFCReaderErrorUnsupportedFeature:
        case NFC_EXECUTE_ERROR_NOT_SUPPORT_DEVICE:
            errorCode = @"E12652";
            break;
        case NFCReaderErrorSecurityViolation:
            errorCode = @"E12656";
            break;
        case NFC_EXECUTE_NOT_SUPPORT_MULTI_TAGS:
            errorCode = @"E12657";
            break;
        default:
            errorCode = @"E12650";
            break;
    }
    
    
//    NSDictionary *messageDict = [[HMPErrorCodeManager sharedErrorCodeManager] generateMessageDictWithCode:errorCode localizedString:nil];
//    NSError *deviceError = [NSError errorWithDomain:[NSString stringWithFormat:@"%s Line %d", __PRETTY_FUNCTION__, __LINE__] code:DAPError_Execute userInfo:messageDict];
//
    // NfcReadVCDelegate onFail 메소드 구현 확인
    if (self.delegate && [self.delegate respondsToSelector: @selector(onFail:)]){
//        [self.delegate onFail: deviceError];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self presentingViewController] dismissViewControllerAnimated:NO completion:^{
            if (@available(iOS 13.0, *)) {
                [self.tagSession invalidateSession];
            } else if (@available(iOS 11.0, *)){
                [self.ndefSession invalidateSession];
            }
        }];
    });
}
@end
