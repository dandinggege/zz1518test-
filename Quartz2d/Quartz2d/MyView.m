//
//  MyView.m
//  Quartz2d
//
//  Created by 张广洋 on 16/1/29.
//  Copyright © 2016年 张广洋. All rights reserved.
//

#import "MyView.h"

@implementation MyView

static void drawLine(void){
    //获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //创建一个路径
    CGMutablePathRef path=CGPathCreateMutable();
    //把画笔移动到某个点（某个起始点）
    CGPathMoveToPoint(path, NULL, 20, 20);
    //添加一个直线到path
    //    CGPathAddLineToPoint(path, NULL, 100, 10);
    //    CGPathAddLineToPoint(path, NULL, 100, 50);
    //    CGPathAddLineToPoint(path, NULL, 10, 50);
    
    CGPathAddLineToPoint(path, NULL, 200, 20);
    //形成一个闭环
    //    CGPathCloseSubpath(path);
    //添加到context中
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    //设置画笔颜色
    [[UIColor purpleColor]setStroke];
    //设置画笔粗细
    CGContextSetLineWidth(ctx,1);
    //设置填充颜色
    [[UIColor yellowColor]setFill];
    //设置路径中线段之间的连接样式
    /*
     kCGLineJoinMiter, 斜角，一起尖角
     kCGLineJoinRound, 圆角
     kCGLineJoinBevel  斜角，各自斜角
     */
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    //设置线帽样式
    /*
     kCGLineCapButt,
     kCGLineCapRound,
     kCGLineCapSquare
     */
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    
    //设置虚线
    CGFloat lengths[]={5,10,15};
    //绘制虚线的四个参数：
    /*
     1,上下文
     2,phase相位
     3,数组
     4,数组长度
     绘制法则：首先绘制5-2个点，跳过10个点，再绘制5个点，跳过10个点..
     如果lengths是{5,10,12}:首先绘制5-2个点，跳过10个点，再绘制12个点，跳过5个点，再绘制10个点，跳过12个点。。。
     */
    CGContextSetLineDash(ctx, 0, lengths, 3);
    
    //    //描线
    //    CGContextStrokePath(ctx);
    //    //只绘制填充颜色
    //    CGContextFillPath(ctx);
    //绘制路线
    /*
     kCGPathFill,  表示用非零绕数规则
     kCGPathEOFill,  表示用奇偶规则
     kCGPathStroke,  表示描线，不填充；
     kCGPathFillStroke,  表示填充和描线；
     kCGPathEOFillStroke 描线填充
     */
    //绘制填充和描线
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

//会在视图在屏幕显示的时候调用一次。
//如果希望再次绘制，可以调用setNeedsDisplay
- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
//    drawLine();
//    [self drawRect];
//    [self drawArc];
//    [self drawText];
    [self drawImage];
}

-(void)drawImage{
    
    //画圆，以便以后指定可以显示图片的范围
    //获取图形上下文
   CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 100, 50, 50));
    //指定上下文中可以显示内容的范围就是圆的范围
    CGContextClip(ctx);
    
    UIImage * image=[UIImage imageNamed:@"xxx.jpg"];
    //从某个点开始，原图大小绘制
    [image drawAtPoint:CGPointMake(10, 10)];
//    //在某个rect中绘制，会拉伸，收缩
//    [image drawInRect:CGRectMake(0, 0, 80, 80)];
//    //在某个rect中平铺
//    [image drawAsPatternInRect:CGRectMake(0, 100, 80, 80)];
}

-(void)drawText{
    NSString * text=@"看这里哦";
    //设置颜色
    [[UIColor purpleColor]setStroke];
    UIFont * font=[UIFont fontWithName:@"Marker Felt" size:16];
    [text drawAtPoint:CGPointMake(100, 100) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor]}];
    
    CGRect rect = CGRectMake(50, 200, 200, 40);
    [[UIColor blueColor]set];
    UIRectFill(rect);
    [[UIColor redColor]set];
    // 只能用居中、左、右对齐
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    [text drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor],NSParagraphStyleAttributeName:paragraph}];
    //关于文字font更多Attributes  http://blog.sina.com.cn/s/blog_8d1bc23f0101etmr.html
}

-(void)drawArc{
    //获取上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置画笔颜色
    [[UIColor purpleColor]setStroke];
    //设置线宽
    CGContextSetLineWidth(context, 100);
    //设置线帽
    CGContextSetLineCap(context, kCGLineCapButt);
    /*
     参数说明:
     1，上下文
     2 3，x，y表示弧的中心点
     4，半径
     5，起始位置弧度
     6，结束位置弧度
     7，是否顺时针方向0表示顺时针，1表示逆时针
     */
    static int k;
    CGContextAddArc(context, 200, 200, 50, -M_PI_2, -M_PI_2+k, 0);
    CGContextStrokePath(context);
    k++;
}


-(void)drawRect{
    //获取上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置颜色填充
    [[UIColor redColor]setFill];
    //设置画笔颜色
    [[UIColor greenColor]setStroke];
    //设置线宽
    CGContextSetLineWidth(context, 2);
    //填充矩形：
    CGContextFillRect(context, CGRectMake(50, 50, 100, 100));
//    UIRectFill(CGRectMake(50, 50, 100, 100));
    //绘制矩形
    CGContextStrokeRect(context, CGRectMake(50, 50, 100, 100));
    
    //第二种绘制矩形方式。
    //添加一个矩形到context，这个方法不会直接绘制矩形，需要调用绘制方法
    CGContextAddRect(context, CGRectMake(150, 100, 40, 40));
    CGContextStrokePath(context);
}




@end






