//
//  QTNetworkManager.m
//  QTModuleNetwork
//
//  Created by ☺strum☺ on 2018/11/21.
//  Copyright © 2018年 l. All rights reserved.
//

#import "QTNetworkManager.h"
#import "AFNetworking.h"

@implementation QTNetworkManager

#pragma mark pod 更新测试
+(void)updateTest{
    NSLog(@"updateTest");
}

#pragma mark - get 请求
+(void)requestGetWithUrl:(NSString*)url Headers:(NSDictionary*)headers success:(void (^)(id response))success fail:(void (^)(NSError *error))fail{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy = securityPolicy;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if(headers){
        [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    [manager.requestSerializer setTimeoutInterval:5];
    
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            fail(error);
        } else {
            NSLog(@"get success url--- %@",url);
            success(responseObject);
        }
    }];
    
    [dataTask resume];
}


#pragma mark  rac get
+(RACSignal *)racRequestGetWithUrl:(NSString*)url Headers:(NSDictionary*)headers{
    @weakify(self)
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        
        [self requestGetWithUrl:url Headers:headers success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } fail:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
        
    }];
}






#pragma mark - post 请求
+(void)requestPostData:(NSData *)postData ServerUrl:(NSString *)url bodyType:(NSString *)bodyType Headers:(NSDictionary*)headers success:(void (^)(id response))success fail:(void (^)(NSError *error))fail{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:[NSString stringWithFormat:@"text/%@",bodyType]];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy = securityPolicy;                //设置验证模式
    [manager.requestSerializer setTimeoutInterval:5];
    
    if(headers){
        [headers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [urlRequest setTimeoutInterval:15];
    [urlRequest setHTTPBody:postData];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:[NSString stringWithFormat:@"application/%@",bodyType] forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:[NSString stringWithFormat:@"application/%@",bodyType] forHTTPHeaderField:@"Accept"];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"NET WORK ERROR IN CellRefreshRequest: %@ code:%ld---url:%@", error.localizedDescription, (long)error.code,url);
            fail(error);
            
        } else {
            NSLog(@"post success url--- %@",url);
            success(responseObject);
        }
    }];
    [dataTask resume];
}


#pragma mark - rac post
+(RACSignal *)racRequestPostData:(NSData *)postData ServerUrl:(NSString *)url bodyType:(NSString *)bodyType Headers:(NSDictionary*)headers{
    
    @weakify(self)
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        
        [self requestPostData:postData ServerUrl:url bodyType:bodyType Headers:headers success:^(id response) {
            [subscriber sendNext:response];
            [subscriber sendCompleted];
        } fail:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    
}


@end
