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

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *descript;
@property (nonatomic, retain) NSString *details;
@property (nonatomic, retain) UIView* image;

@end
