//
//  MainViewController.m
//  BlockDemo
//
//  Created by Joey on 2014/1/8.
//  Copyright (c) 2014年 Joey. All rights reserved.
//

#import "MainViewController.h"
//定義一個block類型
typedef int(^Myblock)(int);//block寫法2
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     //----------block寫法1-----------------
    /*
    //1.聲明(宣告)一個Block
    int(^myBlock)(int);
    
    //2.建立block內的功能
    myBlock = ^(int a){
        NSLog(@"參數:%d",a);
        return 10;
    };
    
    //3.調用block
    int ret =  myBlock(20);
    NSLog(@"ret:%d",ret);
    
    
    
   第二種宣告方式
    int(^myBlock)(int)= ^(int a){
        
        return 10;
    };
    */
    //----------block寫法1-----------------
    
    //----------block寫法2-----------------
   //建立block內的功能
   // Myblock myblock= ^(int a){
   //     NSLog(@"參數:%d",a);
   //     return 20;
    
   // };
   // myblock(10);
     //----------block寫法2-----------------
    
    
    //------------block作為參數-------------
    Myblock myblock= ^(int a){
        NSLog(@"這是block程式碼塊 a=%d",a);
        return 20;
        
    };
    [self test:myblock];
    //------------block作為參數 end-------------
    
    //-------------block引用局部變數-------------
    //block引用局部變數時,該變數會作為"常數"編碼到block塊中
    __block  int number = 20; //用__block修飾,才可以在block內修改
    
    Myblock myblock2= ^(int a){
        number = 30;
        NSLog(@"number=%d",number);
        return 20;
        
    };
    myblock2(50);
    //-------------block引用局部變數 end-------------
    
    
}
/*
 
-(void)test:(int(^)(int))myBlock
{


}*/

-(void)test:(Myblock)myBlock
{
    myBlock(100);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
