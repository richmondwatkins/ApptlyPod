//
//  MetaData.h
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface MetaData : NSManagedObject

@property (nonatomic, retain) NSNumber * appId;
@property (nonatomic, retain) NSString * domain;
@property (nonatomic, retain) NSString * siteEmail;
@property (nonatomic, retain) NSString * siteName;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSManagedObject *projectVariable;

@end
