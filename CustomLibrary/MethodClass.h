//
//  MethodClass.h
//  CustomLibrary
//
//  Created by Even on 2019/1/6.
//  Copyright © 2019年 EvenZhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MethodClass : NSObject

@property (nonatomic, copy) NSString *virable;

- (void)log:(NSString *)strings, ... NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
