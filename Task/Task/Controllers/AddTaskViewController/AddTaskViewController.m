//
//  AddTaskViewController.m
//  Task
//
//  Created by Алексей on 5/16/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"
#import "HomeFlag.h"
#import "WorkFlag.h"
#import "FamilyFlag.h"
#import "ShopFlag.h"
#import "DefaultFlag.h"

@interface AddTaskViewController ()

@property (nonatomic, retain) UIScrollView* scrollView;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextView *descriptionTextView;
@property (nonatomic, strong) UITextView *detailsTextView;
@property (nonatomic, strong) UIView *selectedFlagView;

@property (nonatomic, strong) NSArray<UIView *> *flags;

@end

@implementation AddTaskViewController

////////////////////////////////////////Bahaviour of keyboard////////////////////////////////////////////////////////
- (void)loadView {////self.view as scrollView
    CGRect fullScreenRect = [[UIScreen mainScreen] bounds];
    _scrollView = [[UIScrollView alloc] initWithFrame:fullScreenRect];
    _scrollView.contentSize = CGSizeMake(fullScreenRect.size.width, fullScreenRect.size.height);
    self.view = _scrollView;
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    //    if (_detailsTextView.isFirstResponder) {
    [self.scrollView scrollRectToVisible:_detailsTextView.frame animated:YES];
    //   }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void) hideKeyboard {
    [_titleTextField resignFirstResponder];
    [_descriptionTextView resignFirstResponder];
    [_detailsTextView resignFirstResponder];
}

//////////////////////////////////////END//////////////////////////////////////////////////////////



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //////////////////////////////////////gestureRecognizer//////////////////////////////////////////////////////////
    UITapGestureRecognizer *gestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)] autorelease];
    [self.view addGestureRecognizer:gestureRecognizer];
    [self registerForKeyboardNotifications];
    //////////////////////////////////////////END//////////////////////////////////////////////////////
    self.view.backgroundColor = UIColor.whiteColor;
    CGFloat width = self.view.bounds.size.width * 0.8;
    CGFloat height = self.view.bounds.size.height;
    
    self.selectedFlagView = [[DefaultFlag alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/8, height/7.4, width/4, width/4)];
    [self.view addSubview:_selectedFlagView];
    
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, height/3.3, width, height/22.2)];
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:_titleTextField];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleTextField.frame.origin.x, height/3.7, width, height/33.3)];
    titleLabel.text = @"Title:";
    
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    _descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, height/2.4, width, height/6.7)];
    [_descriptionTextView.layer setCornerRadius:5];
    [_descriptionTextView.layer setBorderWidth:0.3];
    _descriptionTextView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    [_descriptionTextView setFont:[UIFont fontWithName:@"Arial" size:17]];
    
    [self.view addSubview:_descriptionTextView];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(_descriptionTextView.frame.origin.x, height/2.6, width, height/33.3)];
    descriptionLabel.text = @"Description:";
    
    [self.view addSubview:descriptionLabel];
    [descriptionLabel release];
    
    _detailsTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, height/1.55, width, height/6.7)];
    [_detailsTextView.layer setCornerRadius:5];
    [_detailsTextView.layer setBorderWidth:0.4];
    _detailsTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    [_detailsTextView setFont:[UIFont fontWithName:@"Arial" size:17]];
    
    [self.view addSubview:_detailsTextView];
    
    UILabel *detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(_detailsTextView.frame.origin.x, height/1.65, width, height/33.3)];
    detailsLabel.text = @"Details:";
    
    [self.view addSubview:detailsLabel];
    [detailsLabel release];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonTapped:)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    [rightButton release];
    
    [self flagsInit];
    
    if (_task) {
        self.title = @"Edit task";
        _titleTextField.text = _task.title;
        _descriptionTextView.text = _task.descript;
        _detailsTextView.text = _task.details;
        
        [_selectedFlagView removeFromSuperview];
        self.selectedFlagView = [[_task.flag.class alloc] initWithFrame:_selectedFlagView.frame];
        [self.view addSubview:_selectedFlagView];
    } else {
        self.title = @"Add task";
    }
    
}

-(void)flagsInit {
    CGFloat offsetX = self.view.bounds.size.width/15;
    CGFloat size = (self.view.bounds.size.width - 5 * offsetX) / 4;
    CGFloat offsetY = self.view.bounds.size.height/1.2;
    
    HomeFlag *homeFlag = [[HomeFlag alloc] initWithFrame:CGRectMake(offsetX, offsetY, size, size)];
    WorkFlag *workFlag = [[WorkFlag alloc] initWithFrame:CGRectMake(size + 2 * offsetX, offsetY, size, size)];
    FamilyFlag *familyFlag = [[FamilyFlag alloc] initWithFrame:CGRectMake(2 * size + 3 * offsetX, offsetY, size, size)];
    ShopFlag *shopFlag = [[ShopFlag alloc] initWithFrame:CGRectMake(3 * size + 4 * offsetX, offsetY, size, size)];
    
    _flags = [[NSArray alloc] initWithObjects:homeFlag, workFlag, familyFlag, shopFlag, nil];
    
    [homeFlag release];
    [workFlag release];
    [familyFlag release];
    [shopFlag release];
    
    for (UIView *flag in _flags) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flagTapped:)];
        [flag addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        flag.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        
        [self.view addSubview:flag];
    }
}

-(void)flagTapped:(UITapGestureRecognizer*) tapGesture {
    for (UIView *flag in _flags) {
        [flag.layer setBorderWidth:0];
    }
    [tapGesture.view.layer setBorderWidth:3];
    
    [_selectedFlagView removeFromSuperview];
    self.selectedFlagView = [[tapGesture.view.class alloc] initWithFrame:_selectedFlagView.frame];
    [self.view addSubview:_selectedFlagView];
}

-(void)saveButtonTapped:(id)sender {
    
    if (_task) {
        _task.title = _titleTextField.text;
        _task.descript = _descriptionTextView.text;
        _task.details = _detailsTextView.text;
        _task.flag = [[_selectedFlagView.class alloc] init];
        
        [self.delegate updateTask: _task];
    } else {
        _task = [[Task alloc] init];
        _task.title = _titleTextField.text;
        _task.descript = _descriptionTextView.text;
        _task.details = _detailsTextView.text;
        _task.flag = [[_selectedFlagView.class alloc] init];
        
        [self.delegate saveNewTask: _task];
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
    [_selectedFlagView release];
    
    [_task release];
    [_flags release];
    [_scrollView release];
    
    [super dealloc];
}

@end
