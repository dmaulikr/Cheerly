//
//  BlockActionSheet.m
//
//

#import "BlockActionSheet.h"
#import "BlockBackground.h"
#import "Constants.h"

#define kActionSheetBounce         10
#define kActionSheetBorder         10
#define kActionSheetTopMargin      10
#define kActionSheetButtonHeight   45

@implementation BlockActionSheet
@synthesize view = _view;
static UIFont *titleFont = nil;

#pragma mark - init

+ (void)initialize {
    if (self == [BlockActionSheet class]) {
        titleFont = [Font normalSize:18];
    }
}
+ (id)sheetWithTitle:(NSString *)title {
    return [[[BlockActionSheet alloc] initWithTitle:title] autorelease];
}
- (id)initWithTitle:(NSString *)title  {
    if ((self = [super init])) {
        UIWindow *parentView = [BlockBackground sharedInstance];
        CGRect frame = parentView.bounds;
        
        _view = [[UIView alloc] initWithFrame:frame];
        _blocks = [[NSMutableArray alloc] init];
        _height = kActionSheetTopMargin;

        if (title) {
            CGSize size = [title sizeWithFont:titleFont constrainedToSize:CGSizeMake(frame.size.width-kActionSheetBorder*2, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(kActionSheetBorder, _height, frame.size.width-kActionSheetBorder*2, size.height)];
            labelView.font = titleFont;
            labelView.numberOfLines = 0;
            labelView.lineBreakMode = NSLineBreakByWordWrapping;
            labelView.textColor = [Colors normalGray];
            labelView.backgroundColor = [UIColor clearColor];
            labelView.textAlignment = NSTextAlignmentCenter;
            labelView.text = title;
            [_view addSubview:labelView];
            [labelView release];
            
            _height += size.height + 5;
        }
    }
    
    return self;
}
- (void)dealloc  {
    [_view release];
    [_blocks release];
    [super dealloc];
}

#pragma Add Buttons

- (void)addOrangeButtonWithTitle:(NSString *)title block:(void (^)())block {
    [_blocks addObject:@[block ? [block copy] : [NSNull null], title, @"orange_button.png"]];
}
- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block {
    [_blocks addObject:@[block ? [block copy] : [NSNull null], title, @"gray_button.png"]];
}
- (NSUInteger)buttonCount {
    return _blocks.count;
}

#pragma Show/Hide

- (void)showInView:(UIView *)view {
    NSUInteger i = 1;
   
    [_view setBackgroundColor:[Colors lightBackground]];

    for (NSArray *object in _blocks) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kActionSheetBorder, _height, _view.bounds.size.width-kActionSheetBorder*2, kActionSheetButtonHeight)];
        button.titleLabel.font = [Font normalSize:18];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i++;
        button.adjustsImageWhenHighlighted = YES;
        button.layer.cornerRadius = 5.0;
        button.clipsToBounds = YES;
        [button setBackgroundImage:[[UIImage imageNamed:object[2]] stretchableImageWithLeftCapWidth:4.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [button setTitle:object[1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.6] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_view addSubview:button];
        _height += kActionSheetButtonHeight + kActionSheetBorder;
    }
    
    [[BlockBackground sharedInstance] addToMainWindow:_view];
    CGRect frame = _view.frame;
    frame.origin.y = [BlockBackground sharedInstance].bounds.size.height;
    frame.size.height = _height + kActionSheetBounce;
    _view.frame = frame;
    
    __block CGPoint center = _view.center;
    center.y -= _height + kActionSheetBounce;
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [BlockBackground sharedInstance].alpha = 1.0f;
        _view.center = center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            center.y += kActionSheetBounce;
            _view.center = center;
        } completion:nil];
    }];
    
    [self retain];
}
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated  {
   
    if (buttonIndex >= 0 && buttonIndex < [_blocks count]) {
        id obj = [[_blocks objectAtIndex: buttonIndex] objectAtIndex:0];
        if (![obj isEqual:[NSNull null]]) ((void (^)())obj)();
    }
    
    if (animated) {
        CGPoint center = _view.center;
        center.y += _view.bounds.size.height;
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _view.center = center;
            [[BlockBackground sharedInstance] reduceAlphaIfEmpty];
        } completion:^(BOOL finished) {
            [[BlockBackground sharedInstance] removeView:_view];
            [_view release]; _view = nil;
            [self autorelease];
        }];
    }
    else {
        [[BlockBackground sharedInstance] removeView:_view];
        [_view release]; _view = nil;
        [self autorelease];
    }
}

#pragma mark - Action

- (void)buttonClicked:(id)sender  {
    [self dismissWithClickedButtonIndex:[sender tag] - 1 animated:YES];
}

@end
