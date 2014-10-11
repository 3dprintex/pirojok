//
//  TPActivity.m
//  TimeToPlay
//
//  Created by Slava Bulgakov on 25.05.13.
//  Copyright (c) 2013 Devpocket. All rights reserved.
//

#import "PRActivity.h"
#import "PRCommon.h"
#import <QuartzCore/QuartzCore.h>

#define MARGIN 15

@interface PRActivity() {
    UIActivityIndicatorView *_activity;
    UILabel *_label;
    NSTimer *_timer;
    UIView *_backView;
    UIView *_currentView;
}

@end

@implementation PRActivity

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = .8;
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
        [self addSubview:_backView];
        self.alpha = .0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self _update];
}

#pragma mark - public methods
-(void)show {
    if (_timer != nil) {
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:kActivityTimerInterval target:self selector:@selector(_firedTimer) userInfo:nil repeats:NO];
}

-(void)showWithText:(NSString *)text {
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.numberOfLines = 0;
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:_label];
    }
    _label.text = text;
    [_label sizeToFit];
    [self _showSubview:_label];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

-(void)hide {
    [self _animateHide:YES completion:^(BOOL finished) {
        [_activity stopAnimating];
        _activity.hidden = YES;
        _label.hidden = YES;
    }];
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - private methods
-(void)_animateHide:(BOOL)hide completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:.4 animations:^{
        if (hide) {
            self.alpha = .0;
        } else {
            self.alpha = 1.0;
        }
    } completion:completion];
}

-(void)_tap:(id)sender {
    if ([_currentView isKindOfClass:[UILabel class]]) {
        [self hide];
    }
}

-(void)_update {
    _backView.frame = CGRectMake(0, 0, _currentView.frame.size.width + MARGIN * 2, _currentView.frame.size.height + MARGIN * 2);
    _currentView.center = CGPointMake(_backView.frame.size.width / 2, _backView.frame.size.height / 2);
    _currentView.frame = CGRectRoundOrigin(_currentView.frame);
    _backView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _backView.frame = CGRectRoundOrigin(_backView.frame);
}

-(void)_showSubview:(UIView *)view {
    _currentView = view;
    [self _update];
    view.hidden = NO;
    [self _animateHide:NO completion:nil];
}

-(void)_firedTimer {
    if (_activity == nil) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_backView addSubview:_activity];
    }
    [self _showSubview:_activity];
    [_activity startAnimating];
    [_timer invalidate];
    _timer = nil;
    [self.superview bringSubviewToFront:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
