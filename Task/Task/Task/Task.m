//
//  Task.m
//  Task
//
//  Created by Алексей on 17.05.2018.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "Task.h"

@implementation Task

-(void)dealloc {
    [_title release];
    [_descript release];
    [_details release];
    [_flag release];
    
    [super dealloc];
}

@end
