//
//  TAWaveView.h
//  TAWateringRefresh
//
//  Created by 李小盆 on 15/10/26.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAWaveView : UIView

-(void) startWave;
-(void) stopWave;

@property (nonatomic,assign) CGFloat speed;
@property (nonatomic,assign) CGFloat amplitude;
@property (nonatomic,assign) CGFloat frequency;
@property (nonatomic,strong) UIColor* waveColor;
@property (nonatomic,assign) CGFloat waveHeight;
@property (nonatomic,assign) CGFloat waveWidth;


@end
