//
//  ZHSearchBarVC.m
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/29.
//  Copyright © 2016年 ZH. All rights reserved.
//

#import "ZHSearchBarVC.h"
#import "UIImage+ImageCompress.h"
#import "SKTagView.h"
#import "ZHSearchResultVC.h"
#import <AFNetworking/AFNetworking.h>

@interface ZHSearchBarVC ()<UISearchBarDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) SKTagView *tagView;

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UITextField *searBarTextField;
@end

@implementation ZHSearchBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.dataSource);
    // Do any additional setup after loading the view from its nib.
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入要搜索的文字";
    self.searchBar.showsCancelButton = YES;
    // 键盘确认按钮的名字
    self.searchBar.returnKeyType = UIReturnKeyNext;
    // 把默认灰色背景浮层给去掉
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.backgroundImage = [UIImage new];
    UITextField *searBarTextField = [self.searchBar valueForKey:@"_searchField"];
    self.searBarTextField = searBarTextField;
    if (searBarTextField)
    {
        [searBarTextField setBackgroundColor:[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]];
        searBarTextField.borderStyle = UITextBorderStyleRoundedRect;
        searBarTextField.layer.cornerRadius = 5.0f;
    }
    else
    {
        // 通过颜色画一个Image出来
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1] forSize:CGSizeMake(28, 28)];
        [self.searchBar setSearchFieldBackgroundImage:image forState:UIControlStateNormal];
    }
    [titleView addSubview:self.searchBar];
    self.navigationItem.titleView = titleView;
    [self.searchBar becomeFirstResponder];
    [self configTagView];
}


// 配置
- (void)configTagView
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.text = @"热门搜索";
    [self.view addSubview:self.label];
    
    [self.tagView removeAllTags];
    self.tagView = [[SKTagView alloc] init];
    // 整个tagView对应其SuperView的上左下右距离
    self.tagView.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    // 上下行之间的距离
    self.tagView.lineSpacing = 10;
    // item之间的距离
    self.tagView.interitemSpacing = 20;
    // 最大宽度
    self.tagView.preferredMaxLayoutWidth = 375;
  
    // 开始加载
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 初始化标签
        SKTag *tag = [[SKTag alloc] initWithText:self.dataSource[idx]];
        // 标签相对于自己容器的上左下右的距离
        tag.padding = UIEdgeInsetsMake(3, 15, 3, 15);
        // 弧度
        tag.cornerRadius = 15.0f;
        // 字体
        tag.font = [UIFont boldSystemFontOfSize:13];
        // 边框宽度
        tag.borderWidth = 0;
        // 背景
        tag.bgColor = [UIColor whiteColor];
        // 边框颜色
        tag.borderColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
        // 字体颜色
        tag.textColor = [UIColor blackColor];
        // 是否可点击
        tag.enable = YES;
        // 加入到tagView
        [self.tagView addTag:tag];
    }];
    // 点击事件回调
    __weak typeof(self) weakSelf = self;
    self.tagView.didTapTagAtIndex = ^(NSUInteger idx){
        weakSelf.searBarTextField.text = weakSelf.dataSource[idx];
        NSLog(@"点击了%@",weakSelf.dataSource[idx]);
        ZHSearchResultVC *vc = [ZHSearchResultVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    
    // 获取刚才加入所有tag之后的内在高度
    CGFloat tagHeight = self.tagView.intrinsicContentSize.height;
    NSLog(@"高度%lf",tagHeight);
    self.tagView.frame = CGRectMake(0, 30, 375, tagHeight);
    [self.tagView layoutSubviews];
    [self.view addSubview:self.tagView];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    if (searchText.length == 0) {
        // 没有文字了
        self.label.hidden = NO;
        self.tagView.hidden = NO;
    }
    else
    {
        self.label.hidden = YES;
        self.tagView.hidden = YES;
    }
}

// 网上找来的searbar修改右边文字的方法

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
            cancel.tintColor = [UIColor redColor];
        }
    }
}


//-(NSMutableArray *)dataSource
//{
//    if (_dataSource == nil) {
//        
//        _dataSource = [[NSMutableArray alloc] initWithArray:@[@"年货大集",@"酸奶",@"水",@"车厘子",@"洽洽瓜子",@"维他",@"香烟",@"周黑鸭",@"草莓",@"星巴克",@"卤味"]];
//        
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
//        NSDictionary *dict = @{@"call":@8};
//
//        [manager POST:@"http://iosapi.itcast.cn/loveBeen/promotion.json.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
//        }];
//    }
//    return _dataSource;
//}



@end
