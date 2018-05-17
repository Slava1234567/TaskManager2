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
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat width = 250;
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, 100, 250, 20)];
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    _titleTextField.placeholder = @"Title";
    
    [self.view addSubview:_titleTextField];
    
    _descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, 170, 250, 150)];
    _descriptionTextView.text = @"Description";
    CALayer *descriptionTextViewLayer = _descriptionTextView.layer;
    [descriptionTextViewLayer setCornerRadius:10];
    [descriptionTextViewLayer setBorderWidth:1];
    descriptionTextViewLayer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    [self.view addSubview:_descriptionTextView];
    
    _detailsTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, 370, 250, 150)];
    _detailsTextView.text = @"Details";
    CALayer *detailsTextViewLayer = _detailsTextView.layer;
    [detailsTextViewLayer setCornerRadius:10];
    [detailsTextViewLayer setBorderWidth:1];
    detailsTextViewLayer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    [self.view addSubview:_detailsTextView];
    
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
