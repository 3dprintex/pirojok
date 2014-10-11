//
//  PRRequestData.m
//  Pirojok
//
//  Created by Slava Bulgakov on 11.10.14.
//  Copyright (c) 2014 Slava Bulgakov. All rights reserved.
//

#import "PRRequestData.h"
#import "NSString+URLEncoding.h"

@implementation PRRequestData

-(NSString *)_arrayToPhpString:(NSArray *)array withPrefix:(NSString *)prefix {
    NSString *result = @"";
    NSInteger index = 0;
    for (id value in array) {
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSSet class]]) {
            NSString *subResult = [self _arrayToPhpString:value withPrefix:[prefix stringByAppendingFormat:@"[%d]", index]];
            result = [result stringByAppendingFormat:@"%@", subResult];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            NSString *subResult = [self _dictToPhpString:value withPrefix:[prefix stringByAppendingFormat:@"[%d]", index]];
            result = [result stringByAppendingFormat:@"%@", subResult];
        } else {
            result = [result stringByAppendingFormat:@"&%@[]=%@", prefix, value];
        }
        index++;
    }
    return result;
}

-(NSString *)_dictToPhpString:(NSDictionary *)dict withPrefix:(NSString *)prefix {
    NSString *result = @"";
    for (id key in dict.allKeys) {
        NSString *key_ = [key urlencode];
        id value = [dict valueForKey:key];
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSSet class]]) {
            NSString *subResult = nil;
            if (prefix.length == 0) {
                subResult = [self _arrayToPhpString:value withPrefix:key_];
            } else {
                subResult = [self _arrayToPhpString:value withPrefix:[prefix stringByAppendingFormat:@"[%@]", key_]];
            }
            result = [result stringByAppendingFormat:@"%@", subResult];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            NSString *subResult = nil;
            if (prefix.length == 0) {
                subResult = [self _dictToPhpString:value withPrefix:key_];
            } else {
                subResult = [self _dictToPhpString:value withPrefix:[prefix stringByAppendingFormat:@"[%@]", key_]];
            }
            result = [result stringByAppendingFormat:@"%@", subResult];
        } else {
            value = [value urlencode];
            if (prefix.length == 0) {
                result = [result stringByAppendingFormat:@"&%@=%@", key, value];
            } else {
                result = [result stringByAppendingFormat:@"&%@[%@]=%@", prefix, key, value];
            }
        }
    }
    return result;
}

-(NSData *)getPhpData {
    id data = self.getData;
    NSString *result;
    if ([data isKindOfClass:[NSDictionary class]]) {
        result = [self _dictToPhpString:data withPrefix:@""];
    } else {
        result = [self _arrayToPhpString:data withPrefix:@""];
    }
    if ([[result substringToIndex:1] isEqualToString:@"&"]) {
        result = [result substringFromIndex:1];
    }
    NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
    return dataResult;
}

-(id)getData {
    return nil;
}

@end
