//
//  GMSStampStyle+Beta.h
//  Google Maps SDK for iOS
//
//  Copyright 2020 Google LLC
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** The drawing style for a stamped image or texture over a GMSStrokeStyle. */
@interface GMSStampStyle : NSObject

/**
 * The image or texture that will repeated over a stroke.
 * Note that this image will be compressed into a square - so for best results have a square image.
 * The rendered stamps will be the width of the line that the GMSStrokeStyle is set on. The image
 * will be oriented with the top of the image towards the start point, and the bottom of the image
 * towards the end point. For example, if the underlying line has two points and the start point is
 * directly above the endpoint, the stamp will appear in an upright orientation.
 */
@property(nonatomic, readonly) UIImage *stampImage;

- (instancetype)init NS_UNAVAILABLE;

@end

/**
 * Describes the drawing style for a texture over a GMSStyleSpan.
 * Note that if this is set with a gradient stroke, the stroke will only show up as a solid-colored
 * stroke. A workaround would be to a set a clear stroke on this line (with the
 * stamp), and then make a separate polyline with the gradient stroke and without the stamp, with
 * the same path as this polyline at a lower z-index.
 */
@interface GMSTextureStyle : GMSStampStyle

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithImage:(UIImage *)image NS_DESIGNATED_INITIALIZER;

+ (instancetype)textureStyleWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
