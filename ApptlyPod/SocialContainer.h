//
//  SocialContainer.h
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject, ProjectVariable;

@interface SocialContainer : NSManagedObject

@property (nonatomic, retain) NSSet *socialItems;
@property (nonatomic, retain) ProjectVariable *projectVariable;
@end

@interface SocialContainer (CoreDataGeneratedAccessors)

- (void)addSocialItemsObject:(NSManagedObject *)value;
- (void)removeSocialItemsObject:(NSManagedObject *)value;
- (void)addSocialItems:(NSSet *)values;
- (void)removeSocialItems:(NSSet *)values;

@end
