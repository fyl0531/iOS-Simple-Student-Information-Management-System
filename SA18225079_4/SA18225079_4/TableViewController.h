//
//  TableViewController.h
//  SA18225079_4
//
//  Created by apple on 2018/12/21.
//  Copyright © 2018年 SA18225079. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController
-(void)writeToFile:(NSMutableArray*)sts filePath:(NSString*)path;
@end
