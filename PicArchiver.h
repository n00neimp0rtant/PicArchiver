#import <XXUnknownSuperclass.h> // Unknown library
#import "ButtonBar.h"

@interface FeedTableViewController : NSObject {}
-(void)reloadTableViewDataSource;
-(void)doReload:(BOOL)reload;
-(void)updateSnap:(id)snap;
@end

@interface FeedViewController: NSObject {}
@property(retain, nonatomic) FeedTableViewController* feedTableViewController;
-(void)hideSnap:(id)snap;
-(void)endSnap:(id)snap;
@end

@interface User : NSObject{}
-(id)snapForId:(id)anId;
@end

@interface Manager : NSObject {}
@property(retain, nonatomic) User* user;
+(id)shared;
-(void)sync;
@end

@interface NavigationController : NSObject {}
@end

@interface Snap : NSObject{}
@property(retain, nonatomic) NSNumber* time_left;
@property(retain, nonatomic) NSString* _id;
@property(retain, nonatomic) NSNumber* type;
@end

@interface SnapImageView : UIImageView {}
@property(retain, nonatomic) UILabel* counter;
@property(retain, nonatomic) UIImageView* imageView;
@end




/////////////////////////////////////////////////////////


@interface SnapImageView (PicArchiver)
-(ButtonBar*)buttonBar;
-(Snap*)correspondingSnap;
-(void)handleTap:(UITapGestureRecognizer*)tapRecognizer;
-(void)closeButtonTapped;
-(void)markAsReadButtonTapped;
-(void)saveButtonTapped;
@end

