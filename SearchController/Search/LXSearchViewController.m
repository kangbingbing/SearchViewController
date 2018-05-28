//
//  LXSearchViewController.m
//  lxtx
//
//  Created by rrkj on 2018/5/8.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "LXSearchViewController.h"
#import "LXSearchBar.h"
#import "LXSearchTextCell.h"
#import "LXSearchHeadView.h"
#import "LXSearchFlowLayout.h"


#define max_words 10

@interface LXSearchViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) LXSearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *hisArray;

@end

@implementation LXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
    LXSearchBar *searchBar = [LXSearchBar searchBar];
    self.searchBar = searchBar;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.frame = CGRectMake(0, 10, kSCREEN_WIDTH, 28);
    self.navigationItem.titleView = searchBar;
    [searchBar becomeFirstResponder];
    searchBar.delegate = self;
    searchBar.inputAccessoryView = [[UIView alloc] init];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];

    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponderClick)];
    [self.collectionView addGestureRecognizer:tap];
    
}

- (void)resignFirstResponderClick{
    
    [self.searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [document stringByAppendingPathComponent:@"history.plist"];
    NSMutableArray *hisArray = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:path]];
    self.hisArray = hisArray;
    self.dataArray = @[@{@"title":@"历史搜索",@"value":self.hisArray},@{@"title":@"热门搜索",@"value":@[@"服装",@"连衣裙",@"羽绒大衣",@"牛仔裤",@"高级西服套装",@"服装",@"连衣裙",@"羽绒大衣",@"牛仔裤",@"高级西服套装"]}];
    [self.collectionView reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [_searchBar resignFirstResponder];
    
}

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil){
        
        LXSearchFlowLayout *flowLayout = [[LXSearchFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = rgbColor(0xf7f7f7);
        _collectionView.contentInset = UIEdgeInsetsMake(0, 15, 15, 15);
        [_collectionView registerClass:[LXSearchTextCell class] forCellWithReuseIdentifier:@"LXSearchTextCell"];
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_collectionView registerClass:[LXSearchHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LXSearchHeadView"];

        
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary *dict = self.dataArray[section];
    return [dict[@"value"] count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LXSearchTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXSearchTextCell"                                         forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.section];
    cell.contentLbl.text = dict[@"value"][indexPath.item];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataArray[indexPath.section];
    NSString *seletedstr = dict[@"value"][indexPath.item];
    self.searchBar.text = seletedstr;
    [self insertHistoryWords:seletedstr];
    
    NSLog(@"跳转");
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataArray[indexPath.section];
    NSString *searchText = dict[@"value"][indexPath.item];
    CGFloat textW = [self boundingRectWithText:searchText andWithTextSize:15].width + 20;
    
    return CGSizeMake(MIN(kSCREEN_WIDTH - 30, textW), 24);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    return CGSizeMake(kSCREEN_WIDTH, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LXSearchHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LXSearchHeadView" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.section];
    headerView.titleLbl.text = dict[@"title"];
    headerView.delBtn.hidden = indexPath.section || !self.hisArray.count;
    [headerView.delBtn addTarget:self action:@selector(deleteHistoryWords) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *seatchText = textField.text;
    if ([[seatchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    
    NSLog(@"开始搜索  %@",seatchText);
    
    [self insertHistoryWords:seatchText];
    
    
    return YES;
}

- (void)insertHistoryWords:(NSString *)word{
    
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [document stringByAppendingPathComponent:@"history.plist"];
    
    [self.hisArray removeObject:word];
    [self.hisArray insertObject:word atIndex:0];
    [self.hisArray writeToFile:path atomically:YES];
    
    if (self.hisArray.count > max_words) {
        [self.hisArray removeObjectsInRange:NSMakeRange(max_words, self.hisArray.count - max_words)];
    }
    
}

- (void)deleteHistoryWords{
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [document stringByAppendingPathComponent:@"history.plist"];
    [self.hisArray removeAllObjects];
    [self.hisArray writeToFile:path atomically:YES];
    [self.collectionView reloadData];
}

- (CGSize)boundingRectWithText:(NSString *)text andWithTextSize:(CGFloat)size{
    
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:size]} context:nil].size;
}



- (void)cancleClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
