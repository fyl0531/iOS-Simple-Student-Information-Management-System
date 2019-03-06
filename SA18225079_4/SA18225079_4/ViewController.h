//
//  ViewController.h
//  SA18225079_4
//
//  Created by apple on 2018/12/21.
//  Copyright © 2018年 SA18225079. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(strong,nonatomic) NSMutableArray *students;   //把所有学生对象放到可变数组中去
@property(strong,nonatomic) NSIndexPath *indexPath;     //当选中表单元，存放其位置信息
@property(strong,nonatomic) NSString *path;     //保存目录，即文件存在哪里

@end

