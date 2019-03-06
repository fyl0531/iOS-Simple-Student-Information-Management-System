//
//  ViewController.m
//  SA18225079_4
//
//  Created by apple on 2018/12/21.
//  Copyright © 2018年 SA18225079. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "TableViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TxtName;
@property (weak, nonatomic) IBOutlet UITextField *TxtNumber;
@property (weak, nonatomic) IBOutlet UITextField *TxtAge;
@property (weak, nonatomic) IBOutlet UITextField *TxtScore;
@property (weak, nonatomic) IBOutlet UITextView *TxtMemo;

@end

@implementation ViewController
- (IBAction)DataSave:(UIButton *)sender
{
    //用到归档和属性列表来保存信息
    //实例化Student对象，把内容保存到对象当中
    //把对象加入到对象数组，把数组序列化，保存到属性列表中去
    TableViewController *tc=[[TableViewController alloc] init];
    Student *student=[[Student alloc]init];
    student.name=self.TxtName.text;
    student.number=self.TxtNumber.text;
    student.age=[self.TxtAge.text floatValue];
    student.score=[self.TxtScore.text floatValue];
    student.memo=self.TxtMemo.text;
    student.teacher=@"Tian bai";
    
    if (self.indexPath==nil)
    {
        [self.students addObject:student];
        [tc writeToFile:self.students filePath:self.path];
    }
    else
    {
        self.students[self.indexPath.row]=student;
         [tc writeToFile:self.students filePath:self.path];         //修改后保存
    }
    //代码方式返回
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)DataClear:(UIButton *)sender
{
    self.TxtName.text=nil;
    self.TxtNumber.text=nil;
    self.TxtAge.text=nil;
    self.TxtScore.text=nil;
    self.TxtMemo.text=nil;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if(self.indexPath!=nil)
    {
        Student *student=self.students[self.indexPath.row];
        self.TxtName.text=student.name;
        self.TxtNumber.text=student.number;
        self.TxtAge.text=[NSString stringWithFormat:@"%ld",(long)student.age];
        self.TxtScore.text=[NSString stringWithFormat:@"%f",student.score];
        self.TxtMemo.text=student.memo;
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
