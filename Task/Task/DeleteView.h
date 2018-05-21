//
//  DeleteView.h
//  Task
//
//  Created by Slava on 5/19/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteView : UIView

@property (nonatomic, retain) UILabel* deleteLabel;

+ (DeleteView*)redrawDeleteViewWithGestoreSuperView:(UIPanGestureRecognizer*)panGestore;

@end
