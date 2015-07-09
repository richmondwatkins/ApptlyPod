//
//  ViewController.h
//  DailyDoll
//
//  Created by Richmond on 2/1/15.
//  Copyright (c) 2015 Richmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APViewController.h"

@interface CenterViewController : APViewController

@property BOOL isFromSideMenu;
@property CGFloat scrollViewOffset;

- (void)setRightNavigationItem;

@end

