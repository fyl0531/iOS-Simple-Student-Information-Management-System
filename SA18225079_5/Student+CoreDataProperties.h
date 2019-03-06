//
//  Student+CoreDataProperties.h
//  SA18225079_5
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019年 SA18225079. All rights reserved.
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *number;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *memo;
@property (nonatomic) float score;
@property (nullable, nonatomic, retain) Teacher *whoTeach;

@end

NS_ASSUME_NONNULL_END
