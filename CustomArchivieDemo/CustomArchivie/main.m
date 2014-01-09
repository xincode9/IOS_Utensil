//
//  main.m
//  CustomArchivie
//
//  Created by Joey on 12-11-22.
//  Copyright (c) 2012年  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
//        User *user = [[User alloc] init];
//        user.name = @"joey";
//        user.age = 24;
//        user.email = @"321@gmail.com";
//        user.password = @"123456";
//        
//        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"user.archiver"];
//        BOOL success = [NSKeyedArchiver archiveRootObject:user toFile:path];
//        if (success) {
//            NSLog(@"archive success");
//        }
//        [user release];
        
        
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"user.archiver"];
        User *user = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        NSLog(@"%@",user);
    }
    return 0;
}

