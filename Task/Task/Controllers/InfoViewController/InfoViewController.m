//
//  InfoViewController.m
//  Task
//
//  Created by Алексей on 5/16/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "InfoViewController.h"
#import "IconView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Info";
    self.view.backgroundColor = UIColor.whiteColor;
    
    CGFloat width = 250;
    CGFloat height = 250;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, 70, width, 50)];
    titleLabel.text = @"Task Manager";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:titleLabel];
    
    //////////////////////////////////////Start////////////////////////////////////////////////////
    UILabel *ourTeam = [[[UILabel alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height/2, self.view.bounds.size.width - 20, 120 )] autorelease];
    ourTeam.numberOfLines = 4;
    ourTeam.text = @"Our team:\nAleksei Piatyha\nViachaslau Shyla\nPavel Koka";
    ourTeam.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:25];
    ourTeam.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:ourTeam];
    
    UILabel *epam = [[[UILabel alloc]  initWithFrame: CGRectMake(0, self.view.bounds.size.height - 20, self.view.bounds.size.width, 20)] autorelease];
    epam.text = @"© Epam iOS Training Courses 2018";
    epam.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:ourTeam];
    [self.view addSubview:epam];
//////////////////////////////////////End////////////////////////////////////////////////////
    
    IconView *iconView = [[IconView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, self.view.bounds.origin.y + height/2, width, height)];
    
    [self.view addSubview:iconView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
