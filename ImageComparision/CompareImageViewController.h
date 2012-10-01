//
//  CompareImageViewController.h
//  ImageComparision
//
//  Created by Lion MAC on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareImageViewController : UIViewController{
    NSMutableArray *rgbOfimage1;
    NSMutableArray *rgbOfImage2;
}
-(IBAction)compareButtonTapped;
@end
