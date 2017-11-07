//

#import "ViewController.h"
#import "SenderTableViewCell.h"
#import "ReceiverTableViewCell.h"
#define PHONE_UISCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define PHONE_UISCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define Estimated_Height     100.0

@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *messagesArrayList;
@property (nonatomic,strong)NSMutableArray *showChatArray;
@property (nonatomic,strong)NSString *userChatString;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *fetchChatDetails = [userDefaults objectForKey:@"MessageChatArray"];
    self.messagesArrayList = [[NSMutableArray alloc] initWithArray:fetchChatDetails];
    
    self.chatTableView.rowHeight = UITableViewAutomaticDimension;
    self.chatTableView.estimatedRowHeight = Estimated_Height;
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma Mark TextField Delegate Method
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification object:nil];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    //  CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -190;
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 60.0f;
        self.view.frame = f;
    }];
}


#pragma mark Table View Delegate and Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messagesArrayList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.messagesArrayList objectAtIndex:indexPath.row] valueForKey:@"Type"] isEqualToString:@"Sender"])
    {
        SenderTableViewCell *senderTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"SenderMessageCell" forIndexPath:indexPath];
        senderTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [senderTableViewCell setSenderCellContentValue:[[self.messagesArrayList objectAtIndex:indexPath.row] valueForKey:@"Message"]];
        return senderTableViewCell;
    }
    else
    {
        ReceiverTableViewCell *receiverTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ReceiverMessageCell" forIndexPath:indexPath];
        receiverTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [receiverTableViewCell setReceiverCellContentValue:[[self.messagesArrayList objectAtIndex:indexPath.row] valueForKey:@"Message"]];
        return receiverTableViewCell;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Send Button Event
- (IBAction)sendButtonAction:(id)sender
{
    if (![self.userInputTextField.text isEqual:@""] &&  self.userInputTextField.text != nil)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
        
        [self.userInputTextField resignFirstResponder];
        self.userChatString = self.userInputTextField.text;
        self.userInputTextField.text = @"";
        
        self.indicatorPageControl.hidden = NO;
        
        [self performSelector:@selector(callMessageListAction) withObject:nil afterDelay:0.5];
        
    }
}
-(void)callMessageListAction
{
    self.indicatorPageControl.hidden = YES;
    NSDictionary *senderDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@", self.userChatString],@"Message",@"Sender",@"Type", nil];
    [self.messagesArrayList addObject:senderDictionary];
    
    NSDictionary *receiverDictionaryOne = [[NSDictionary alloc] initWithObjectsAndKeys:@"The recipe is a great way to add intresting and new flavour to your basic breakfast staple",@"Message",@"Receiver",@"Type", nil];
    [self.messagesArrayList addObject:receiverDictionaryOne];
    
    NSDictionary *receiverDictionarySec = [[NSDictionary alloc] initWithObjectsAndKeys:@"In fact you cloud even some of the accompanying dips for mid meal snacking",@"Message",@"Receiver",@"Type", nil];
    [self.messagesArrayList addObject:receiverDictionarySec];
    
    NSUserDefaults  *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.messagesArrayList forKey:@"MessageChatArray"];
    [userDefaults synchronize];
    
    [self.chatTableView reloadData];
    
}

@end
