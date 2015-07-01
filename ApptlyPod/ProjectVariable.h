//
//  ProjectVariable.h
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MetaData, NSManagedObject;

@interface ProjectVariable : NSManagedObject

@property (nonatomic, retain) NSManagedObject *socialContainer;
@property (nonatomic, retain) MetaData *metaData;

@end
