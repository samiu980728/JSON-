//
//  proinvenceWeather.h
//  JSON解析（反序列化）
//
//  Created by 萨缪 on 2018/8/13.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface proinvenceWeather : NSObject

@property (nonatomic, copy) NSString * Cid;

@property (nonatomic, copy) NSString * location;

@property (nonatomic, copy) NSString * parentCity;

@property (nonatomic, copy) NSString * adminArea;

@property (nonatomic, copy) NSString * lat;

@property (nonatomic, copy) NSString * lon;

@property (nonatomic, copy) NSString * tz;

@end
