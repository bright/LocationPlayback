#import "BIStyles.h"


@implementation BIStyles

+ (UIButton *)createButtonWithName:(NSString *)name {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:name forState:UIControlStateNormal];
    button.tintColor = [UIColor blackColor];
    button.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:223.0f/255.0f blue:190.0f/255.0f alpha:1.0];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1.f;
    button.layer.cornerRadius = 10.0f;

    return button;
}

+ (UITextField *)createTextField {
    UITextField *tripNameTextField = [UITextField new];
    tripNameTextField.textAlignment = NSTextAlignmentCenter;

    tripNameTextField.backgroundColor = [UIColor lightGrayColor];
    tripNameTextField.backgroundColor = [UIColor colorWithRed:253.0f/255.0f green:239.0f/255.0f blue:224.0f/255.0f alpha:1.0];
    tripNameTextField.layer.borderColor = [UIColor blackColor].CGColor;
    tripNameTextField.layer.borderWidth = 1.f;
    tripNameTextField.layer.cornerRadius = 10.0f;

    return tripNameTextField;
}
@end