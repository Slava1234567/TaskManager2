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

@interface TasksViewController () <AddTaskViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray<Task *> *tasksArray;
@property (nonatomic, retain) TaskView *taskView;
@property (nonatomic, retain) NSMutableArray *arrayTaskView;
@property (nonatomic,assign) NSInteger indexForAnimation;
@property (nonatomic, retain) DeleteView* deleteView;

@end

@implementation TasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tasks";
    
    _tasksArray = [[NSMutableArray alloc] init];
    _arrayTaskView = [[NSMutableArray alloc] init];
    
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


-(void)saveNewTask:(Task *)task {
    
    [_tasksArray addObject:task];
   
}

- (void)createObjectTaskView:(NSInteger)offSet {
    
    CGFloat height = 200.0f;
    CGRect frame = CGRectMake(CGRectGetMinX(self.scrollView.bounds),
                              height * offSet,
                              self.scrollView.bounds.size.width,
                              height);
    
    self.taskView = [[TaskView alloc] initWithFrame:frame];
    self.taskView.tag = offSet;
    
    self.taskView.backgroundColor = [UIColor yellowColor];
    [self.taskView addSubViews];
    
    [self.arrayTaskView addObject:self.taskView];
    
    UITapGestureRecognizer *tapGestore = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                action:@selector(handleTap:)];
    [self.taskView addGestureRecognizer:tapGestore];
    
    UIPanGestureRecognizer *panGestore = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.taskView addGestureRecognizer:panGestore];
    
    [tapGestore release];
    [self.taskView release];
}

- (void) handlePan:(UIPanGestureRecognizer*)panGestore {
    
    if (panGestore.state == UIGestureRecognizerStateBegan ||
        panGestore.state == UIGestureRecognizerStateChanged ||
        panGestore.state == UIGestureRecognizerStateEnded) {
        
        self.deleteView = [[DeleteView redrawDeleteViewWithGestoreSuperView:panGestore] init];
        NSMutableString *string = [NSMutableString stringWithString:@""];
        CGRect rect = self.deleteView.frame;
        [string appendFormat:@"%@", NSStringFromCGRect(rect)];
        NSLog(@"%@", string);
        NSLog(@"%ld", panGestore.view.tag);
        
        [self.arrayTaskView enumerateObjectsUsingBlock:^(TaskView* taskView, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == panGestore.view.tag) {
                [taskView addSubview:self.deleteView];
                [self.deleteView release];
            }
        }];
    }
}

- (void) handleTap:(UITapGestureRecognizer*) tapGestore {
    
    NSLog(@"tag gesture - %ld",tapGestore.view.tag);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose action" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        AddTaskViewController *vc = [[AddTaskViewController alloc] init];
        [self presentViewController:vc animated:true completion:nil];
    }];
    
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@" gesture tag - %ld",(long)tapGestore.view.tag);
        [self.tasksArray removeObjectAtIndex:tapGestore.view.tag];
        self.indexForAnimation = tapGestore.view.tag;
        
        [self setScrollView];
       
    }];
    [alertController addAction:cancel];
    [alertController addAction:edit];
    [alertController addAction:delete];
    
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)deleteViewTask:(UITapGestureRecognizer*)tapGestore {
    
    [self.arrayTaskView removeObjectAtIndex:tapGestore.view.tag];
    [self.tasksArray removeObjectAtIndex:tapGestore.view.tag];
    [tapGestore.view removeFromSuperview];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setScrollView];
}

- (void)setScrollView {
    
    if (self.tasksArray.count != 0) {
        [self clearScrollView];
        for (int i = 0; i <= (self.tasksArray.count - 1); i++) {
            [self createObjectTaskView:i];
          
            Task *taskContent = self.tasksArray[i];
            [self.taskView setValueInSubviewsTitle:taskContent.title
                                       description:taskContent.descript
                                            detail:taskContent.details];
            
            self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,
                                                     self.taskView.bounds.size.height * (i + 1));
            [self.scrollView addSubview:self.taskView];
            
        }
    } else {
        [self deleteViewWihtAnimation:self.indexForAnimation];
    }
}

- (void) clearScrollView {
    for (UIView* taskView in _arrayTaskView) {
        [taskView removeFromSuperview];
    }
}

- (void)deleteViewWihtAnimation:(NSInteger)index {
    if (self.arrayTaskView.count != 0) {
        [UIView animateWithDuration:1 animations:^{
            TaskView * taskView = self.arrayTaskView[index];
            taskView.frame = CGRectMake(CGRectGetMaxX(self.scrollView.bounds),
                                        self.taskView.bounds.origin.y * index + 1,
                                        self.taskView.bounds.size.width,
                                        self.taskView.bounds.size.height);
        }];
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
    [_arrayTaskView release];
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
