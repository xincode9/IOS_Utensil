//
//  User.m
//  CustomArchivie
//
//  Created by Joey on 12-11-22.
//  Copyright (c) 2012年  All rights reserved.
//

#import "User.h"

#define AGE @"age"
#define NAME @"name"
#define EMAIL @"email"
#define PASSWORD @"password"

@implementation User
#pragma mark - NSCoding delegate
//對属性編碼，歸檔時調用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInt:_age forKey:AGE];
    [aCoder encodeObject:_name forKey:NAME];
    [aCoder encodeObject:_email forKey:EMAIL];
    [aCoder encodeObject:_password forKey:PASSWORD];
    
}


//對屬性解碼，解歸檔調用
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        _age = [aDecoder decodeIntForKey:AGE];
        self.name = [aDecoder decodeObjectForKey:NAME];
        self.email = [aDecoder decodeObjectForKey:EMAIL];
        self.password = [aDecoder decodeObjectForKey:PASSWORD];
    }
    return self;
}

//----------------------
//覆寫description
- (NSString *)description {
    NSString *str = [NSString stringWithFormat:@"age=%d,name=%@,email=%@,pass=%@",_age,_name,_email,_password];
    return str;
}
- (void)dealloc {
    [_password release];
    [_email release];
    [_name release];
    [super dealloc];
}

@end
