//
//  ViewController.m
//  SA18225079_5
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019年 SA18225079. All rights reserved.
//

#import "ViewController.h"
#import "Student+CoreDataProperties.h"

#import "TableViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TxtName;
@property (weak, nonatomic) IBOutlet UITextField *TxtNumber;
@property (weak, nonatomic) IBOutlet UITextField *TxtAge;
@property (weak, nonatomic) IBOutlet UITextField *TxtScore;
@property (weak, nonatomic) IBOutlet UITextView *TxtMemo;
@property (weak, nonatomic) IBOutlet UITextField *TxtTeacher;

@end

@implementation ViewController

- (IBAction)DataSave:(UIButton *)sender {
    Student *stu;
    if(self.indexPath==nil)
    {//没有传进已有对象的行的位置，新建
        stu=[NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
        [self.students addObject:stu];
    }
    else
    {
        stu=self.students[self.indexPath.row];
    }
    
    stu.name=self.TxtName.text;
    stu.number=self.TxtNumber.text;
    stu.age=[self.TxtAge.text floatValue];
    stu.score=[self.TxtScore.text floatValue];
    stu.memo=self.TxtMemo.text;
    stu.whoTeach=self.teacher;
    NSError *errorstudent;
    if(![self.context save:&errorstudent])
    {
        NSLog(@"保存时出错：%@",errorstudent);
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)DataClear:(UIButton *)sender {
    
    self.TxtName.text=nil;
    self.TxtNumber.text=nil;
    self.TxtAge.text=nil;
    self.TxtScore.text=nil;
    self.TxtMemo.text=nil;
    self.TxtTeacher.text=nil;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    if(self.indexPath!=nil)
    {
        Student *student=self.students[self.indexPath.row];
        self.TxtName.text=student.name;
        self.TxtNumber.text=student.number;
        self.TxtAge.text=[NSString stringWithFormat:@"%ld",(long)student.age];
        self.TxtScore.text=[NSString stringWithFormat:@"%f",student.score];
        self.TxtMemo.text=student.memo;
        self.TxtTeacher.text=student.whoTeach.name;
    }
    else
    {
        
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}





@end
