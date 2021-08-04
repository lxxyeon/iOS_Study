//
//  ViewController.m
//  NFC_Obj
//
//  Created by leeyeon2 on 2021/08/02.
//

#import "ViewController.h"
#import "NFCManager.h"

@interface ViewController (){
    NFCManager *nfcManager;
    __weak IBOutlet UITextView *nfcInfoText;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    nfcManager = [NFCManager shared];
    nfcManager.nfcndefMessage = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    for (NFCNDEFMessage *message in nfcManager.nfcndefMessage) {
        NSLog(@"session : %@", message);

    }
}

- (IBAction)startNFCScan:(id)sender {
    [nfcManager startNFCScan];
}

@end
