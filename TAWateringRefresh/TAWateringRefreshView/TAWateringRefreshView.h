//
//  TAWateringRefreshView.h
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/23.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    TAWateringRefreshStatePulling = 0,
    TAWateringRefreshStateNormal,
    TAWateringRefreshStateLoading,
} TAWateringRefreshState;


@interface TAWateringRefreshView : UIView

- (void)scrollViewDidScroll:(UIScrollView*) scrollView;
- (void)scrollViewDidEndDraging:(UIScrollView*) scrollView;
- (void)endRefresh;
- (void)endRefreshWithStatus:(NSString*) status;

@end
