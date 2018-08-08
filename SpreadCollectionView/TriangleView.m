//
//  TriangleView.m
//  SpreadCollectionView
//
//  Created by Vokie on 16/7/29.
//  Copyright © 2016年 Vokie. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1.0);
    
    //设置颜色
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    
    
    //开始一个起始路径
    CGContextBeginPath(context);
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    CGContextMoveToPoint(context, 8, 0);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 0, 8);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 16, 8);
    //设置下一个坐标点
    CGContextClosePath(context);//封起来
    
    //连接上面定义的坐标点
    CGContextFillPath(context);
    
}


@end
