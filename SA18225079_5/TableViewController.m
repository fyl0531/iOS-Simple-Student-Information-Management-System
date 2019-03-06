//
//  TableViewController.m
//  SA18225079_5
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019年 SA18225079. All rights reserved.
//

#import "TableViewController.h"
#import "Student+CoreDataProperties.h"
#import "AppDelegate.h"
#import "Teacher+CoreDataProperties.h"
#import "ViewController.h"
@interface TableViewController ()
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSMutableArray *students;
@property (strong,nonatomic) Student *student;
@property (strong,nonatomic) Teacher *teacher;
@end

@implementation TableViewController

-(NSManagedObjectContext *) context
{//覆盖getter方法
    if(!_context)
    {
        AppDelegate *coreDataManager=[[AppDelegate alloc]init];
        _context=[[coreDataManager persistentContainer] viewContext];
    }
    return _context;
}

-(NSArray *)queryData:(NSString *) entityname sortWtih:(NSString *) sortDesc ascending:(BOOL) asc predicatString:(NSString *)ps
{
    NSFetchRequest *request=[[NSFetchRequest alloc]init];   //获取数据请求，对象实例化
    request.fetchLimit=100;
    request.fetchBatchSize=20;  //缓存设置
    //设置排序
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:sortDesc ascending:asc]];
    if(ps)
    {//若过滤条件不为空
        request.predicate=[NSPredicate predicateWithFormat:@"name contains %@",ps];
    }
    //获得实体
    NSEntityDescription *entity=[NSEntityDescription entityForName:entityname inManagedObjectContext:self.context];
    //执行
    request.entity=entity;
    NSError *error;
    //放入数组中
    NSArray *arrs=[self.context executeFetchRequest:request error:&error];
    if(error)
    {
        NSLog(@"无法获取数据, %@",error);
    }
    //返回数组
    return arrs;
}

-(void)loadData
{
    NSArray *arrstudents=[self queryData:@"Student" sortWtih:@"number" ascending:YES predicatString:nil];
    _students=[NSMutableArray array];   //初始化students属性
    for(Student *stu in arrstudents)
    {//把取回到对象放到可变数组中
        [_students addObject:stu];
    }
}

//覆盖students的getter方法
-(NSMutableArray *)students
{
    if(!_students)
    {
        [self loadData];
    }
    
    return _students;
}

-(Teacher *)teacher
{
    if(!_teacher)
    {
        NSArray *arrteacher=[self queryData:@"Teacher" sortWtih:@"name" ascending:YES predicatString:@"Bai Tian"];
        
        if(arrteacher.count>0)
        {   //有老师则保存
            _teacher=arrteacher[0];
        }
        else
        {
            NSError *error;
            //新建一个对象
            Teacher *th=[NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:self.context];
            //设置相关信息
            th.name=@"Bai Tian";
            th.age=99;
            th.number=@"ST00002";
            //保存到持久层
            [self.context save:&error];
            _teacher=th;
        }
    }
    return _teacher;
}


//并发多线程处理
- (IBAction)refreshData:(UIRefreshControl *)sender {
    [self.refreshControl beginRefreshing];
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self.students removeAllObjects];
        [self loadData];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [self.tableView reloadData];
                       });
    });
    [self.refreshControl endRefreshing];
}


-(void) viewWillAppear:(BOOL)animated
{
    [self.students removeAllObjects];
    [self loadData];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   }


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"addinfo"])
    {
        if([segue.destinationViewController isKindOfClass:[ViewController class]])
        {
            ViewController *vc=(ViewController *) segue.destinationViewController;
            vc.students=self.students;
            vc.context=self.context;
            vc.indexPath=nil;
            vc.teacher=self.teacher;
        }
    }
    
    if([segue.identifier isEqualToString:@"showdetail"])
    {
        if([segue.destinationViewController isKindOfClass:[ViewController class]])
        {
            NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
            ViewController *vc=(ViewController *) segue.destinationViewController;
            vc.students=self.students;
            vc.context=self.context;
            vc.indexPath=indexPath;
            vc.teacher=self.teacher;
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.students count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"studentCell" forIndexPath:indexPath];
    self.student=self.students[indexPath.row];
    cell.textLabel.text=self.student.name;
    cell.detailTextLabel.text=self.student.number;
    return cell;
}

//删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        [self.context deleteObject:self.students[indexPath.row]];
        [self.students removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSError *err;
        [self.context save:&err];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"modifyview"];
    vc.students=self.students;
    vc.indexPath=indexPath;
    vc.context=self.context;
    vc.teacher=self.teacher;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - searchBar coding
-(void)searchInName:(NSString *) searchString
{
    
    [self.students removeAllObjects];
    NSArray *arrstudents=[self queryData:@"Student" sortWtih:@"number" ascending:YES predicatString:searchString];
    for(Student *stu in arrstudents)
    {
        [self.students addObject:stu];
    }
    [self.tableView reloadData];
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length==0)
    {
        //[self searchInName:nil];
        return;
    }
    [self searchInName:searchText];
}
//键盘上seach按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchInName:searchBar.text];
    [searchBar resignFirstResponder];//收起键盘
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{//键盘上cancel按钮
    [self searchInName:nil];
    [searchBar resignFirstResponder];
}


@end
