//
//  LXSearchTextCell.m
//  lxtx
//
//  Created by rrkj on 2018/5/23.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "LXSearchTextCell.h"

@implementation LXSearchTextCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        
        
        UILabel *titleLbl = [[UILabel alloc]init];
        self.contentLbl = titleLbl;
        titleLbl.textAlignment = NSTextAlignmentCenter;
        titleLbl.textColor = rgbColor(0x666666);
        titleLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:titleLbl];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.equalTo(self.contentView);
        }];
                             
                            
    }
    
    return self;
}


@end
