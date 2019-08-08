//
//  Course.h
//  ObjCTableView
//
//  Created by Justin Bengtson on 8/8/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Course : NSObject

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber * numberOfLessons;

@end

NS_ASSUME_NONNULL_END
