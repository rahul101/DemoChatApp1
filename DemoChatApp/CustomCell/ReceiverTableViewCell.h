//
#import <UIKit/UIKit.h>

@interface ReceiverTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *receriverMessageLabel;
-(void)setReceiverCellContentValue:(NSString*)messageString;

@end
