//
//  LXSearchHeadView.m
//  lxtx
//
//  Created by rrkj on 2018/5/23.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "LXSearchHeadView.h"

@implementation LXSearchHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLbl = [[UILabel alloc]init];
        titleLbl.text = @"历史搜索";
        self.titleLbl = titleLbl;
        titleLbl.textColor = rgbColor(0x333333);
        titleLbl.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLbl];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.centerY.equalTo(self);
        }];
        
        
        UIButton *delBtn = [[UIButton alloc]init];
        self.delBtn = delBtn;
        [delBtn setTitle:@"删除" forState:UIControlStateNormal];
        delBtn.titleLabel.font = sysFont(14);
        [delBtn setTitleColor:rgbColor(0x333333) forState:UIControlStateNormal];
        [self addSubview:delBtn];
        [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(0);
            make.centerY.equalTo(self);
        }];
        
        
    }
    return self;
}






@end
