//
//  MenuItem.h
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MenuItem, NSManagedObject;

@interface MenuItem : NSManagedObject

@property (nonatomic, retain) NSNumber * collapsable;
@property (nonatomic, retain) NSNumber * isDropdown;
@property (nonatomic, retain) NSNumber * isExpanded;
@property (nonatomic, retain) NSNumber * isHeader;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet *children;
@property (nonatomic, retain) NSManagedObject *menuContainer;
@end

@interface MenuItem (CoreDataGeneratedAccessors)

- (void)addChildrenObject:(MenuItem *)value;
- (void)removeChildrenObject:(MenuItem *)value;
- (void)addChildren:(NSSet *)values;
- (void)removeChildren:(NSSet *)values;

@end
