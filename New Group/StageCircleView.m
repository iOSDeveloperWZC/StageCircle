//
//  StageCircleView.m
//  RedWoodAPP
//
//  Created by 王宗成 on 2017/12/14.
//  Copyright © 2017年 王宗成. All rights reserved.
//

#import "StageCircleView.h"
#define angleFromPercent(x) (2 * M_PI * x)
#define averageAngle M_PI/24
#define ToRad(deg)         ( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)        ( (180.0 * (rad)) / M_PI )
#define SQR(x)            ( (x) * (x) )

@implementation StageCircleView
{
    NSInteger adges;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

-(instancetype)initWithFrame:(CGRect)frame lineWidth:(NSInteger)lineWidth defaultColor:(UIColor *)defaultColor 
{
    if (self == [super initWithFrame:frame]) {
        
        adges = 40;
        self.backgroundColor = [UIColor whiteColor];
        _centerLable = [[UILabel alloc]init];
        _centerLable.text = @"8℃";
        _centerLable.textAlignment = NSTextAlignmentCenter;
        _centerLable.font = [UIFont systemFontOfSize:21];
        _centerLable.frame = CGRectMake(0, 0, 40, 30);
        _centerLable.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addSubview:_centerLable];
        
        _modeLable = [[UILabel alloc]init];
        _modeLable.frame = CGRectMake(0, 0, 80, 30);
        _modeLable.text = @"防冻模式";
        _modeLable.textAlignment = NSTextAlignmentCenter;
        _modeLable.textColor = [UIColor lightGrayColor];
        _modeLable.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2+30);
        _modeLable.font = [UIFont systemFontOfSize:15];
        [self addSubview:_modeLable];
        
        _lineWidth = lineWidth;
        _defaultColor = defaultColor;
        self.clipsToBounds = NO;
        
    }
    return self;
}

/*
 时间段 + 温度
 NO 逆时针
 YES 顺时针
 @{
 startAngle:
 endAngle:
 };
 
 */
-(void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //默认颜色标记的圆环
    [_defaultColor set]; //设置线条颜色
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                         radius:floor(self.frame.size.width/2)-adges
                                                     startAngle:0
                                                       endAngle:M_PI*2
                                                      clockwise:YES];
    aPath.lineWidth = _lineWidth;
    [aPath stroke];
    
    //内部圆环
    [[UIColor lightGrayColor] set];
    //设置线条颜色
    UIBezierPath* bPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                         radius:floor(self.frame.size.width/2)-adges*2+5
                                                     startAngle:0
                                                       endAngle:M_PI*2
                                                      clockwise:YES];
    bPath.lineWidth = 2;
    [bPath stroke];
    
    //外部圆环
    [[UIColor lightGrayColor] set]; //设置线条颜色
    UIBezierPath* cPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                         radius:floor(self.frame.size.width/2)-20
                                                     startAngle:0
                                                       endAngle:M_PI*2
                                                      clockwise:YES];
    cPath.lineWidth = 2;
    [cPath stroke];
    
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        
        NSDictionary *dic = _dataSource[i];
        NSNumber *startNumber = [dic objectForKey:@"startPoint"];
        NSNumber *endNumer = [dic objectForKey:@"endPoint"];
        //时间段
        
        CGFloat startAngle = [self angleFormTimeId:[startNumber integerValue]];
        CGFloat endAngle = [self angleFormTimeId:[endNumer integerValue]];
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, _lineWidth);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, floor(self.frame.size.width/2)-adges, startAngle, endAngle, NO);
        CGContextStrokePath(context);
    }

    //绘制时间点
    [self paintScale:context];
}

//画刻度
-(void)paintScale:(CGContextRef)context
{
    NSArray *values = @[@"24",@"21",@"18",@"15",@"12",@"9",@"6",@"3"];

    for (NSInteger i = 0; i < values.count; i++) {
        
        CGFloat percentageAlongCircle = i/(float)values.count;
        CGFloat degreesForLabel = percentageAlongCircle * 360;
        CGPoint closestPointOnCircleToLabel = [self pointFromAngle:degreesForLabel];
        
        [values[i] drawAtPoint:closestPointOnCircleToLabel withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]}];
        
        CGFloat startAngle1 = M_PI/4*i-M_PI/360;
        CGFloat endAngle1 = M_PI/4*i+M_PI/360;
        
        CGContextBeginPath(context);
        CGContextSetLineWidth(context, 5);
        CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, floor(self.frame.size.width/2)-22, startAngle1, endAngle1, NO);
        CGContextStrokePath(context);
        
    }
    
}
-(CGPoint)pointFromAngle:(int)angleInt{
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2- _lineWidth/2 , self.frame.size.height/2- _lineWidth/2);
    CGPoint result;
    CGFloat radius = self.frame.size.width/2 - 7;
    result.y = round(centerPoint.y + radius * sin(ToRad(-angleInt-90))) ;
    result.x = round(centerPoint.x + radius * cos(ToRad(-angleInt-90)));
    
    return result;
}

-(CGFloat)angleFormTimeId:(NSInteger)timeID
{
    return averageAngle*timeID-M_PI_2;
}

-(CGFloat)endAngleFormTime:(NSInteger)timeID
{
    return averageAngle*timeID-M_PI_2+M_PI/180;
}

@end
