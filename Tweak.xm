#import "PicArchiver.h"
#import "ButtonBar.h"

static NSUserDefaults* prefs;	// not in use 
static FeedViewController* feedViewController;
static SnapImageView* snapImageView;
static NSMutableArray* snapImages;
static NSMutableSet* savedIDs;
static BOOL hideSafety = NO, snapSafety = NO, markAsReadSafety = NO;

%hook FeedViewController
-(id)initWithNibName:(id)nibName bundle:(id)bundle
{
	feedViewController = %orig;
	
	return feedViewController;
}

-(void)hideSnap:(id)picaboo
{
	if(hideSafety)
		%orig;
	else
		NSLog(@"blocked: ");
	%log;
}
%end

%hook SnapImageView
-(id)initWithFrame:(CGRect)frame
{
	%log;
	SnapImageView* image = %orig;
	UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] init];
	[tapRecognizer addTarget:image action:@selector(handleTap:)];
	[tapRecognizer setNumberOfTapsRequired:1];
	[tapRecognizer setEnabled:YES];
	[image addGestureRecognizer:tapRecognizer];
	
	ButtonBar* buttonBar = [[ButtonBar alloc] init];
	[[[buttonBar innerButtonBar] closeButton] addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchDown];
	
	[[[buttonBar innerButtonBar] markAsReadButton] addTarget:self action:@selector(markAsReadButtonTapped) forControlEvents:UIControlEventTouchDown];
	
	[[[buttonBar innerButtonBar] saveButton] addTarget:self action:@selector(saveButtonTapped) forControlEvents:UIControlEventTouchDown];
	
	[image addSubview:buttonBar];
	[[image counter] setHidden:YES];
	
	if(!snapSafety)
		[snapImages addObject:image];
	snapImageView = image;
	return snapImageView;
}

-(BOOL)setSnap:(id)snap
{
	%log;
	BOOL return_value = %orig;
	NSLog(@"return value = %i", return_value);
	[[self counter] setText:[snap _id]];	// the software development gods weep on this day
	NSLog(@"type = %i", [[snap type] intValue]);
	[[[[self buttonBar] innerButtonBar] saveButton] setEnabled:YES];
	for(NSString* ids in savedIDs)
	{
		if([ids isEqualToString:[snap _id]])
		{
			[[[[self buttonBar] innerButtonBar] saveButton] setEnabled:NO];
			break;
		}
	}
	return return_value;
}

%new
-(ButtonBar*)buttonBar
{
	ButtonBar* buttonBar;
	for(id view in [self subviews])
	{
		if([NSStringFromClass([view class]) isEqualToString:@"ButtonBar"])
		{
			buttonBar = view;
			break;
		}
	}
	if(buttonBar == nil)
	{
		NSLog(@"whoops\n");
		return nil;
	}
	else
		return buttonBar;
}

%new
-(Snap*)correspondingSnap
{
	return [[(Manager*)[%c(Manager) shared] user] snapForIndex:[[self counter] text]]; //updated method for snapchat 5.0
}

%new
-(void)handleTap:(UITapGestureRecognizer*)tapRecognizer
{
	[[self buttonBar] showAnimated:YES];
}

%new
-(void)closeButtonTapped
{
	hideSafety = YES;
	[feedViewController hideSnap:[self correspondingSnap]];
	hideSafety = NO;
}

%new
-(void)markAsReadButtonTapped
{
	markAsReadSafety = YES;
	hideSafety = YES;
	Manager* manager = (Manager*)[%c(Manager) shared];
	[[self correspondingSnap] setTime_left:[NSNumber numberWithInt:1]];
	[feedViewController hideSnap:[self correspondingSnap]];
	[feedViewController endSnap:[self correspondingSnap]];
	[manager sync];
	[[feedViewController feedTableViewController] doReload:YES];
	[[feedViewController feedTableViewController] updateSnap:[self correspondingSnap]];
	[[feedViewController feedTableViewController] reloadTableViewDataSource];
	hideSafety = NO;
	markAsReadSafety = NO;
}

%new
-(void)saveButtonTapped
{
	// if image,
	if([[[self correspondingSnap] type] intValue] == 0)
		UIImageWriteToSavedPhotosAlbum([[self imageView] image], nil, nil, nil);
	
	// else if video,
	NSString* path = [NSString stringWithFormat:@"%@/../tmp/%@.mov", [[NSBundle mainBundle] bundlePath], [[self counter] text]];
	NSLog(@"%@\n", path);
	if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path))
		NSLog(@"valid\n");
	else
		NSLog(@"NOT valid\n");
	if([[[self correspondingSnap] type] intValue] == 1)
		UISaveVideoAtPathToSavedPhotosAlbum(path, nil, nil, nil);
	
	[savedIDs addObject:[[self correspondingSnap] _id]];
	
	self.buttonBar.innerButtonBar.saveButton.enabled = NO;
}

-(void)setUserInteractionEnabled:(BOOL)enabled
{
	%orig(YES);
}
-(BOOL)userInteractionEnabled
{
	return YES;
}
-(void)updateSnap:(id)snap
{
	%log;
	%orig;
}

%end

%hook Manager
-(void)startTimer:(id)timer
{
	if(markAsReadSafety)
	{
		%orig;
	}
	else
		NSLog(@"blocked: ");
	%log;
}
-(void)tick:(id)tick
{
	/*if(markAsReadSafety)
	{
		%orig;
	}
	else
		NSLog(@"blocked: ");*/
	%orig;
	%log;
}
%end

%hook AppDelegate
-(void)applicationWillResignActive:(id)application
{
	NSLog(@"blocked: ");
	%log;
	%orig;
}
%end

%ctor
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	snapImages = [[NSMutableArray alloc] init];
	savedIDs = [[NSMutableSet alloc] init];
	
	/*prefs = [[NSUserDefaults alloc] init];
	if(![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/com.n00neimp0rtant.picarchiver.plist"])
	{
		[prefs setPersistentDomain:[NSDictionary dictionary] forName:[NSString stringWithFormat:@"com.n00neimp0rtant.picarchiver"]];
		[prefs setBool:YES forKey:@"showMarkReadAlert"];
		[prefs synchronize];
	}
	else
		[prefs setPersistentDomain:[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.n00neimp0rtant.picarchiver.plist"] forName:[NSString stringWithFormat:@"com.n00neimp0rtant.picarchiver"]];
	*/
	
	[pool drain];
}
