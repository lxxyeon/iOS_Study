//
//  NFCManager.m
//  NFC_Obj
//
//  Created by leeyeon2 on 2021/08/02.
//
#import "NFCManager.h"
@interface NFCManager(){
    NSString *tag1DataStr;
}
@end

@implementation NFCManager

+(instancetype)shared{
    static NFCManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[NFCManager alloc] init];
    });
    return shared;
}

- (void)startNFCScan
{
    //iOS11
    if (@available(iOS 11.0, *)) {
        _ndefSession = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT) invalidateAfterFirstRead:NO];
        _ndefSession.alertMessage = @"Hold your iPhone near the item to learn more about it.";
        [_ndefSession beginSession];
    }
}

#pragma mark - NFCTagReaderSessionDelegate Methods
/**
 *  태그를 성공적으로 읽은 경우
 *
 *  @param session NFCNDEFReaderSession
 *  @param tags  tags
 */
- (void)tagReaderSession:(NFCTagReaderSession *)session didDetectTags:(NSArray<__kindof id<NFCTag>> *)tags API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos, macos, tvos) {
    
    NSLog(@"reader：%s===%@", __FUNCTION__, tags);
    if (tags.count > 1) {
        [session setAlertMessage:@"More than 1 tag is detected, please remove all tags and try again."];
        NSTimeInterval retryInterval = 500;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, retryInterval), ^{
            [session restartPolling];
        });
        [session restartPolling];
        return;
    }
    
    // Connect to the found tag and perform NDEF message reading
    id<NFCTag> tag = tags[0];
    [session connectToTag:tag completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            [session setAlertMessage:@"Unable to connect to tag."];
            [session invalidateSession];
            return;
        }
        id<NFCMiFareTag> miFareTag = tag.asNFCMiFareTag;
        NSData *serial = [miFareTag identifier];
        if (serial != nil) {
            
            NSString *message = [NSString stringWithFormat:@"Success"];
            [session setAlertMessage:message];
            [session invalidateSession];
            return;
        }
    
        [session invalidateSession];
    }];
    
}

/**
 *  오류가 발생하거나 제한시간(60초) 도달 시
 *
 *  @param session NFCNDEFReaderSession
 *  @param error error
 */
- (void)tagReaderSession:(NFCTagReaderSession *)session didInvalidateWithError:(NSError *)error API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos, macos, tvos) {
}


#pragma mark - NFCNDEFReaderSessionDelegate Methods
- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages {
    NSLog(@"reader：%s===%@", __FUNCTION__, messages);
    NSLog(@"session : %@", session);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"session : %@", session);
        [self.nfcndefMessage addObjectsFromArray:messages];
        
        NSLog(@"detectedMessages %@", self.nfcndefMessage);
        
        NSArray *foundTags = [session valueForKey:@"_foundTags"];
        NSObject *tag = foundTags[0];
        NSData *uuid = [tag valueForKey:@"_tagID"];
        NSLog(@"uuid : %@", uuid);
        
        
    });
}

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
}

- (void)readerSessionDidBecomeActive:(NFCNDEFReaderSession *)session  API_AVAILABLE(ios(11.0)){
    
}

- (void)readerSession:(NFCNDEFReaderSession *)session didDetectTags:(NSArray<__kindof id<NFCNDEFTag>> *)tags API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos, macos, tvos) {
    NSLog(@"reader：%s===%@", __FUNCTION__, tags);
    if (tags.count > 1) {
        [session setAlertMessage:@"More than 1 tag is detected, please remove all tags and try again."];
        NSTimeInterval retryInterval = 500;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, retryInterval), ^{
            [session restartPolling];
        });
        [session restartPolling];
        return;
    }
    
    // Connect to the found tag and perform NDEF message reading
    id<NFCNDEFTag> tag = tags[0];
    [session connectToTag:tag completionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            [session setAlertMessage:@"Unable to connect to tag."];
            [session invalidateSession];
            return;
        }
        
        [tag queryNDEFStatusWithCompletionHandler:^(NFCNDEFStatus status, NSUInteger capacity, NSError * _Nullable error) {
            
            if (NFCNDEFStatusNotSupported == status) {
                [session setAlertMessage:@"Tag is not NDEF compliant"];
                [session invalidateSession];
            } else if (error != nil) {
                [session setAlertMessage:@"Unable to query NDEF status of tag"];
                [session invalidateSession];
            }
            [tag readNDEFWithCompletionHandler:^(NFCNDEFMessage * _Nullable message, NSError * _Nullable error) {
                NSString *statusMessage = @"";
                if (error != nil || message == nil) {
                    statusMessage = @"Fail to read NDEF from tag";
                } else {
                    statusMessage = @"Found 1 NDEF message";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.nfcndefMessage addObject:message];
                        NSLog(@"detectedMessages %@", self.nfcndefMessage);
                    });
                }
                [session setAlertMessage:statusMessage];
                [session invalidateSession];
            }];
        }];
    }];
}

+ (NSString *)getTagIdFromSession:(NFCNDEFReaderSession *)session  API_AVAILABLE(ios(11.0)) {
    NSData *uuidData = [NSData data];
    if ([session valueForKey:@"_connectedTag"]){
        NSObject *tag = [session valueForKey:@"_connectedTag"];
        if ([tag valueForKey:@"_uid"]){
            NSData *uuidPadded = [tag valueForKey:@"_uid"];
            uuidData = [NSData dataWithBytes:[uuidPadded bytes] length:7];
        }
    }
    if (uuidData) {
        return [self convertDataBytesToHex:uuidData];
    }
    return @"";
}

+ (NSString *)convertDataBytesToHex:(NSData *)dataBytes {
    if (!dataBytes || [dataBytes length] == 0) {
        return @"";
    }
    NSMutableString *hexStr = [[NSMutableString alloc] initWithCapacity:[dataBytes length]];
    [dataBytes enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char *)bytes;
        for (NSInteger i = 0; i < byteRange.length; i ++) {
            NSString *singleHexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            NSString *seporator = @":";
            if (i == byteRange.length - 1) {
                seporator = @"";
            }
            
            if ([singleHexStr length] == 2) {
                [hexStr appendFormat:@"%@%@", [singleHexStr uppercaseString], seporator];
            } else {
                [hexStr appendFormat:@"0%@%@", [singleHexStr uppercaseString], seporator];
            }
        }
    }];
    return hexStr;
}

@end
