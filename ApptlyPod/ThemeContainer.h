//
//  ThemeContainer.h
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ThemeItem;

@interface ThemeContainer : NSManagedObject

@property (nonatomic, retain) NSString * fontColor;
@property (nonatomic, retain) NSString * fontFamily;
@property (nonatomic, retain) NSString * primaryColor;
@property (nonatomic, retain) NSString * secondaryColor;
@property (nonatomic, retain) NSSet *themeItem;
@end

@interface ThemeContainer (CoreDataGeneratedAccessors)

- (void)addThemeItemObject:(ThemeItem *)value;
- (void)removeThemeItemObject:(ThemeItem *)value;
- (void)addThemeItem:(NSSet *)values;
- (void)removeThemeItem:(NSSet *)values;

@end
