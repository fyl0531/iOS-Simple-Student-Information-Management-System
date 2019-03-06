//
//  TableViewController.m
//  SA18225079_4
//
//  Created by apple on 2018/12/21.
//  Copyright © 2018年 SA18225079. All rights reserved.
//

#import "TableViewController.h"
#import "Student.h"
#import "ViewController.h"
@interface TableViewController ()
@property(strong,nonatomic) NSMutableArray *students;   //把所有学生对象放到可变数组中去
@property(strong,nonatomic) Student *student;   //当前选中的某个学生对象
@property(strong,nonatomic) NSString *path;     //保存目录，即文件存在哪里
@end

@implementation TableViewController

- (IBAction)refreshData:(UIRefreshControl *)sender {
    [self.refreshControl beginRefreshing];  //表示转轮开始转
    [self.tableView reloadData];    //
    [self.refreshControl endRefreshing];    //转轮停止
}


//把对象保存到磁盘中去
-(void)writeToFile:(NSMutableArray*)sts filePath:(NSString*)path
{
    NSData *data;
    NSMutableArray *ds=[[NSMutableArray alloc]init];
    for(Student *s in sts)
    {
        data=[NSKeyedArchiver archivedDataWithRootObject:s];
        [ds addObject:data];
    }
    [ds writeToFile:path atomically:YES];
}

-(void)viewWillAppear:(BOOL)animated
{//数据重新加载
    //NSLog(@"------%@",self.students);
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //找到目录
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    self.path=[doc stringByAppendingPathComponent:@"students.plist"];
    //把所有对象序列化后保存到这个路径所在的属性列表文件中
    NSMutableArray *dataarray=[NSMutableArray arrayWithContentsOfFile:self.path];
    self.students=[[NSMutableArray alloc]init];
    //从属性列表中取出来的对象为NSData,遍历解码为对象
    for(NSData *s in dataarray)
    {
        [self.students addObject:[NSKeyedUnarchiver unarchiveObjectWithData:s]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"addinfo"]){
        if([segue.destinationViewController isKindOfClass:[ViewController class]]){
            ViewController *vc =(ViewController *)segue.destinationViewController;
            vc.students=self.students;
            vc.indexPath=nil;
            vc.path=self.path;
        }
    }
    if([segue.identifier isEqualToString:@"showdetail"]){
        if([segue.destinationViewController isKindOfClass:[ViewController class]]){
            NSIndexPath *indexpath=[self.tableView indexPathForCell:sender];    //触碰的表单元，获取它的位置，放在indexpath里
            ViewController *vc=(ViewController*)segue.destinationViewController;
            vc.students=self.students;
            vc.indexPath=indexpath;
            vc.path=self.path;
        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//返回小结数
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//返回行数
    return [self.students count];
}

//每次表视图生成，可通过datasource协议里的方法把数据全部取出，然后显示表视图中去
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //生成cell实例对象
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"studentCell"forIndexPath:indexPath];
    //对对象赋值
    self.student=self.students[indexPath.row];
    cell.textLabel.text=self.student.name;
    cell.detailTextLabel.text=self.student.number;  //显示出来
    return cell;
}

//删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //当处于编辑状态时检查到底处于怎样的编辑状态，是删除还是其他状态
    if(editingStyle==UITableViewCellEditingStyleDelete){
        [self.students removeObjectAtIndex:indexPath.row];        //把表单指定的行删掉
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self writeToFile:self.students filePath:self.path];    //把数据中相应的对象删掉
    }
}
//编辑
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    //从故事板中实例化视图控制器modifyview
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"modifyview"];
    vc.students=self.students;
    vc.indexPath=indexPath;
    vc.path=self.path;
    //用代码方式过渡到编辑页面当中
    [self.navigationController pushViewController:vc animated:YES];
}

@end
