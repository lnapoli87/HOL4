#import "ViewController.h"
#import <office365_exchange_sdk/office365_exchange_sdk.h>

@interface FolderContentViewController : ViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *folderName;
@property (weak, nonatomic) NSString *token;
@property (weak, nonatomic) MSOutlookClient *client;
@property (weak, nonatomic) MSOutlookFolder* currentFolder;
@property (strong, nonatomic) MSOutlookMessage* currentMsg;

@end
