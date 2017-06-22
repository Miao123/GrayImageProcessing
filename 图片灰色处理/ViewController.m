//
//  ViewController.m
//  图片灰色处理
//
//  Created by 苗建浩 on 2017/6/22.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"111"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 150, 200)];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UIImage *grayImage = [self systemImageToGrayImage:[UIImage imageNamed:@"111"]];
    UIImageView *grayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 260, 150, 200)];
    grayImageView.image = grayImage;
    [self.view addSubview:grayImageView];
    
}


- (UIImage*)systemImageToGrayImage:(UIImage*)image{
    int width  = image.size.width;
    int height = image.size.height;
    //第一步：创建颜色空间(说白了就是开辟一块颜色内存空间)
    CGColorSpaceRef colorRef = CGColorSpaceCreateDeviceGray();
    
    //第二步：颜色空间上下文(保存图像数据信息)
    //参数一：指向这块内存区域的地址（内存地址）
    //参数二：要开辟的内存的大小，图片宽
    //参数三：图片高
    //参数四：像素位数(颜色空间，例如：32位像素格式和RGB的颜色空间，8位）
    //参数五：图片的每一行占用的内存的比特数
    //参数六：颜色空间
    //参数七：图片是否包含A通道（ARGB四个通道）
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorRef, kCGImageAlphaNone);
    //释放内存
    CGColorSpaceRelease(colorRef);
    
    if (context == nil) {
        return  nil;
    }
    
    //渲染图片
    //参数一：上下文对象
    //参数二：渲染区域
    //源图片
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);;
    
    //将绘制的颜色空间转成CGImage
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    
    //将c/c++图片转成iOS可显示的图片
    UIImage *dstImage = [UIImage imageWithCGImage:grayImageRef];
    
    //释放内存
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    
    return dstImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
