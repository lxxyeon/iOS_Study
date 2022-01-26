//
//  NFCManager.m
//  FunctionList_Objc
//
//  Created by leeyeon2 on 2022/01/26.
//

#import "NFCManager.h"

@implementation NFCManager

/**
 *  iOS11 - NFCNDEFReaderSession에서  uid 추출
 *
 *  @param session NFCNDEFReaderSession
 *
 *  @return uid
 */
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

/**
 *  iOS13 -  NFCTag에서  uid 추출
 *
 *  @param tag NFCTag
 *
 *  @return uid
 */
+ (NSString *)getStringTagIdentifierWithTag:(id<NFCTag>)tag  API_AVAILABLE(ios(13.0)) {
    return [self convertDataBytesToHex:[self tagIdentifierWithTag:tag]];
}

/**
 *  iOS13 -  NFCTag Type 구분
 *
 *  @param tag NFCTag
 *
 *  @return NFCTag Type
 */
+ (NSData *)tagIdentifierWithTag:(id<NFCTag>)tag  API_AVAILABLE(ios(13.0)) {
    switch (tag.type) {
        case NFCTagTypeISO15693:
            return [tag asNFCISO15693Tag].identifier;
        case NFCTagTypeFeliCa:
            return [tag asNFCFeliCaTag].currentIDm;
        case NFCTagTypeISO7816Compatible:
            return [tag asNFCISO7816Tag].identifier;
        case NFCTagTypeMiFare:
            return [tag asNFCMiFareTag].identifier;
        default:
            return nil;
    }
}

/**
 *  tag uid 타입형변환 Data > Hex
 *
 *  @param dataBytes tag uid Data 타입
 *
 *  @return tag uid Hex 타입
 */
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
