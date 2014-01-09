//
//  main.m
//  ArchiverDemo1
//
//  Created by Joey on 13-11-22.
//  Copyright (c) 2013年  All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
//--------------------------1.第一種歸檔方式--------------------------------------------
        /***歸檔對象****/
//        NSArray *array = @[@"abc",@"123",@1234];
//        NSString *homePath = NSHomeDirectory();
          //文件名 以及副檔名
//        NSString *path = [homePath stringByAppendingPathComponent:@"test.arc"];
          // 歸檔
//        BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:path];
//        if (success) {
//            NSLog(@"archive success");
//        }
        
        /***解歸檔****/
//        NSString *homePath = NSHomeDirectory();
//        NSString *path = [homePath stringByAppendingPathComponent:@"test.arc"];
        //解歸檔 返回的是一個id類型
//        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        NSLog(@"%@",array);
        
        
        
//--------------------------2.第二種歸檔方式,可放多種類型--------------------------------------------
        /***歸檔對象**/
//        NSString *homePath = NSHomeDirectory();
//        NSString *path = [homePath stringByAppendingPathComponent:@"archiver2.archiv"];
//        NSMutableData *data = [NSMutableData data];
//        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//        NSArray *array = @[@"jack",@"tom"];
//        [archiver encodeInt:100 forKey:@"age"];
//        [archiver encodeObject:array forKey:@"names"];
//        [archiver finishEncoding];
//        [archiver release];
//        
//        BOOL success = [data writeToFile:path atomically:YES];
//        if (success) {
//            NSLog(@"archive success");
//        }
        
        /***解歸檔**/
        NSString *homePath = NSHomeDirectory();
        NSString *path = [homePath stringByAppendingPathComponent:@"archiver2.archiv"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        int age = [unArchiver decodeIntForKey:@"age"];
        NSArray *names = [unArchiver decodeObjectForKey:@"names"];
        [unArchiver release];
        NSLog(@"age=%d,names=%@",age,names);
    }
    return 0;
}

