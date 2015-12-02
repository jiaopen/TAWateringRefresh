//
//  TAWateringRefreshView.m
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/23.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import "TAWateringRefreshView.h"
#import "TAWaveView.h"

#define WAVE_WIDTH 46
#define WAVE_HEIGHT 50
#define MARGIN_HEIGHT 10

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
    return [self initWithFrame:CGRectMake(0, -(WAVE_HEIGHT+2*MARGIN_HEIGHT), [UIScreen mainScreen].bounds.size.width, WAVE_HEIGHT+2*MARGIN_HEIGHT)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _waveView = [[TAWaveView alloc] initWithFrame:CGRectMake((frame.size.width - WAVE_WIDTH)/2, 5, WAVE_WIDTH, WAVE_HEIGHT)];
        _waveView.frequency = 1;
        _waveView.waveWidth = 50;
        _waveView.amplitude = 3;
       
        [self addSubview:_waveView];
       
    }
    return self;
}

-(void)setMaskImage:(UIImage *)maskImage{
    CALayer* maskLayer = [CALayer layer];
    maskLayer.frame = _waveView.bounds;
    maskLayer.contents = (__bridge id _Nullable)maskImage.CGImage;
    _waveView.layer.mask = maskLayer;
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
//        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
//        offset = MIN(offset, WAVE_HEIGHT + 2*MARGIN_HEIGHT);
//       
//        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
        
    } else if (scrollView.isDragging) {
        BOOL _loading = NO;
        [_waveView startWave];
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 65) - 30;
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
    if (scrollView.contentOffset.y <= -(WAVE_HEIGHT + 2*MARGIN_HEIGHT) && _state != TAWateringRefreshStateLoading) {
        if ([_delegate respondsToSelector:@selector(wateringRefreshStartRefresh:)]) {
            [_delegate wateringRefreshStartRefresh:self];
        }
        self.state = TAWateringRefreshStateLoading;
        UIEdgeInsets loadingInset = scrollView.contentInset;
        loadingInset.top += self.frame.size.height;
        CGPoint contentOffset = scrollView.contentOffset;

        [UIView animateWithDuration:0.2 animations:^
         {
             scrollView.contentInset = loadingInset;
             scrollView.contentOffset = contentOffset;
         }];
    }
}

- (void)endRefresh:(UIScrollView*) scrollView {
    [UIView animateWithDuration:0.2 animations:^{
         UIEdgeInsets edgeInsets = scrollView.contentInset;
         edgeInsets.top = 0;
         scrollView.contentInset = edgeInsets;
     } completion:^(BOOL finished) {
         [_waveView stopWave];
     }];
    
    self.state = TAWateringRefreshStateNormal;
}
@end
