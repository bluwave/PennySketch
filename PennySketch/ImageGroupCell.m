//
//  ImageGroupCell.m
//  PennySketch
//
//  Created by slim on 9/26/12.
//  Copyright (c) 2012 Sarcasm. All rights reserved.
//


#import "ImageGroupCell.h"
#import   "UIImage+ProportionalFill.h"

@interface ImageGroupCell()
@property(nonatomic, retain) UIImage * slice;
@end

@implementation ImageGroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.customImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_customImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImage:(UIImage *)image
{
    _image = image;

    CGRect customRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    [_customImageView setImage:[_image imageToFitSize:CGSizeMake(self.frame.size.width, self.frame.size.height) method:MGImageResizeCrop]];


//    CGImageRef sliceRef = CGImageCreateWithImageInRect(image.CGImage, customRect);
//    self.slice = [UIImage imageWithCGImage:sliceRef];
//    CGImageRelease(sliceRef);
//    [_customImageView setImage:_slice];
//    [_customImageView setContentMode:UIViewContentModeScaleToFill];
}

//- (CGRect)resizeCGRect:(CGRect)rect toImage:(UIImage *)image
//{
//    CGSize size = rect.size;
//    CGSize iSize = image.size;
//    if (iSize.width > iSize.height)
//    {
//        if (iSize.width / iSize.height > size.width / size.height)
//            size.height = size.width * (iSize.height / iSize.width);
//        else
//            size.width = size.height * (iSize.width / iSize.height);
//    }
//    else
//    {
//        if (iSize.height / iSize.width > size.height / size.width)
//            size.width = size.height * (iSize.width / iSize.height);
//        else
//            size.height = size.width * (iSize.height / iSize.width);
//    }
//    rect.size = size;
//    return rect;
//}
//
//-(void) reesizeImage:(UIImage *)image
//{
//    shortSideMax = 640;
//    longSideMax = 960;
//
//    if (image.width >= image.height)
//    {
//        if (image.width <= longSideMax && image.height <= shortSideMax)
//            return image;  // no resizing required
//        wRatio = longSideMax / image.width;
//        hRatio = shortSideMax / image.height;
//    }
//    else
//    {
//        if (image.height <= longSideMax && image.width <= shortSideMax)
//            return image; // no resizing required
//        wRatio = shortSideMax / image.width;
//        hRatio = longSideMax / image.height;
//    }
//
//    // hRatio and wRatio now have the scaling factors for height and width.
//    // You want the smallest of the two to ensure that the resulting image
//    // fits in the desired frame and maintains the aspect ratio.
//    resizeRatio = Min(wRatio, hRatio);
//
//    newHeight = image.Height * resizeRatio;
//    newWidth = image.Width * resizeRatio;
//
//    // Now call function to resize original image to [newWidth, newHeight]
//    // and return the result.
//}


@end
