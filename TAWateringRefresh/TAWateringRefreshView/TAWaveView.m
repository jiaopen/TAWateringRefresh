//
//  TAWaveView.m
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/26.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import "TAWaveView.h"

@implementation TAWaveView
{
    CGFloat _offsetX;
    CADisplayLink *_waveDisplaylink;
    CAShapeLayer  *_waveLayer;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds  = YES;
        self.backgroundColor = [UIColor grayColor];
        _waveColor = [UIColor colorWithRed:0.278 green:0.841 blue:1.000 alpha:1.000];
        _speed = 5.0f;
        _amplitude = 5.0f;
        _frequency = 1;
        _waveHeight = 10;
        _waveWidth = self.frame.size.width;
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        _waveColor = [UIColor colorWithRed:0.278 green:0.841 blue:1.000 alpha:1.000];
        _speed = 5.0f;
        _amplitude = 5.0f;
        _frequency = 1;
        _waveHeight = 10;
        _waveWidth = self.frame.size.width;
    }
    return self;
}

-(void) startWave{
    if (_waveDisplaylink.isPaused) {
        _waveDisplaylink.paused = NO;
        return;
    }else if(_waveDisplaylink == nil) {
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.fillColor = _waveColor.CGColor;
        [self.layer addSublayer:_waveLayer];
        _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshWave:)];
        [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

-(void) stopWave{
//    [_waveDisplaylink invalidate];
//    _waveDisplaylink = nil;
    _waveDisplaylink.paused = YES;
}

-(void)refreshWave:(CADisplayLink *)displayLink{
    
    _offsetX += _speed;
    _waveLayer.path = [self refreshWavePath];
}


-(CGPathRef)refreshWavePath{
    
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, self.frame.size.height - _waveHeight);
    CGFloat y = 0.0f;
    for (float x = 0.0f; x <= self.frame.size.width ; x++) {
        y = _amplitude* sinf((360 /_waveWidth) *(x * _frequency * M_PI / 180) - _offsetX * _frequency * M_PI / 180) +  self.frame.size.height - _waveHeight;
//        y = _amplitude * sin(_frequency * M_PI / self.frame.size.width + _offsetX) + self.frame.size.height - _waveHeight;

        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil,  self.frame.size.width, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    p.CGPath = path;
    
    return path;
}
@end
