//
//  AppDelegate.h
//  SA18225079_5
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019年 SA18225079. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(readonly,strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property(readonly,strong,nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

