//
//  Student.m
//  SA18225079_4
//
//  Created by apple on 2018/12/21.
//  Copyright © 2018年 SA18225079. All rights reserved.
//

#import "Student.h"

@implementation Student
//想要序列化，必须实现NSCoding这两个方法
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.number forKey:@"number"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeFloat:self.score forKey:@"score"];
    [aCoder encodeObject:self.teacher forKey:@"teacher"];
    [aCoder encodeObject:self.memo forKey:@"memo"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
    
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.number=[aDecoder decodeObjectForKey:@"number"];
        self.age=[aDecoder decodeIntegerForKey:@"age"];
        self.score=[aDecoder decodeFloatForKey:@"score"];
        self.memo=[aDecoder decodeObjectForKey:@"memo"];
        self.teacher=[aDecoder decodeObjectForKey:@"teacher"];
    }
    return self;
}

@end
