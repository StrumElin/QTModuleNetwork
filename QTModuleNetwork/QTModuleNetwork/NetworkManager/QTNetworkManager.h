//
//  QTNetworkManager.h
//  QTModuleNetwork
//
//  Created by ☺strum☺ on 2018/11/21.
//  Copyright © 2018年 l. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

@interface QTNetworkManager : NSObject

#pragma mark get 请求
/**
 * get 请求
 * @param url 请求地址
 * @param headers 头部字段
 * @param success 成功回调
 * @param fail 失败回调
 */
+(void)requestGetWithUrl:(NSString*)url Headers:(NSDictionary*)headers success:(void (^)(id response))success fail:(void (^)(NSError *error))fail;


/**
 * RAC get 请求
 * @param url 请求地址
 * @param headers 头部字段
 */
+(RACSignal *)racRequestGetWithUrl:(NSString*)url Headers:(NSDictionary*)headers;

#pragma mark post 请求
/**
 * post 请求
 * @param postData 请求数据
 * @param url 请求地址
 * @param bodyType 请求类型
 * @param success 失败回调
 * @param fail 失败回调
 */
+(void)requestPostData:(NSData *)postData ServerUrl:(NSString *)url bodyType:(NSString *)bodyType Headers:(NSDictionary*)headers success:(void (^)(id response))success fail:(void (^)(NSError *error))fail;

/**
 * RAC post 请求
 * @param postData 请求数据
 * @param url 请求地址
 * @param bodyType 请求类型
 */
+(RACSignal *)racRequestPostData:(NSData *)postData ServerUrl:(NSString *)url bodyType:(NSString *)bodyType Headers:(NSDictionary*)headers;



@end

