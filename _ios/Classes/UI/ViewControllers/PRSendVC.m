//
//  ViewController.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRSendVC.h"
#import "UIImage+MDQRCode.h"
#import "PRModel.h"

@interface PRSendVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PRSendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage mdQRCodeForString:@"slava" size:100];
    self.imageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
