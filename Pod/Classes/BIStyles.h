#import <UIKit/UIKit.h>

@interface BIStyles : NSObject
+ (UIButton *)createButtonWithName:(NSString *)name;

+ (UITextField *)createTextField;

+ (void)createRoundedBorderForView:(UIView *)view;

+ (UIColor *)buttonColor;

+ (UIColor *)textFieldsColor;
@end