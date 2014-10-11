//
//  MainVC.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRMainVC.h"
#import "PRModel.h"

@interface PRMainVC ()

@end

@implementation PRMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showActivity];
    [[PRModel sharedInstance] checkAuth:^(BOOL success) {
        if (!success) {
            [self performSegueWithIdentifier:@"signIn" sender:self];
        }
        [self hideActivity];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
