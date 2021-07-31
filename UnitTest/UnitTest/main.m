//
//  main.m
//  UnitTest
//
//  Created by leeyeon2 on 2021/07/05.
//

#import <Foundation/Foundation.h>
#import "EncodingTest.h"
NSString * decodedRst;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //인코딩 테스트
        char inputString [500];
        NSLog(@"인코딩 할 값 :");
        scanf("%s",inputString);
        NSString * encodedRst = [[NSString alloc] initWithCString: inputString encoding: NSUTF8StringEncoding];

        //url 인코딩
        encodedRst = [EncodingTest encodeURL:encodedRst];
        //base64 인코딩
        encodedRst = [EncodingTest encodeStringToBase64:encodedRst];
        NSLog(@"encoding Result: %@",encodedRst);
        
        
        //디코딩 테스트
//        char word [500];
//        NSLog(@"디코딩 할 값 :");
//        scanf("%s",word);
//        //디코딩할 값
//        decodedRst = [[NSString alloc] initWithCString: word encoding: NSUTF8StringEncoding];
        decodedRst = encodedRst;
        
        decodedRst = [EncodingTest decodeBase64ToString:decodedRst];
        NSLog(@"decoding Result: %@",decodedRst);
        
    }
    return 0;
}


