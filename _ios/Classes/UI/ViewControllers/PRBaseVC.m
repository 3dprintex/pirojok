//
//  PRBaseVC.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRBaseVC.h"
#import "PRActivity.h"

@interface PRBaseVC () {
    PRActivity *_activity;
}

@end

@implementation PRBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)_showActivity {
    if (_activity == nil) {
        _activity = [[PRActivity alloc] initWithFrame:self.view.bounds];
        _activity.autoresizingMask = UIViewAutoresizingNone;
        [self.view addSubview:_activity];
    }
    [self _updateActivityPosition];
}

-(void)_updateActivityPosition {
    if (_activity != nil) {
        _activity.frame = self.view.bounds;
    }
}

-(void)showActivity {
    [self _showActivity];
    [_activity show];
}

-(void)hideActivity {
    [_activity hide];
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
