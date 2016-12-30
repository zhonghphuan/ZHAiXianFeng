//
//  AXFOCSetVC.m
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

#import "AXFOCSetVC.h"
#import "AXFOCaboutVC.h"
#import <SDWebImage/SDImageCache.h>
static NSString *cellID = @"cellSetID";
@interface AXFOCSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSString *sizeCache;
@property (nonatomic,strong) UILabel *label;
@end

@implementation AXFOCSetVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setupUI];
}

- (void)setupUI{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(- 36, 0, 0, 0);
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 1;
        default:
            break;
    }
    return section;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.textLabel.text = @"关于小熊";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UIAccessibilityTraitNone;
        return cell;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.textLabel.text = @"清理缓存";
   
        float sizefolder = [self folderSizeAtPath:nil] ;
        self.sizeCache = [NSString stringWithFormat:@"%.4f",sizefolder];
        [self folderSizeAtPath:nil];
        UILabel *label = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
        self.label = label;
        if (self.sizeCache > 0) {
            [label removeFromSuperview];
        }
        
        label.text = [NSString stringWithFormat:@"缓存大小为%@MB",self.sizeCache];
        label.font = [UIFont boldSystemFontOfSize:14];
        [label sizeToFit];
        label.backgroundColor = [UIColor clearColor];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            label.frame =CGRectMake(self.view.bounds.size.width - label.frame.size.width - 10,\
                                    12, label.frame.size.width, label.frame.size.height);
        } else {
            label.frame =CGRectMake(self.view.bounds.size.width - label.frame.size.width - 20,\
                                    12, label.frame.size.width, label.frame.size.height);
        }
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        [cell.contentView addSubview:label];
        cell.selectionStyle = UIAccessibilityTraitNone;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = @"退出当前账户";
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIViewController *vc = [[AXFOCaboutVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        if (self.sizeCache > 0) {
            [ self.label removeFromSuperview];
        }
        
        //  创建弹框
        NSString *message= [NSString stringWithFormat:@"缓存大小为%@MB,确定要清楚缓存吗?",self.sizeCache];
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //  添加确定按钮
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self clearCache:nil];
            
            float sizefolder = [self folderSizeAtPath:nil] ;
            
            self.sizeCache = [NSString stringWithFormat:@"%.4f",sizefolder];

            NSLog(@"清除后%@",self.sizeCache);
            [tableView reloadData];
            
        }];
        
        
        [aler addAction:defaultAction];
        
        //  添加取消按钮
        [aler addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        //  进行弹框
        [self presentViewController:aler animated:YES completion:nil];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSLog(@"退出当前用户");
    }
}

//获取缓存文件的大小
//由于缓存文件存在沙箱中，我们可以通过NSFileManager API来实现对缓存文件大小的计算。
//计算单个文件大小
-(long long)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

//计算目录大小
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath=[cachePath stringByAppendingPathComponent:path];
    long long folderSize=0;
    if ([fileManager fileExistsAtPath:cachePath])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles)
        {
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            long long size=[self fileSizeAtPath:fileAbsolutePath];
            folderSize += size;
            
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize];
        return folderSize/1024.0/1024.0;
    }
    return 0;
}

//清理缓存文件
//同样也是利用NSFileManager API进行文件操作，SDWebImage框架自己实现了清理缓存操作，我们可以直接调用。
-(void)clearCache:(NSString *)path{
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath=[cachePath stringByAppendingPathComponent:path];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:fileAbsolutePath error:nil];
        }
    }
    
    [[SDImageCache sharedImageCache] cleanDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
