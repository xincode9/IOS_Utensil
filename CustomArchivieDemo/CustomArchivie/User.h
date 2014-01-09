//
//  User.h
//  CustomArchivie
//
//  Created by Joey on 12-11-22.
//  Copyright (c) 2012年  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,assign)int age;

@end
