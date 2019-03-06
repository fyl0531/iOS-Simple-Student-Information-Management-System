//
//  Student.h
//  SA18225079_4
//
//  Created by apple on 2018/12/21.
//  Copyright © 2018年 SA18225079. All rights reserved.
//

#import <Foundation/Foundation.h>

//学生类
//自己定义的类要实现序列化，需要实现NSCoding协议
@interface Student : NSObject<NSCoding>
//属性
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *number;
@property(nonatomic)NSInteger age;
@property(nonatomic)float score;
@property(strong,nonatomic)NSString *memo;
@property(strong,nonatomic)NSString *teacher;

@end
