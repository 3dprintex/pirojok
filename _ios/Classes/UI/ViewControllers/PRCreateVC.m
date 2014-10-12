//
//  PRCreateVC.m
//  Pirojok
//
//  Created by Slava Bulgakov on 12.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRCreateVC.h"
#import "PRModel.h"

@interface PRCreateVC ()

@property (weak, nonatomic) IBOutlet UIButton *photoView;
@property (weak, nonatomic) IBOutlet UITextView *text;

@end

@implementation PRCreateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[PRModel sharedInstance] createMessage];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIImage *image = [PRModel sharedInstance].sendingMessage.image;
    [self.photoView setBackgroundImage:image forState:UIControlStateNormal];
    [self.text becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)_send:(id)sender {
    [self showActivity];
    [PRModel sharedInstance].sendingMessage.text = self.text.text;
    [[PRModel sharedInstance] sendMessage:[PRModel sharedInstance].sendingMessage completion:^(BOOL success, NSString *message) {
        [self hideActivity];
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            if (message.length > 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }];
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
