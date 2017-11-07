//

#import <UIKit/UIKit.h>

@interface SenderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *senderMessageLabel;
-(void)setSenderCellContentValue:(NSString*)messageString;
@end
