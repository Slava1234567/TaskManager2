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
#import "DeleteView.h"

#import "Task.h"

@interface TasksViewController () <AddTaskViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray<Task *> *taskArray;
@property (nonatomic, strong) NSMutableArray<TaskView *> *taskViewArray;
@property (nonatomic, retain) DeleteView* deleteView;


@end

@implementation TasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tasks";
    

    _taskArray = [[NSMutableArray alloc] init];
    _taskViewArray = [[NSMutableArray alloc] init];

    
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
    task.tag = _taskArray.count;
    [_taskArray addObject:task];
    
    CGFloat height = 130;
    CGRect frame = CGRectMake(self.scrollView.bounds.origin.x, height * _taskViewArray.count, self.scrollView.bounds.size.width, height);
    
    TaskView *taskView = [[TaskView alloc] initWithFrame:frame];
    
  
    taskView.tag = _taskViewArray.count;
    [taskView updateViewWithTask:task];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [taskView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [taskView addGestureRecognizer:doubleTapGesture];
    [doubleTapGesture release];
    
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    [taskView addGestureRecognizer:panGesture];
//    [panGesture release];
    
    [_taskViewArray addObject:taskView];
    
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, height * _taskArray.count);
    [_scrollView addSubview:_taskViewArray.lastObject];
    
    [taskView release];
}

- (void) handlePan:(UIPanGestureRecognizer*)panGestore {
    
    if (panGestore.state == UIGestureRecognizerStateBegan ||
        panGestore.state == UIGestureRecognizerStateChanged ||
        panGestore.state == UIGestureRecognizerStateEnded) {

        [self.deleteView removeFromSuperview];
        self.deleteView = [[DeleteView redrawDeleteViewWithGestoreSuperView:panGestore] init];
        self.deleteView.tag = panGestore.view.tag;
        UITapGestureRecognizer *tapDeleteGestore = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapDelete:)];
        
        [self.deleteView addGestureRecognizer:tapDeleteGestore];

        TaskView *taskView = [self.taskViewArray[panGestore.view.tag] retain];
        [taskView addSubview:self.deleteView];

        [self.deleteView release];
        [taskView release];

    }
}

- (void) handleTapDelete:(UITapGestureRecognizer*) tapDeleteGestore {
    
    
    [_taskArray removeObjectAtIndex:tapDeleteGestore.view.tag];
    [_taskViewArray[tapDeleteGestore.view.tag] removeFromSuperview];
    [_taskViewArray removeObjectAtIndex:tapDeleteGestore.view.tag];
    
    [self reloadTasksFromRow:tapDeleteGestore.view.tag];

}

-(void)updateTask:(Task *) task {
    [_taskViewArray[task.tag] updateViewWithTask:task];
}

-(void)reloadTasksFromRow:(NSInteger) row {
    CGFloat height = 130;
    
    for (NSInteger i = row; i < _taskViewArray.count; i++) {
        [_taskViewArray[i] setFrame:CGRectMake(self.scrollView.bounds.origin.x,
                                               height * i,
                                               self.scrollView.bounds.size.width,
                                               height)];
        
        _taskArray[i].tag = i;
        _taskViewArray[i].tag = i;
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width,
                                             height * _taskViewArray.count);
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer*)doubleTapGesture {
    NSLog(@"double tap");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Action" message:@"Choose action" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionEdit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddTaskViewController *addTaskViewController = [[AddTaskViewController alloc] init];
        addTaskViewController.delegate = self;
        addTaskViewController.task = _taskArray[doubleTapGesture.view.tag];
        
        [self.navigationController pushViewController:addTaskViewController animated:true];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:actionEdit];
    [alertController addAction:actionCancel];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)handleTap:(UITapGestureRecognizer*) tapGesture {
    
    for (TaskView *taskView in self.taskViewArray) {
        for (UIGestureRecognizer* gestureRecognizer in taskView.gestureRecognizers) {
            if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
                [taskView removeGestureRecognizer:gestureRecognizer];
            }
        }
            taskView.layer.borderWidth = 0.4;
    }
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    if (self.deleteView) {
        [self.deleteView removeFromSuperview];
        self.deleteView = nil;
        tapGesture.view.layer.borderWidth = 0.4;
        
    } else {
        tapGesture.view.layer.borderWidth = 2;
        [tapGesture.view addGestureRecognizer:panGesture];
        [panGesture release];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.deleteView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_taskArray release];
    [_taskViewArray release];
    [_scrollView release];

    [super dealloc];
}

@end
