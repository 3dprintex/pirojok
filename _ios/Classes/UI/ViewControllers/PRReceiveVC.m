//
//  ReceiveVC.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRReceiveVC.h"
#import <AVFoundation/AVFoundation.h>

@interface PRReceiveVC ()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong) AVCaptureSession *captureSession;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *preveiwLayer;
@property(nonatomic, assign) BOOL hasCode;

@end

@implementation PRReceiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    AVCaptureDevice* inputDevice =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *captureInput =
    [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:nil];
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;
    [self.captureSession addInput:captureInput];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.captureSession addOutput:output];
    output.metadataObjectTypes = [output availableMetadataObjectTypes];
    
    self.preveiwLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.preveiwLayer.frame = self.view.bounds;
    self.preveiwLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.preveiwLayer];
    
    [self.captureSession startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type]) {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[self.preveiwLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil) {
            if (!self.hasCode) {
                self.hasCode = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"code: %@", detectionString);
                });
            }
            break;
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
