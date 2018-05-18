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
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat width = self.view.bounds.size.width * 0.8;
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, 100, width, 30)];
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:_titleTextField];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleTextField.frame.origin.x, 80, width, 20)];
    titleLabel.text = @"Title:";
    
    [self.view addSubview:titleLabel];

    _descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, 170, width, 100)];
    CALayer *descriptionTextViewLayer = _descriptionTextView.layer;
    [descriptionTextViewLayer setCornerRadius:10];
    [descriptionTextViewLayer setBorderWidth:1];
    descriptionTextViewLayer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    [self.view addSubview:_descriptionTextView];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(_descriptionTextView.frame.origin.x, 150, width, 20)];
    descriptionLabel.text = @"Description:";
    
    [self.view addSubview:descriptionLabel];
    
    _detailsTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, 320, width, 100)];
    CALayer *detailsTextViewLayer = _detailsTextView.layer;
    [detailsTextViewLayer setCornerRadius:10];
    [detailsTextViewLayer setBorderWidth:1];
    detailsTextViewLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    [self.view addSubview:_detailsTextView];
    
    UILabel *detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(_detailsTextView.frame.origin.x, 300, width, 20)];
    detailsLabel.text = @"Details:";
    
    [self.view addSubview:detailsLabel];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonTapped:)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    [rightButton release];
    
    if (_task) {
        self.title = @"Edit task";
        _titleTextField.text = _task.title;
        _descriptionTextView.text = _task.descript;
        _detailsTextView.text = _task.details;
    } else {
        self.title = @"Add task";
    }

}

-(void)saveButtonTapped:(id)sender {
    
    if (_task) {
        _task.title = _titleTextField.text;
        _task.descript = _descriptionTextView.text;
        _task.details = _detailsTextView.text;
        
        [self.delegate updateTask];
    } else {
        Task *task = [[Task alloc] init];
        task.title = _titleTextField.text;
        task.descript = _descriptionTextView.text;
        task.details = _detailsTextView.text;
        
        [self.delegate saveNewTask: task];
        
        [task release];
    }
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_titleTextField release];
    [_descriptionTextView release];
    [_detailsTextView release];
    
    [_task release];
    
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
