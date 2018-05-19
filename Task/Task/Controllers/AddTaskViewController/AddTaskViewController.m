//
//  AddTaskViewController.m
//  Task
//
//  Created by Slava on 5/16/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add task";
    
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 250, 20)];
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    _titleTextField.placeholder = @"Title";
    
    [self.view addSubview:_titleTextField];
    
    _descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 170, 250, 150)];
    _descriptionTextView.text = @"Description";
    [self.view addSubview:_descriptionTextView];
    
    _detailsTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 370, 250, 150)];
    _detailsTextView.text = @"Details";
    [self.view addSubview:_detailsTextView];
    
    
    self.myImage = [[[UIView alloc]  initWithFrame:CGRectMake(20, 525, self.view.bounds.size.width - 40, 210)] autorelease];
    
    UIView *pictuerForTaskOne = [[[UIView alloc]  initWithFrame:CGRectMake(20, 20, 75, 75)] autorelease];
    UILabel* labelOne = [[[UILabel alloc] init] autorelease];
    labelOne.text = @"📞";
   // labelOne.font = [UIFont fontWithName:@"AppleColorEmoji" size:25.0];
    
   // pictuerForTaskOne.backgroundColor = [UIColor blackColor];
    [pictuerForTaskOne addSubview:labelOne];

    UIView *pictuerForTaskTwo = [[[UIView alloc]  initWithFrame:CGRectMake(105, 20, 75, 75)] autorelease];
    pictuerForTaskTwo.backgroundColor = [UIColor yellowColor];
    
    UIView *pictuerForTaskThree = [[[UIView alloc]  initWithFrame:CGRectMake(190, 20, 75, 75)] autorelease];
    pictuerForTaskThree.backgroundColor = [UIColor blackColor];
    
    UIView *pictuerForTaskFour = [[[UIView alloc]  initWithFrame:CGRectMake(275, 20, 75, 75)] autorelease];
    pictuerForTaskFour.backgroundColor = [UIColor blackColor];
    
    UIView *pictuerForTaskFive = [[[UIView alloc]  initWithFrame:CGRectMake(20, 105, 75, 75)] autorelease];
    pictuerForTaskFive.backgroundColor = [UIColor greenColor];
    
    UIView *pictuerForTaskSix = [[[UIView alloc]  initWithFrame:CGRectMake(105, 105, 75, 75)] autorelease];
    pictuerForTaskSix.backgroundColor = [UIColor greenColor];
    
    UIView *pictuerForTaskSeven = [[[UIView alloc]  initWithFrame:CGRectMake(190, 105, 75, 75)] autorelease];
    pictuerForTaskSeven.backgroundColor = [UIColor greenColor];
    
    UIView *pictuerForTaskEight = [[[UIView alloc]  initWithFrame:CGRectMake(275, 105, 75, 75)] autorelease];
    pictuerForTaskEight.backgroundColor = [UIColor greenColor];
    
    [self.myImage addSubview:pictuerForTaskOne];
    [self.myImage addSubview:pictuerForTaskTwo];
    [self.myImage addSubview:pictuerForTaskFour];
    [self.myImage addSubview:pictuerForTaskThree];
    [self.myImage addSubview:pictuerForTaskFive];
    [self.myImage addSubview:pictuerForTaskSix];
    [self.myImage addSubview:pictuerForTaskSeven];
    [self.myImage addSubview:pictuerForTaskEight];
    
    [self.view addSubview:self.myImage];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonTapped:)];
    
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    [rightButton release];

}

-(void)saveButtonTapped:(id)sender {
    Task *task = [[Task alloc] init];
    task.title = _titleTextField.text;
    task.descript = _descriptionTextView.text;
    task.details = _detailsTextView.text;
    
    [self.delegate saveNewTask: task];
    
    [task release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_titleTextField release];
    [_descriptionTextView release];
    [_detailsTextView release];
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
