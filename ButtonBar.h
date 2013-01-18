#import <UIKit5/UIKit.h>
#import "InnerButtonBar.h"

@interface ButtonBar : UIView {}
@property(retain, nonatomic) InnerButtonBar* innerButtonBar;
@property(assign) BOOL hidden;
-(void)hideAnimated:(BOOL)animated;
-(void)showAnimated:(BOOL)animated;
-(BOOL)hidden;
@end