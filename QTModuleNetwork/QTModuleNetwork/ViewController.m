//
//  ViewController.m
//  QTModuleNetwork
//
//  Created by ☺strum☺ on 2018/11/21.
//  Copyright © 2018年 l. All rights reserved.
//

#import "ViewController.h"
#import "QTNetworkManager.h"
#import "ReactiveObjC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)testHttp{
   
    NSString *url = @"http://115.28.115.220:3000/login";
    NSDictionary *dic = @{@"id":@"18654132058",@"name":@"strum"};
    NSData *data= [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    [[QTNetworkManager racRequestPostData:data ServerUrl:url bodyType:@"json" Headers:nil]  subscribeNext:^(id  _Nullable x) {
        //        @strongify(self);
        NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:x options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"TEST HTTP %@",dictionary);
    } error:^(NSError * _Nullable error) {
        NSLog(@"TEST HTTP %@",error.localizedDescription);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testHttp];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
