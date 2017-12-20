//
//  StageCircleView.h
//  RedWoodAPP
//
//  Created by 王宗成 on 2017/12/14.
//  Copyright © 2017年 王宗成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StageCircleView : UIView
@property(nonatomic,strong)NSArray *dataSource;//驱动的数据源
@property(nonatomic,assign)NSInteger lineWidth;//线宽
@property(nonatomic,strong)UIColor *defaultColor;//默认颜色

@property(nonatomic,strong)UIColor *innerOutColor;//内外圆环 的颜色
@property(nonatomic,assign)NSInteger innerOutLineWidth;//内外环的宽度

@property(nonatomic,strong)NSMutableDictionary *temMapColorDic;
@property(nonatomic,strong)UILabel *centerLable;
@property(nonatomic,strong)UILabel *modeLable;
-(instancetype)initWithFrame:(CGRect)frame lineWidth:(NSInteger)lineWidth defaultColor:(UIColor *)defaultColor;
@end
