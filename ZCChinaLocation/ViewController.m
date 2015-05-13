//
//  ViewController.m
//  ZCChinaLocation
//
//  Created by cuibo on 5/12/15.
//  Copyright (c) 2015 cuibo. All rights reserved.
//

#import "ViewController.h"
#import "ZCChinaLocation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender
{
    //判断纬度：44.042156， 经度132.759178是否在中国境内
    BOOL ischina = [[ZCChinaLocation shared] isInsideChina:(CLLocationCoordinate2D){44.042156,132.759178}];
    NSLog(@"%d", ischina);
}

@end

