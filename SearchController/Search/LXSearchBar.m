//
//  LXSearchBar.m
//  lxtx
//
//  Created by rrkj on 2018/5/23.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "LXSearchBar.h"

@implementation LXSearchBar


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.backgroundColor = RGB(237, 238, 239);;
        self.placeholder = @"搜索商品或店铺";
        self.font = sysFont(14);
        self.tintColor = [UIColor blackColor];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.layer.cornerRadius = 15.0f;
        self.layer.masksToBounds = YES;
        
        
        
    }
    return self;
}


- (void)setPlace_holder:(NSString *)place_holder{
    
    _place_holder = place_holder;
    
    self.placeholder = place_holder;
    
}



+ (instancetype)searchBar{
    
    return [[self alloc]init];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
