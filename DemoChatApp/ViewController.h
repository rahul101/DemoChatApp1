//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(nonatomic,weak)IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UITextField *userInputTextField;
@property (weak, nonatomic) IBOutlet UIPageControl *indicatorPageControl;
- (IBAction)sendButtonAction:(id)sender;

@end

