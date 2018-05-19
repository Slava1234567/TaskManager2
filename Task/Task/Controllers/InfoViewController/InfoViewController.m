//
//  InfoViewController.m
//  Task
//
//  Created by Slava on 5/16/18.
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
    
    IconView *iconView = [[IconView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - width/2, self.view.bounds.origin.x + height/3, width, height)];
    
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
