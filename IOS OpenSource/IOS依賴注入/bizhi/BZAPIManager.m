//
//  BZAPIManager.m
//  bizhi
//
//  Created by Limboy on 4/28/14.
//  Copyright (c) 2014 Huaban. All rights reserved.
//

#import "BZAPIManager.h"
#import <ReactiveCocoa.h>
#import <AFNetworking-RACExtensions/AFHTTPRequestOperationManager+RACSupport.h>
#import "BZTagModel.h"
#import "BZPinModel.h"

@implementation BZAPIManager

+ (instancetype)sharedManager
{
    static BZAPIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self manager];
    });
    return instance;
}

- (RACSignal *)fetchPinsWithTag:(NSString *)tag offset:(NSInteger)offset limit:(NSInteger)limit
{
    NSString *max = offset ? [NSString stringWithFormat:@"&max=%d", offset] : @"";
    tag = tag ? [NSString stringWithFormat:@"&tag=%@", [tag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] : @"";
    NSString *urlString = [NSString stringWithFormat:@"http://api.huaban.com/fm/wallpaper/pins?limit=%d%@%@", limit, max, tag];
    return [self fetchPinsWithURL:urlString];
}

- (RACSignal *)fetchPinsWithURL:(NSString *)urlString
{
    return [[self rac_GET:urlString parameters:nil] map:^id(NSDictionary *data) {
        return [[((NSArray *)data[@"pins"]).rac_sequence map:^id(id value) {
            return [[BZPinModel alloc] initWithDictionary:value error:nil];
        }] array];
    }];
}

- (RACSignal *)fetchTags
{
    return [[self rac_GET:@"http://api.huaban.com/fm/wallpaper/tags" parameters:nil] map:^id(NSArray *tags) {
        return [[tags.rac_sequence map:^id(id value) {
            return [[BZTagModel alloc] initWithDictionary:value error:nil];
        }] array];
    }];
}

@end
