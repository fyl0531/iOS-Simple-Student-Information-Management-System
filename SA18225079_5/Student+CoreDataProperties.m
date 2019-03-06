//
//  Student+CoreDataProperties.m
//  SA18225079_5
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019年 SA18225079. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic number;
@dynamic age;
@dynamic memo;
@dynamic score;
@dynamic whoTeach;

@end
