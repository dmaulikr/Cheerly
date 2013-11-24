//
//  BlockActionSheet.h
//
//

#import <UIKit/UIKit.h>

/**
 * A simple block-enabled API wrapper on top of UIActionSheet.
 */
@interface BlockActionSheet : NSObject {
@private
    UIView *_view;
    NSMutableArray *_blocks;
    CGFloat _height;
}

@property (nonatomic, readonly) UIView *view;

+ (id)sheetWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title;
- (void)showInView:(UIView *)view;
- (NSUInteger)buttonCount;

- (void)addButtonWithTitle:(NSString*)title block:(void (^)()) block;
- (void)addOrangeButtonWithTitle:(NSString*)title block:(void (^)()) block;

@end
