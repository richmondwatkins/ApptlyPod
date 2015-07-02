//
//  BASocialSignInViewController.h
//  DailyDoll
//
//  Created by Richmond on 3/8/15.
//  Copyright (c) 2015 Richmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APViewController.h"
#import "SocialSharingActionController.h"

@interface BASocialShareViewController : APViewController

@property SocialSharePopoverView *socialPopUp;

@property OAuthSignInView *signInView;

@property SocialSharingActionController *actionController;


- (void)displaySocialPoUp;

- (void)instantiateOAuthLoginView:(int)socialType;

-(void)webViewDidFinishLoad:(UIWebView *)webView;

@end
