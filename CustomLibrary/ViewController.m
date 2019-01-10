//
//  ViewController.m
//  CustomLibrary
//
//  Created by Even on 2019/1/6.
//  Copyright © 2019年 EvenZhu. All rights reserved.
//

#import "ViewController.h"
#import "MethodClass.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = UIColor.whiteColor;
    
#if TARGET_OS_IPHONE
    NSLog(@"TARGET_OS_IPHONE");
#elif TARGET_OS_MAC
    NSLog(@"TARGET_OS_MAC");
#endif
    
    FUIButton *myButton = [[FUIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 44)];
    myButton.buttonColor = [UIColor blendedColorWithForegroundColor:[UIColor redColor] backgroundColor:[UIColor yellowColor] percentBlend:0.5];
    myButton.shadowColor = [UIColor greenSeaColor];
    myButton.shadowHeight = 10.0f;
    myButton.cornerRadius = 10.0f;
    myButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [myButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    [self.view addSubview:myButton];
    
    MethodClass *method = [[MethodClass alloc] init];
    [method log:@"123", @"456", @"789"];
    SEL sel = sel_registerName("privateLog");
    IMP imp = class_getMethodImplementation([MethodClass class], sel);
//    void (*func)(id, SEL) = (void *)imp;
//    func(method, sel);
    
    void (*func)(id, SEL) = (void *)imp;
    func(method, sel);
    
    NSLog(@"method.virable : %@", method.virable);
    
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList([NSObject class], &outCount);
    NSLog(@"Method方法列表 <<<<<<");
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"\t  -%@  ==  %s", NSStringFromSelector(method_getName(method)), method_getDescription(method)->types);
    }
    NSLog(@"Method方法列表 >>>>>>");
    
    NSLog(@"method.privateVirable : %@", object_getIvar(method, class_getInstanceVariable([method class], "_privateVirable")));
}

@end
