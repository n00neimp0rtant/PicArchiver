#import "ButtonBar.h"

@implementation ButtonBar
@synthesize innerButtonBar, hidden;
-(id)init
{
	UIView* rootView = [super initWithFrame:CGRectMake(0, 0, 320, 40)];
	innerButtonBar = [[InnerButtonBar alloc] init];
	[rootView addSubview:innerButtonBar];
	[self hideAnimated:NO];
	//[rootView setHidden:YES];
	return rootView;
}
-(void)hideAnimated:(BOOL)animated
{
	hidden = YES;
	CGRect newFrame = CGRectMake(0, -40, 320, 40);
	if(animated)
	{
		[UIView beginAnimations:@"hideButtonBar" context:NULL];
		//[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.3];
		innerButtonBar.alpha = 0;
		innerButtonBar.frame = newFrame;
		[UIView commitAnimations];
	}
	else
		innerButtonBar.frame = newFrame;
}
-(void)showAnimated:(BOOL)animated
{
	if(!hidden)
		[self hideAnimated:YES];
	else
	{
		hidden = NO;
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
		CGRect newFrame = CGRectMake(0, 0, 320, 40);
		if(animated)
		{
			[UIView beginAnimations:@"showButtonBar" context:NULL];
			//[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:0.3];
			innerButtonBar.frame = newFrame;
			innerButtonBar.alpha = 1;
			[UIView commitAnimations];
		}
		else
		{
			innerButtonBar.frame = newFrame;
			innerButtonBar.alpha = 1;
		}
		[self performSelector:@selector(hideAnimated:) withObject:[NSNumber numberWithBool:animated] afterDelay:5];
	}
}
@end

