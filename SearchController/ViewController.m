//
//  ViewController.m
//  SearchController
//
//  Created by rrkj on 2018/5/28.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "ViewController.h"
#import "LXSearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Click:(id)sender {
    
    LXSearchViewController *searchVC = [[LXSearchViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:searchVC];
    [self presentViewController:nav animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
