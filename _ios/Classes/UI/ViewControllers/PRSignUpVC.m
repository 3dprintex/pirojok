//
//  PRSignUpVC.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRSignUpVC.h"
#import "PRModel.h"

@interface PRSignUpVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) void(^completion)();

@end

@implementation PRSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[PRModel sharedInstance] preSignUpWithCompletion:^(BOOL success) {
        int sdf = 0;
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.name becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)_signUpTap:(id)sender {
    [[PRModel sharedInstance] signUpWithLogin:self.login.text andPassword:self.password.text andUsername:self.name.text completion:^(BOOL success) {
        int sdf = 0;
    }];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    UITextField *nextField = (UITextField *)[self.view viewWithTag:textField.tag + 1];
    if (nextField) {
        [nextField becomeFirstResponder];
    } else {
        [self _signUpTap:nil];
    }
    return YES;
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
