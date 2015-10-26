//
//  TAWateringRefreshView.m
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/23.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import "TAWateringRefreshView.h"
#import "TAWaveView.h"

#define WAVE_WIDTH 50

NSString * viewMoveKey = @"waveMoveAnimation";

@interface TAWateringRefreshView ()

@property (nonatomic, assign) TAWateringRefreshState state;
@property (nonatomic, strong) TAWaveView* waveView;


@end

@implementation TAWateringRefreshView

+ (instancetype)refreshView{
    TAWateringRefreshView* refreshView = [[TAWateringRefreshView alloc] init];
    return refreshView;
}

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, -(WAVE_WIDTH+10), [UIScreen mainScreen].bounds.size.width, WAVE_WIDTH+10)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _waveView = [[TAWaveView alloc] initWithFrame:CGRectMake((frame.size.width - WAVE_WIDTH)/2, 5, WAVE_WIDTH, WAVE_WIDTH)];
        _waveView.frequency = 1;
        _waveView.waveWidth = 50;
        _waveView.amplitude = 3;
        [self addSubview:_waveView];
    }
    return self;
}


- (void)setState:(TAWateringRefreshState)state{
    
    switch (state) {
        case TAWateringRefreshStateLoading:
   
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
        [_waveView startWave];
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, WAVE_WIDTH) - 10;
        _waveView.waveHeight = offset;
    
        if (_state == TAWateringRefreshStateNormal && scrollView.contentOffset.y < 0 && !_loading) {
            self.state = TAWateringRefreshStatePulling;
        }
       
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
        
    }
}

- (void)scrollViewDidEndDraging:(UIScrollView*) scrollView {
    
    BOOL _loading = NO;

    
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
         
     } completion:^(BOOL finished) {
         [_waveView stopWave];
     }];
    
    self.state = TAWateringRefreshStateNormal;
}
@end
