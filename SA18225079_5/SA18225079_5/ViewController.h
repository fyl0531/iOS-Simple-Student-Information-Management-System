//
//  ViewController.h
//  SA18225079_5
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019年 SA18225079. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teacher+CoreDataClass.h"
@interface ViewController : UIViewController
@property (strong,nonatomic) NSMutableArray *students;
@property (strong,nonatomic) Teacher *teacher;
@property (strong,nonatomic) NSIndexPath *indexPath;
@property (strong,nonatomic) NSManagedObjectContext *context;

@end

