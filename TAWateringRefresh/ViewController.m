//
//  ViewController.m
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/23.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import "ViewController.h"
#import "TAWateringRefreshView.h"

@interface ViewController () <TAWateringRefreshDelegate>
{
    TAWateringRefreshView *_refreshView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _refreshView = [[TAWateringRefreshView alloc] init];
    _refreshView.delegate = self;
    [self.tableView addSubview:_refreshView];
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshView scrollViewDidEndDraging:scrollView];
}

-(void)wateringRefreshStartRefresh:(TAWateringRefreshView *)refreshView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_refreshView endRefresh:self.tableView];
    });
}

@end
