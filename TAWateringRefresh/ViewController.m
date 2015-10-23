//
//  ViewController.m
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/23.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import "ViewController.h"
#import "TAWateringRefreshView.h"

@interface ViewController ()
{
    TAWateringRefreshView *_refreshView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _refreshView = [[TAWateringRefreshView alloc] init];
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

@end
