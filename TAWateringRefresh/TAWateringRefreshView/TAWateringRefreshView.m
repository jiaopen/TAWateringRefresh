//
//  TAWateringRefreshView.m
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/23.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import "TAWateringRefreshView.h"

@interface TAWateringRefreshView ()

@property (nonatomic, assign) TAWateringRefreshState state;


@end

@implementation TAWateringRefreshView


- (void)setState:(TAWateringRefreshState)state{
    
    switch (state) {
//        case EGOOPullRefreshPulling:
//            
//            _statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
//            [CATransaction begin];
//            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
//            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
//            [CATransaction commit];
//            
//            break;
//        case EGOOPullRefreshNormal:
//            
//            if (_state == EGOOPullRefreshPulling) {
//                [CATransaction begin];
//                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
//                _arrowImage.transform = CATransform3DIdentity;
//                [CATransaction commit];
//            }
//            
//            _statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
//            [_activityView stopAnimating];
//            [CATransaction begin];
//            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//            _arrowImage.hidden = NO;
//            _arrowImage.transform = CATransform3DIdentity;
//            [CATransaction commit];
//            
//            [self refreshLastUpdatedDate];
//            
//            break;
        case TAWateringRefreshStateLoading:
            
//            [CATransaction begin];
//            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
//            _arrowImage.hidden = YES;
//            [CATransaction commit];
            
            break;
        default:
            break;
    }
    
    _state = state;
}

- (void)scrollViewDidScroll:(UIScrollView*) scrollView{
    if (_state == TAWateringRefreshStateLoading) {
        
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
        
    } else if (scrollView.isDragging) {
        
        BOOL _loading = NO;
//        if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
//            _loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
//        }
        
        if (_state == TAWateringRefreshStatePulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
            [self setState:TAWateringRefreshStateNormal];
        } else if (_state == TAWateringRefreshStateNormal && scrollView.contentOffset.y < -65.0f && !_loading) {
            [self setState:TAWateringRefreshStatePulling];
        }
        
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
    }
}

- (void)scrollViewDidEndDraging:(UIScrollView*) scrollView {
    
    BOOL _loading = NO;
//    if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
//        _loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
//    }
    
    if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
        
        if ([_delegate respondsToSelector:@selector(wateringRefreshStartRefresh:)]) {
            [_delegate wateringRefreshStartRefresh:self];
        }
        self.state = TAWateringRefreshStateLoading;
        CGPoint contentOffset = scrollView.contentOffset;

        [UIView animateWithDuration:0.2 animations:^
         {
             scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
             scrollView.contentOffset = contentOffset;

         }];
        
    }
}

- (void)endRefresh:(UIScrollView*) scrollView {
    [UIView animateWithDuration:0.2 animations:^
     {
         scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
         
     }];
    
    self.state = TAWateringRefreshStateNormal;
}
@end
