//
//  MethodClass.m
//  CustomLibrary
//
//  Created by Even on 2019/1/6.
//  Copyright © 2019年 EvenZhu. All rights reserved.
//

#import "MethodClass.h"

@interface MethodClass ()

@property (nonatomic, copy) NSString *privateVirable;

@end

@implementation MethodClass

- (void)log:(NSString *)strings, ... {
    NSMutableString *logString;
    va_list args;
    va_start(args, strings);
    for (NSString *arg = strings; arg != nil; arg = va_arg(args, NSString*)) {
        [logString appendString:arg];
    }
    va_end(args);
    
    NSLog(@"log ......%@", logString);
    
    self.virable = @"成员变量 ......";
    self.privateVirable = @"私有变量 ......";
}

- (void)privateLog {
    NSLog(@"privateLog ......");
}

@end
