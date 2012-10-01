//
//  CompareImageViewController.m
//  ImageComparision
//
//  Created by Lion MAC on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompareImageViewController.h"
#import <CoreGraphics/CGImage.h>

@interface CompareImageViewController ()

@end

@implementation CompareImageViewController
-(IBAction)compareButtonTapped
{
    long int matched=0;
    long int notMatched=0;
    for(int i=0;i<rgbOfimage1.count;i++)
    {
        if([[rgbOfimage1 objectAtIndex:i] isEqual:[rgbOfImage2 objectAtIndex:i]])
        {
            matched++;
        }
        else 
        {
            notMatched++;
        }
    }
    NSLog(@"Matched %ld    Not Matched %ld",matched,notMatched);
    
    float percent =  ((float)matched/rgbOfimage1.count)*100.0;
    
    NSLog(@"percent %f%% matched",percent);
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *image1 = [UIImage imageNamed:@"fullImage"];
    UIImage *image2 = [UIImage imageNamed:@"savedImage"];
    
    rgbOfimage1 = [[NSMutableArray alloc]init];
    rgbOfimage1 = [self rgbValuesOfImage:image1 :0 andY:0 count:image1.size.width*image1.size.height];
    
    //NSLog(@"%@",rgbOfimage1);
    
    rgbOfImage2 = [[NSMutableArray alloc] init];
    rgbOfImage2 = [self rgbValuesOfImage:image2 :0 andY:0 count:image2.size.width*image2.size.height];
    
    //NSLog(@"rgb of second image %@",rgbOfImage2);
}
-(NSMutableArray *)rgbValuesOfImage:(UIImage *)image:(int)xx andY:(int)yy count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);

    
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    for (int ii = 0 ; ii < count ; ++ii)
    {
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
        
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [result addObject:acolor];
    }
    
    free(rawData);
    
    return result;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
