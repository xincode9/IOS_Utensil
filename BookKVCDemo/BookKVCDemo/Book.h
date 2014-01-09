//
//  Book.h
//  BookKVCDemo
//
//  Created by Joey 12-11-23.
//  Copyright (c) 2012年  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

@interface Book : NSObject {
@private
    NSString *_name;
    Author *_author;    //书的作者
    NSArray *_relativeBooks; //相关的书籍
    
    float price;        //书的价格
}

@end
