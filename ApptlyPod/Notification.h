//
//  Notification.h
//  ApptlyPod
//
//  Created by Richmond Watkins on 6/30/15.
//  Copyright (c) 2015 Richmond Watkins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notification : NSManagedObject

@property (nonatomic, retain) NSNumber * isViewed;
@property (nonatomic, retain) NSDate * receivedDate;
@property (nonatomic, retain) NSString * text;

@end
