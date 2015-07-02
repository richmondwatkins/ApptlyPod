//
//  SideMenuViewController.h
//  DailyDoll
//
//  Created by Richmond on 2/4/15.
//  Copyright (c) 2015 Richmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APViewController.h"
#import "MenuItem.h"

@protocol SideMenuProtocol <NSObject>

- (void)selectedSideMenuItem:(NSString *)urlString;

@end

@interface APSideMenuViewController : APViewController

@property id<SideMenuProtocol> delegate;

- (int)returnWidthForMenuViewController;

@end
