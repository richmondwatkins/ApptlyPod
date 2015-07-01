//
//  SocialItem.h
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Button, SocialContainer;

@interface SocialItem : NSManagedObject

@property (nonatomic, retain) NSString * accountId;
@property (nonatomic, retain) NSString * accountName;
@property (nonatomic, retain) NSString * accountUrl;
@property (nonatomic, retain) NSNumber * hasInteracted;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSNumber * platformId;
@property (nonatomic, retain) NSSet *buttons;
@property (nonatomic, retain) SocialContainer *socialContainer;
@end

@interface SocialItem (CoreDataGeneratedAccessors)

- (void)addButtonsObject:(Button *)value;
- (void)removeButtonsObject:(Button *)value;
- (void)addButtons:(NSSet *)values;
- (void)removeButtons:(NSSet *)values;

@end
