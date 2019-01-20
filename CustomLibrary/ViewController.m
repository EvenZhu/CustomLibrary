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
    
    /**
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
    [method log:@"123", @"456", @"789", nil];
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
    */
     
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //网页请求：https://www.cnblogs.com/WJJ-Dream/p/5816750.html
    //普通json请求：https://www.cnblogs.com/mvc/blog/CategoriesTags.aspx?blogApp=WJJ-Dream&blogId=254942&postId=5816750&_=1547903225776
    NSMutableString *string = @"abcdefghigklmnopqrstuvwxyz".mutableCopy;
    for (int i = 0; i < 1000000; i++) {
        [string appendString:@"abcdefghigklmnopqrstuvwxyz"];
    }
    [manager POST:@"https://www.cnblogs.com/mvc/blog/CategoriesTags.aspx" parameters:@{@"blogApp":@"WJJ-Dream", @"blogId":@"254942", @"postId":@"5816750", @"_":@"1547903225776", @"abc":string} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"responseObject = %@", result);
        
//        [self loadHtmlString:result];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
    }];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSLog(@"当前的网络状态是：%ld", (long)status);
    }];
}

- (void)loadHtmlString:(NSString *)htmlString {
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webview loadHTMLString:htmlString baseURL:nil];
    
    [self.view addSubview:webview];
}

@end
