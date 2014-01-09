// 
//  main.m
//  BookKVCDemo
//  
//  Created by Joey on 12-11-23.
//  Copyright (c) 2012年  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Book *book = [[Book alloc] init];
        Author *author = [[Author alloc] init];
        [author setValue:@"jack" forKey:@"_name"];
        //鍵值設置 setValue  forKey
        [book setValue:[NSNumber numberWithFloat:12.6] forKey:@"price"];
        
        //訪問 valueForKeyPath
        NSNumber *price = [book valueForKeyPath:@"price"];
        NSLog(@"%@",price);
        
        
        [book setValue:@"ipad develper" forKey:@"name"];
        [book setValue:author forKey:@"_author"];
        
        //路徑設置setValue forKeyPath
        [book setValue:@"tom" forKeyPath:@"author.name"];
        //訪問valueForKeyPath
        NSString *authorName = [book valueForKeyPath:@"_author._name"];
        NSLog(@"%@",authorName);
        
        //一對多的關係
        NSMutableArray *releBooks = [NSMutableArray arrayWithCapacity:3];
        for (int i=0; i<3; i++) {
            Book *book = [[Book alloc] init];
            NSString *name = [NSString stringWithFormat:@"job_%d",i];
            [book setValue:name forKey:@"_name"];
            
            [book setValue:@(12+i) forKey:@"price"];
            [releBooks addObject:book];
            [book release];
        }
        [book setValue:releBooks forKey:@"_relativeBooks"];
        
//        NSArray *names = [book valueForKeyPath:@"_relativeBooks._name"];
//        NSLog(@"%@",names);
        
//        NSArray *names = [releBooks valueForKeyPath:@"_name"];
//        NSLog(@"%@",names);
        
        //運算, 運算的欄位必須是數值類型NSNumber或者基本數據類型,計算的結果是NSNumber
        //運算關鍵字sum、min、max、avg、count
        NSNumber *sum = [book valueForKeyPath:@"_relativeBooks.@avg.price"];
        NSLog(@"sum: %@",sum);
        
    }
    return 0;
}

