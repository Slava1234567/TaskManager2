//
//  Task.h
//  Task
//
//  Created by Алексей on 17.05.2018.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Task : NSObject

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descript;
@property (nonatomic, strong) NSString *details;

@property (nonatomic, strong) UIView *flag;

@end
