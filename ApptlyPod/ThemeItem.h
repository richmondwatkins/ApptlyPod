//
//  ThemeItem.h
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface ThemeItem : NSManagedObject

@property (nonatomic, retain) NSString * backgroundColor;
@property (nonatomic, retain) NSString * fontColor;
@property (nonatomic, retain) NSString * fontFamily;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSManagedObject *themeContainer;

@end
