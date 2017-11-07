//

#import "ReceiverTableViewCell.h"

@implementation ReceiverTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.receriverMessageLabel.layer.cornerRadius = 10;
    self.receriverMessageLabel.layer.masksToBounds = YES;
    // Initialization code
}
-(void)setReceiverCellContentValue:(NSString*)messageString
{
    self.receriverMessageLabel.attributedText = [self setLabelTextWithStyle:messageString];
}
-(NSAttributedString*)setLabelTextWithStyle:(NSString*)inputString
{
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentLeft;
    style.firstLineHeadIndent = 15.0f;
    style.headIndent = 15.0f;
    style.tailIndent = -15.0f;
    style.lineSpacing = 2.0f;
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:inputString attributes:@{ NSParagraphStyleAttributeName : style}];
    
    return attrText;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
