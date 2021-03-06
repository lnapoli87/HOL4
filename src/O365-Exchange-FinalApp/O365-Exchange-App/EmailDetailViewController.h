#import "ViewController.h"
#import <office365_exchange_sdk/office365_exchange_sdk.h>

@interface EmailDetailViewController : ViewController
@property (weak, nonatomic) MSOutlookMessage* currentMsg;
@property (weak, nonatomic) NSString *token;
@property (weak, nonatomic) MSOutlookClient *client;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *subject;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIWebView *emailBody;
@end
