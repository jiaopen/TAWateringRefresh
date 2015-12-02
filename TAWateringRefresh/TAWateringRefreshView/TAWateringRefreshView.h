//
//  TAWateringRefreshView.h
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/23.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    TAWateringRefreshStatePulling = 1,
    TAWateringRefreshStateNormal = 0,
    TAWateringRefreshStateLoading = 2,
} TAWateringRefreshState;

@protocol TAWateringRefreshDelegate;

@interface TAWateringRefreshView : UIView

- (void)scrollViewDidScroll:(UIScrollView*) scrollView;
- (void)scrollViewDidEndDraging:(UIScrollView*) scrollView;
- (void)endRefresh:(UIScrollView*) scrollView;
+ (instancetype)refreshView;

@property (nonatomic, assign)   id<TAWateringRefreshDelegate>   delegate;
@property (nonatomic, strong) UIImage* maskImage;

@end

@protocol TAWateringRefreshDelegate <NSObject>

@optional

- (void)wateringRefreshStartRefresh:(TAWateringRefreshView*)refreshView;

@end