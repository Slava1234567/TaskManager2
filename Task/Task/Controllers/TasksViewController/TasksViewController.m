//
//  TasksViewController.m
//  Task
//
//  Created by Slava on 5/16/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "TasksViewController.h"
#import "AddTaskViewController.h"
#import "InfoViewController.h"
#import "TaskView.h"

@interface TasksViewController () <AddTaskViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray<Task *> *tasksArray;
@property (nonatomic, retain) TaskView *taskView;

@end

@implementation TasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tasks";
    
    _tasksArray = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addButttonTapped:)];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Info" style:UIBarButtonItemStyleDone target:self action:@selector(infoButttonTapped:)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    [rightButton release];
    [leftButton release];
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:self.view.frame] autorelease];
    [self.view addSubview:self.scrollView];
}

- (void)addButttonTapped:(id)sender {
    AddTaskViewController *addTaskViewController = [[AddTaskViewController alloc] init];
    addTaskViewController.delegate = self;
    
    [self.navigationController pushViewController:addTaskViewController animated:true];
}

- (void)infoButttonTapped:(id)sender {
    InfoViewController *addTaskViewController = [[InfoViewController alloc] init];
    [self.navigationController pushViewController:addTaskViewController animated:true];
}

// AddTaskViewControllerDelegate protocol required method
-(void)saveNewTask:(Task *)task {
    [self createObjectTaskView];
    [self.taskView setValueInSubviewsTitle:task.title description:task.descript detail:task.details];
    [_tasksArray addObject:task];
    self.taskView.tag = self.tasksArray.count;
    
    
    
    for (Task *task in _tasksArray) {
        NSLog(@"Task title: %@, descr - %@", task.title,task.descript);
    }
}

- (void)createObjectTaskView {
    
    CGFloat height = 200.0f;
    CGRect frame = CGRectMake(self.scrollView.bounds.origin.x,
                              height * self.tasksArray.count,
                              self.scrollView.bounds.size.width,
                              height);
    
    self.taskView = [[[TaskView alloc] initWithFrame:frame]autorelease];
    self.taskView.backgroundColor = [UIColor yellowColor];
    [self.taskView addSubViews];
    
    UITapGestureRecognizer *tapGestore = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.taskView addGestureRecognizer:tapGestore];
    
    [tapGestore release];
}

- (void)handleTap:(UITapGestureRecognizer*) tapGestore {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit" message:@"Do you want to edit your Task" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        [self.taskView removeFromSuperview];
//        [self.tasksArray removeObjectAtIndex:tapGestore.view.tag];
//        AddTaskViewController *vc = [[AddTaskViewController alloc] init];
//        [self presentViewController:vc animated:true completion:nil];
        NSLog(@"go go");
    }];
    [alertController addAction:actionNo];
    [alertController addAction:actionYes];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.taskView) {
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.taskView.frame.size.height * self.tasksArray.count);
        [self.scrollView addSubview:self.taskView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_tasksArray release];
    [_taskView release];
    [_scrollView release];
    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
