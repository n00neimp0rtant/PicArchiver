#import "InnerButtonBar.h"

@implementation InnerButtonBar
@synthesize closeButton, markAsReadButton, saveButton;
-(id)init
{
	UIView* rootView = [super initWithFrame:CGRectMake(0, 0, 320, 40)];
	
	UIView* darkRectangle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
	darkRectangle.backgroundColor = [UIColor blackColor];
	darkRectangle.alpha = 0.6;
	[rootView addSubview:darkRectangle];
	
	UIFont* font = [[[UIButton buttonWithType:1] titleLabel] font];
	
	self.closeButton = [UIButton buttonWithType:0];
	self.closeButton.frame = CGRectMake(5, 5, 100, 30);
	self.closeButton.titleLabel.font = font;
	/*self.closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
	self.closeButton.layer.borderWidth = 1;
	self.closeButton.layer.cornerRadius = 8;*/
	[[self closeButton] setTitle:@"Close" forState:UIControlStateNormal];
	[[self closeButton] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[[self closeButton] setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[[self closeButton] setImage:[UIImage imageNamed:@"UIButtonBarPreviousSlide"] forState:UIControlStateNormal];
	[rootView addSubview:closeButton];
	
	self.markAsReadButton = [UIButton buttonWithType:0];
	self.markAsReadButton.frame = CGRectMake(110, 5, 100, 30);
	self.markAsReadButton.titleLabel.font = font;
	/*self.markAsReadButton.layer.borderColor = [UIColor whiteColor].CGColor;
	self.markAsReadButton.layer.borderWidth = 1;
	self.markAsReadButton.layer.cornerRadius = 8;*/
	[[self markAsReadButton] setTitle:@"Mark read" forState:UIControlStateNormal];
	[[self markAsReadButton] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[[self markAsReadButton] setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[[self closeButton] setImage:[UIImage imageNamed:@"UIButtonBarTrash"] forState:UIControlStateNormal];
	[rootView addSubview:markAsReadButton];
	
	self.saveButton = [UIButton buttonWithType:0];
	self.saveButton.frame = CGRectMake(215, 5, 100, 30);
	self.saveButton.titleLabel.font = font;
	/*self.saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
	self.saveButton.layer.borderWidth = 1;
	self.saveButton.layer.cornerRadius = 8;*/
	[[self saveButton] setTitle:@"Save" forState:UIControlStateNormal];
	[[self saveButton] setTitle:@"Saved" forState:UIControlStateDisabled];
	[[self saveButton] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[[self saveButton] setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
	[[self saveButton] setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	[[self closeButton] setImage:[UIImage imageNamed:@"UIButtonBarOrganize"] forState:UIControlStateNormal];
	[rootView addSubview:saveButton];
	
	return rootView;
}
@end

/*
innerView.frame = CGRectMake(0, -20, 320, 40)
innerView.alpha = 0.6
button1.frame = CGRectMake(5, 5, 50, 30)
*/