//
//  PRMessage.h
//  Pirojok
//
//  Created by Slava Bulgakov on 12.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PRRequestData.h"

@interface PRMessageData : PRRequestData

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, copy) NSString *text;

@end
