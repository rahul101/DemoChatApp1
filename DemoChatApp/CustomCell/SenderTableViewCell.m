//

#import "SenderTableViewCell.h"

@implementation SenderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.senderMessageLabel.layer.cornerRadius = 10;
    self.senderMessageLabel.layer.masksToBounds = YES;
    // Initialization code
}

-(void)setSenderCellContentValue:(NSString*)messageString
{
    self.senderMessageLabel.attributedText = [self setLabelTextWithStyle:messageString];
}
-(NSAttributedString*)setLabelTextWithStyle:(NSString*)inputString
{
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
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
